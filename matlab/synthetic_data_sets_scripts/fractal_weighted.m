function [ output_file_name,output_file_name_2 ] = fractal_weighted( n,b,k,type)
% Input:        n: total number of nodes of the graph is 2^n
%               b: initial number of nodes is 2^b
%               k: this is the connection density parameter.
%               type: indicates how we assign weights to the edges
%               this is either 'random', 'linear' or 'wh_one' (see 'A
%               roadmap for the computation of persistent homology'
%               for details).
% Output:       output_file_name: name of text file with adjacency matrix
%               output_file_name_2: name of text file with edge list

% 
% Nina Otter, Oxford 2015-2016.


%We start off with a complete network on 2^b nodes. This is hierarchical
% level e=0
A=ones(2^b)-eye(2^b);
e=0;


for h=b:n-1
    
    %The next hierarchical level
    e=e+1;
    %Take two copies of network created in previous step
    A=blkdiag(A,A);
    %We compute the cartesian product of the sets {1,...,2^h}
    % and {2^h+1,...,2^(h+1)}
    n_1=[1:2^h];
    n_2=[2^h+1:2^(h+1)];
    [X,Y]=meshgrid(n_1,n_2);
    T=[X(:),Y(:)]; 
    %We compute m which is the number of edges connecting the 
    %two groups. The total possible number of edges between the two groups
    %is 2^(2*h) and so the connecting edge density k^(-e) equals m/2^(2*h).
    m=k^(-e)*2^(2*h);
    %Round m to the closest integer.
    m=round(m);
    %We choose m elements from the cartesian product T
    %uniformly at random
    C=datasample(T,m,'Replace',false);
    
    %Store edges connecting the two groups:
    l=size(C,1);
    for i=1:l
        %We store the m edges by setting the entries of A corresponding to
        % the m elements to 1
        linearindex = sub2ind(size(A),C(i),C(i+l));
        A(linearindex)=1;
        %We store 1 also in the entries of the transposed of A
        %corresponding to the m elements, since the edges are undirected.
        linearindex_transposed=sub2ind(size(A),C(i+l),C(i));
        A(linearindex_transposed)=1;
    end
   
end


%Number of nodes
N = length(A(1,:));

%Number of edges
E=nnz(A)/2;

%Density
D=nnz(A)/(N*(N-1));
%X=rand(N,2);
%gplot(A,X);

%Assign weight to edges
%RANDOM

T=triu(A);
[x,y]=find(T);
weights=[x,y];
if type=='random'
    for i=1:E
        T(weights(i,1),weights(i,2))=rand(1,1);
    end

    output_file_name=['fractal_',num2str(n),'_',num2str(b),'_',num2str(k),...
    '_random_.txt'];
    output_file_name_2=['fractal_',num2str(n),'_',num2str(b),'_',num2str(k),...
    '_random_edge_list.txt'];


%LINEAR
elseif type=='linear'
    degree=zeros(N,1);
    for i=1:N
        degree(i)=sum(A(i,:));
    end
    for i=1:E
    T(weights(i,1),weights(i,2))=...
        degree(weights(i,1))*degree(weights(i,2))*rand(1,1);
    end
    output_file_name=['fractal_',num2str(n),'_',num2str(b),'_',num2str(k),...
    '_linear_.txt'];
    output_file_name_2=['fractal_',num2str(n),'_',num2str(b),'_',num2str(k),...
    '_linear_edge_list.txt'];

%WEIGHT ONE on every edge
elseif type=='wh_one'
    %do nothing
    output_file_name=['fractal_',num2str(n),'_',num2str(b),'_',num2str(k),...
    '_weight_one_.txt'];
    output_file_name_2=['fractal_',num2str(n),'_',num2str(b),'_',num2str(k),...
    '_weight_one_edge_list.txt'];
end

D=T+transpose(T);


fileID=fopen(output_file_name,'w');
fileID_2=fopen(output_file_name_2,'w');

for i=1:E
  line=[num2str(weights(i,1)),' ',num2str(weights(i,2)),' ',...
      num2str(T(weights(i,1),weights(i,2)))];
  fprintf(fileID_2,'%s\n',line);
end

fclose(fileID_2);

for i=1:N
output_line=sprintf('%8.18f ', D(i,:));
fprintf(fileID,'%s\n',output_line);
end
fclose(fileID);

end
