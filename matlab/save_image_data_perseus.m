function [  ] = save_image_data_perseus( M ,filename)
% This function creates an input file to compute PH with cubical 
% complexes in perseus
%
%INPUT: 
% M is a .mat file storing grey-scale values for d-dimensional image data set
% filename is the name of the output text file
% 
%OUTPUT: text file in right format for the computation with perseus, with 
% the cubtop option.
% 

% Nina Otter, Oxford April 2016


fileID=fopen(filename,'w');

M=M+1;

dimensions=size(M);
d=length(dimensions);
N=1;

fprintf(fileID, num2str(d));
fprintf(fileID,'\n');

for i=1:d
    fprintf(fileID, num2str(dimensions(i)));
    fprintf(fileID,'\n');
    N=N*dimensions(i);
end
for i=1:N
fprintf(fileID, num2str(M(i)));
fprintf(fileID,'\n');
end
fclose(fileID);
end

