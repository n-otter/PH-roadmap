<<<<<<< HEAD
function [] = shortest_paths( filename )
%Input: text file with each line storing a triple 'i j w_{i,j}'
% where i and j are positive integers representing two nodes of the network
%and w_{i,j} is the weight of the edge connecting these nodes. 
%Output: text file storing matrix with shortest distances between all nodes
%

%Nina Otter, Oxford.
=======
function [N,D] = shortest_paths( filename )
%Input: weighted edge list text file 
%Output: matrix with shortest distances between all nodes
%and maximum non 
>>>>>>> eb56a33b5c8c4de15fb125fcfccd70a92503405d

A=load(filename);
H=[A(:,1);A(:,2)];
H=unique(H);
N=length(H);

B=sparse(A(:,1),A(:,2),A(:,3),N,N);
S=B+B';
S=1./S;
S=sparse(S);
D=graphallshortestpaths(S,'Directed',false);

id=D==Inf;


B=-1*ones(N);
D(id)=B(id);

M=max(max(D))
C=M*100*ones(N);
D(id)=C(id);
output_file_name=[filename,'_maxdist_',num2str(M),'_SP_distmat.txt'];
fileID=fopen(output_file_name,'w');

for i=1:N
output_line=sprintf('%8.18f ', D(i,:));
fprintf(fileID,'%s\n',output_line);
end
fclose(fileID);

end
