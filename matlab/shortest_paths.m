function [output_file_name] = shortest_paths( filename )
% This function computes shortest path from a weighted network and saves the corresponding distance matrix.

% Input: text file with each line storing a triple 'i j w_{i,j}'
% where i and j are positive integers representing two nodes of the network
% and w_{i,j} is the weight of the edge connecting these nodes. 
% Output: name of text file storing distance matrix.

%Nina Otter, Oxford 2015.


A=load(filename);
H=[A(:,1);A(:,2)];
H=unique(H);
N=length(H);

B=sparse(A(:,1),A(:,2),A(:,3),N,N);
S=B+B';
S=1./S;
S=sparse(S);
D=graphallshortestpaths(S,'Directed',false);


% If some nodes have infinite distance, we define their distance as M*100, where 
% M is the maximum distance value between all nodes having finite distance.
id=D==Inf;
B=-1*ones(N);
D(id)=B(id);
M=max(max(D));
C=M*100*ones(N);
D(id)=C(id);

filename = regexprep(filename,'.txt',''); 
output_file_name=[filename,'_SP_distmat.txt'];
fileID=fopen(output_file_name,'w');

for i=1:N
output_line=sprintf('%8.18f ', D(i,:));
fprintf(fileID,'%s\n',output_line);
end
fclose(fileID);

end
