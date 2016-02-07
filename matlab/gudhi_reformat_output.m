function [ output_args ] = gudhi_reformat_output( input-file )

%This function converts the format of output files given by GUDHI.
%
%INPUT: output text file given by GUDHI  
%OUTPUT: one text file for each homological dimension with each line
%storing left and right endpoint of a given interval.
%
% Nina Otter, Oxford February 2016.

%Load input file
diagram=load(input-file);
 
%Maximum homology dimension
i=max(diagram(:,2))

%Initialise output files
file_ids=zeros(1,i+1);
for j=1:i+1
    filename=[pdg,'_',num2str(j-1),'.txt']
    file_ids(j)=fopen(filename,'w');    
end

N=size(diagram,1);
for r=1:N
   l=diagram(r,2)+1;
   line_1=diagram(r,3);
   line_2=diagram(r,4);
   if line_2 ~= Inf;
   fprintf(file_ids(l),'%4.4f', line_1);
   fprintf(file_ids(l),' ');
   fprintf(file_ids(l),'%4.4f\n', line_2);
   else 
   fprintf(file_ids(l),'%4.4f', line_1);
   fprintf(file_ids(l),' ');
   fprintf(file_ids(l),'%s\n', 'inf');
   end
end

for j=1:i+1
    fclose(file_ids(j));
end
 
end



