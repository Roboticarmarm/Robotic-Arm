function [ iif_final ] = genIIF( input_wav, method)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
addpath('./gammatonegram');
[signal, samplerate] = wavread(input_wav);
load('iifset30.mat','iifset30');

if(method == 1)
    iif = computeIIF_Interspeech2010(signal,iifset30,'samplerate',samplerate,'withdeltas',true);
    load('./reducmat_iifset30_LDA55_MLLT.mat');
    iif_norm = (iif-repmat(totalmean,size(iif,1),1))./repmat(totalstd,size(iif,1),1);
    iif_final = iif_norm*Tmllt';
elseif(method == 2)
    iif = computeIIF_Interspeech2010(signal,iifset30,'samplerate',samplerate,'withdeltas',false);
    load('./reducmat_iifset30_LDA20.mat');
    iif_norm = (iif-repmat(totalmean,size(iif,1),1))./repmat(totalstd,size(iif,1),1);
    iif_red = iif_norm*Tmllt';
    iif_red_delta = appendDeltas(iif_red);
    load('./reducmat_iifset30_MLLT.mat');
    iif_red_norm = (iif_red_delta-repmat(totalmean,size(iif,1),1))./repmat(totalstd,size(iif_red_delta,1),1);
    iif_final = iif_red_norm*Tmllt';
end
csvwrite('iif.csv',iif_final);
end

