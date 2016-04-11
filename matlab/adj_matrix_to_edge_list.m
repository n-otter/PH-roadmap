function [ output_args ] = adj_matrix_to_edge_list( D ,filename)
%INPUT: adjacency matrix in .mat format
%OUTPUT: weighted edge-list in .txt format

%Nina Otter
load(D);
M=sen;
if issymmetric(M)
    T=triu(M);
else
    M=M+M';
    T=triu(M);
end

[x,y]=find(T);
weights=[x,y];
E=nnz(M)/2;

save_file_name=[filename,'_edge_list.txt'];

fileID=fopen(save_file_name,'w');

for i=1:E
line=[num2str(weights(i,1)),' ',num2str(weights(i,2)),' ',...
      num2str(T(weights(i,1),weights(i,2)))];
fprintf(fileID,'%s\n',line);
end

fclose(fileID);

end

