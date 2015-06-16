addpath('gammatonegram');
[AAA] = textread('../total_wav_list','%s');
fileID = fopen('iif2_all.ark','w');
xd = size(AAA);
load('iifset30.mat','iifset30');

for i = 1:xd
    gg = char(AAA(i));
    gg = gg(1:end-4)
    [d,sr] = wavread(char(strcat('../',AAA(i))));
    iif = computeIIF_Interspeech2010(d,iifset30,'samplerate',16000,'withdeltas',false);
    load('reducmat_iifset30_LDA20.mat');
    iif_norm = (iif-repmat(totalmean,size(iif,1),1))./repmat(totalstd,size(iif,1),1);
    iif_red = iif_norm*Tmllt';
    iif_red_delta = appendDeltas(iif_red);
    load('reducmat_iifset30_MLLT.mat');
    iif_red_norm = (iif_red_delta-repmat(totalmean,size(iif,1),1))./repmat(totalstd,size(iif_red_delta,1),1);
    iif_final2 = iif_red_norm*Tmllt';
    lol = size(iif_final2);
    for j = 1: lol(1)
        nbytes = fprintf(fileID,'%s_%d %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n',gg,j,iif_final2(j,:));
    end
end
