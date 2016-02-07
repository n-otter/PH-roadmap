function [N,D] = shortest_paths( filename )
%Input: weighted edge list text file 
%Output: matrix with shortest distances between all nodes
%and maximum non 

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
