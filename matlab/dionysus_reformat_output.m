function [ output_args ] = dionysus_reformat_output( input-file, type )

%This function converts the format of output files given by GUDHI.
%
%INPUT:
%input-file: output text file given by dionysus  
%type: indicates the input type, i.e.
% 'dcech' for output of PH computation with the Cech complex 
% 'alpha' for output of PH computation  with the alpha complex 
% 'VR' for output of PH computation with Vietoris-Rips complex
% 'dual' for output of PH computation with Vietoris-Rips complex and dual
% algorithm

%OUTPUT: one text file for each homological dimension with each line
%storing left and right endpoint of a given interval.
%
% Nina Otter, Oxford February 2016.


if type=='dcech'
  fileID=fopen(pdg,'r')
  tline=fgetl(fileID);
  i=0;
  filename=[pdg,'_',num2str(i),'.txt']
  fileID2=fopen(filename,'w');
  tline=fgetl(fileID);

  while ischar(tline)
    if  length(tline)>1
        fprintf(fileID2,tline);
        fprintf(fileID2,'\n');
        tline=fgetl(fileID2);
    elseif length(tline)==1
        i=i+1;  
        fclose(fileID2);
        filename=[pdg,'_',num2str(i),'.txt']
        fileID2=fopen(filename,'w');
    end
     tline=fgetl(fileID);
  end
  fclose(fileID); 
  fclose(fileID2);
end


if (type=='alpha' | type=='VR') | type=='dual'
    diagram=load(pdg);
    %Maximum homology dimension
    i=max(diagram(:,1));
    file_ids=zeros(1,i+1);
    for j=1:i+1
        filename=[pdg,'_',num2str(j-1),'.txt'];
        file_ids(j)=fopen(filename,'w');    
    end
    N=size(diagram,1);
    for r=1:N
       l=diagram(r,1)+1;
       line_1=diagram(r,2);
       line_2=diagram(r,3);
       if line_2 ~= Inf;
       fprintf(file_ids(l),'%4.4f', line_1);
       fprintf(file_ids(l),' ');
       fprintf(file_ids(l),'%4.4f\n', line_2);
       else 
       fprintf(file_ids(l),'%4.4f', line_1);
       fprintf(file_ids(l),' ');
       fprintf(file_ids(l),'%s\n', 'inf');
       end
%        fprintf(file_ids(l),'%4.4f', diagram(r,2));
%        fprintf(file_ids(l),' ');
%        fprintf(file_ids(l), '%4.4f\n',diagram(r,3));
    end
    for j=1:i+1
         fclose(file_ids(j));
     end 
end
end

