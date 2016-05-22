 function [ D] = edgelist_to_point_cloud( filename,type )
%Input: weighted edge list text file 
%type is either 'inv', 'dir' or 'dis' where for inv we take the inverse of the
%edge weights,  for 'dir' we take the edge weights as they are, for 'dis' we take
% the edge weights as 1-weights.
%Output: matrix with coordinates of points embedded using distances between all nodes
% where the distance is given by computing shortest paths.

%Nina Otter, Oxford 2015.

A=load(filename);
H=[A(:,1);A(:,2)];
H=unique(H);
N=length(H)

if type=='inv'
A(:,3)=1./A(:,3);
elseif type=='dir'
    %do nothing
elseif type=='dis'
A(:,3)=1-A(:,3);
end

B=sparse(A(:,1),A(:,2),A(:,3),N,N)
%B(1,1)
B=sparse(full(B)+full(B)');
D=graphallshortestpaths(B,'Directed',false);
issymmetric(D)
% id=D==Inf;
% 
% 
% B=-1*ones(N);
% D(id)=B(id);
% 
 M=max(max(D));
% C=M*100*ones(N);
% D(id)=C(id);

Y = cmdscale(D);
%i=max(max(Y));


%formatSpec='%8.25f %8.25f %8.25f\n';


P=size(Y,2);
%output_lines=zeros(N,P);

%Output the point cloud
output_file_name=[filename,'_',num2str(M),'_point_cloud.txt']
fileID=fopen(output_file_name,'w');
for i=1:N
output_line=sprintf('%8.18f ', Y(i,:));
fprintf(fileID,'%s\n',output_line);
end

%Output the distance matrix
dist_mat=[filename,'_',num2str(M),'_distmat.txt']
fileID_2=fopen(dist_mat,'w');
dlmwrite(dist_mat,D,'delimiter',' ');
% for i=1:N
% output_line_2=sprintf('%8.2f ', D(i,:));
% fprintf(fileID_2,'%s\n',line);
%end
%dlmwrite(output_file_name,Y, 'delimiter', '\t','precision',8);

%dlmwrite(output_file_name,output_lines, 'delimiter', '\n');
fclose(fileID);
fclose(fileID_2);
%M=zeros(m,1);
%for i=1:m
 %   M(i)=max(D(~isinf(D(:,i)),i));
%end

    
    
end
