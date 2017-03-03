function [] = bottleneck_input_for_dionysus(pdg,type)

% This functions prepares input files to compute the bottleneck distance 
% using Dionysus.
% It takes as input formats all format types for persistence diagrams
% as obtained by using Dionysus or Gudhi.
% 
% Input: pdg is text file containing a persistence diagram. 'type' indicates
% the input type, i.e.
% dcech for output of cech complex computation with Dionysus
% alpha, dioVR, dicoh for alpha, VR or dual PH computation with Dionysus 
% gudhi for output of computation with gudhi.
%
% Output: Input file to compute bottleneck distance with Dionysus.
%
% Nina Otter, Oxford September 2015.



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


if (type=='alpha' | type=='dioVR') | type=='dicoh'
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

if type=='gudhi'
   diagram=load(pdg);
    %Maximum homology dimension
    i=max(diagram(:,2))
    file_ids=zeros(1,i+1);
    for j=1:i+1
        filename=[pdg,'_',num2str(j-1),'.txt']
        file_ids(j)=fopen(filename,'w');    
    end
    N=size(diagram,1)
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


if type=='javVR'
    
    
    
end

end


