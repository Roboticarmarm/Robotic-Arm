addpath('gammatonegram');
[AAA] = textread('../total_wav_list','%s');
fileID = fopen('all.ark','w');
xd = size(AAA);
load('iifset30.mat','iifset30');
load('reducmat_iifset30_LDA55_MLLT.mat');
for i = 1:xd
    gg = char(AAA(i));
    gg = gg(1:end-4)
    [d,sr] = wavread(char(strcat('../',AAA(i))));
    iif = computeIIF_Interspeech2010(d,iifset30,'samplerate',16000,'withdeltas',true);
    iif_norm = (iif-repmat(totalmean,size(iif,1),1))./repmat(totalstd,size(iif,1),1);
    iif_final = iif_norm*Tmllt';
    lol = size(iif_final);
    for j = 1: lol(1)
        nbytes = fprintf(fileID,'%s_%d %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n',gg,j,iif_final(j,:));
    end
end