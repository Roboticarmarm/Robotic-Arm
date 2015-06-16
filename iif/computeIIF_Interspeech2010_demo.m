% 2011-02-04 Florian Mueller, mueller@isip.uni-luebeck.de
% Last updated: $Date: 201/02/04 12:04$

% this scripts assumes to be executed with the working folder set to the "demo"-folder! 

% Gammatone-like spectrogram toolbox by D. Ellis has to be provided:
% D. P. W. Ellis (2009). "Gammatone-like spectrograms", 
% web resource. http://www.ee.columbia.edu/~dpwe/resources/matlab/gammatonegram/
clear;clc;
addpath('./gammatonegram'); % adopt path to your settings
addpath('../'); % the moethod for IIF computation is lcoated in the parent folde

% exemplary call of computeIIF_Interspeech2010:

% read demo signal
[signal samplerate] = wavread('sa2.wav'); 

% load IIF parameter set. Here, parameters for 30 IIFs of order 1 are loaded.
% They basically compute local means of the spectral values here.
load('./iifset30.mat','iifset30');

% compute invariant-integration features
% exemplary call here with optional parameter 'samplerate'
iif = computeIIF_Interspeech2010(signal,iifset30,'samplerate',16000);

% IIFs are highly correlated. Usually a dimension-reducing and decorrelating transformation is followed, 
% e.g., LDA and MLLT

% visualize IIFs
subplot(2,1,1);
imagesc(iif(:,1:30)'), xlabel('# frames'), ylabel('Component #');
title('IIFs only');

subplot(2,1,2);
imagesc(iif'), xlabel('# frames'), ylabel('Component #');
title('IIFs with energy as last component');

% For each IIF-parameter set exist reduction/decorrelating matrices. 
%  - The reducmat_iifset??_MLLT.mat files contain a MLLT matrix. 
%  - The reducmat_iifset??_LDA20.mat files contain a LDA matrix with a final 
%    dimension of 20. 
%  - The reducmat_iifset??_LDA55_MLLT.mat files contain LDA+MLLT matrix with a 
%    final dimension of 55.
% 
% We used the reduction matrices in two diffferent processing chains:
%  1) IIF computation -->> reduction and decorrelation with *LDA55_MLLT.mat matrix.
%  2) IIF computation -->> reduction with LDA20.mat -->> appending of delta features
%        -->> decorrelation with *iifset??_MLLT.mat matrix.
% When MLLR is used within the recognition system, we made the observation that it is
% beneficial to use block constrained MLLR transforms in conjunction with processing 
% chain 2) above. Details can be found in "Florian M\"uller and Alfred Mertins: Contextual 
% Invariant-Integration Features for Improved Speaker-Independent Speech Recognition. 
% Speech Communication, 2011 (accepted)". In the following, we show exemplary reductions
% of an IIF sequence with the corresponding matrices.

% Approach 1)
% -----------

% compute IIFs with log-energy and delta features
iif = computeIIF_Interspeech2010(signal,iifset30,'samplerate',16000,'withdeltas',true);

% load reduction matrix
load('./reducmat_iifset30_LDA55_MLLT.mat');

% normalize to zero mean and unit standard deviation
iif_norm = (iif-repmat(totalmean,size(iif,1),1))./repmat(totalstd,size(iif,1),1);

% compute reduced and decorrelated features
iif_final = iif_norm*Tmllt';

% Approach 2)
% -----------

% compute IIFs with log-energy and without delta features
iif = computeIIF_Interspeech2010(signal,iifset30,'samplerate',16000,'withdeltas',false);

% load reduction matrix
load('./reducmat_iifset30_LDA20.mat');

% normalize to zero mean and unit standard deviation
iif_norm = (iif-repmat(totalmean,size(iif,1),1))./repmat(totalstd,size(iif,1),1);

% compute reduced and decorrelated features
iif_red = iif_norm*Tmllt';

% append delta features
iif_red_delta = appendDeltas(iif_red);

% load MLLT transformation
load('./reducmat_iifset30_MLLT.mat');

% normalize to zero mean and unit standard deviation
iif_red_norm = (iif_red_delta-repmat(totalmean,size(iif,1),1))./repmat(totalstd,size(iif_red_delta,1),1);

% compute reduced and decorrelated features
iif_final2 = iif_red_norm*Tmllt';
