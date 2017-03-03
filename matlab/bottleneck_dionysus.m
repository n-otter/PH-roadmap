function [  ] = bottleneck_dionysus( pdg1,pdg2 )
%This function prepares files for the computation of the bottleneck distance 
%using the implementation in Dionysus.

%Input: two text files with persistence diagrams in the right format.

%The files are saved to the text files 'diagram1.txt' and 'diagram2.txt'


%Nina Otter, Oxford September 2015.

diagram1=load(pdg1);

diagram2=load(pdg2);

N_1=size(diagram1,1);
N_2=size(diagram2,1);

%Eliminate points on diagonal for diagram1.
temp=zeros(N_1,2);
row_1=1;
for i=1:N_1
 if diagram1(i,1)~= diagram1(i,2)
     temp(row_1,:)=diagram1(i,:);
     row_1=row_1+1;
 end
end
 diagram1=temp(1:row_1-1,:);

%Eliminate points on diagonal for diagram2.
temp=zeros(N_2,2);
row_2=1;
for i=1:N_2
 if diagram2(i,1)~= diagram2(i,2)
     temp(row_2,:)=diagram2(i,:);
     row_2=row_2+1;
 end
end
 diagram2=temp(1:row_2-1,:);

 
 %Substitute -1 with inf
 
 diagram1( diagram1==-1 )=inf; 

 diagram2( diagram2==-1 )=inf;
 
 %Write result to text file
 fileID1=fopen('diagram1.txt','w');
 for i=1:row_1-1
 fprintf(fileID1,'%4.4f',diagram1(i,1));
 fprintf(fileID1,' ');
 fprintf(fileID1,'%4.4f\n',diagram1(i,2));
 end
 fclose(fileID1);
 
 fileID2=fopen('diagram2.txt','w');
 for i=1:row_2-1
 fprintf(fileID2,'%4.4f',diagram2(i,1));
 fprintf(fileID2,' ');
 fprintf(fileID2,'%4.4f\n',diagram2(i,2));
 end
 fclose(fileID2);
 

end

