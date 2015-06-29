function [ class ] = dtw_classify( file )

cd ../iif
test=genIIF(file,1,'iif.csv');
cd ../dynamic_time_warping_v2.1/
w=50;
best_d = 10000;

list=dir('../feature/*.csv');
addpath('../feature');
for i = 1:length(list)
    file=list(i).name;
    template = csvread(file);
    d=dtw_c(test,template,w);
    if d < best_d
        best_d = d;
        class = strtok(file,'_');
    end
    fprintf([file ' d=' num2str(d) '\n']);
end

display (class)

end

