function [ d ] = run_dtw( file1, file2, w )

a = csvread(file1);
b = csvread(file2);
d=dtw_c(a,b,w);
fprintf('%f',d);
end

