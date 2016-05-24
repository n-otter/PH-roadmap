function [  ] = jholes_reformat_output( input_file )
%This function converts the format of output files given by jHoles.
%
%INPUT: output text file given by jHoles  
%OUTPUT: one text file for each homological dimension with each line
%storing left and right endpoint of a given interval.
%
% Nina Otter, Oxford May 2016.


fileID=fopen(input_file,'r');
tline=fgetl(fileID);
i=-1;
input_file=regexprep(input_file,'.txt','');
filename_0=[input_file,'_',num2str(i),'.txt'];
fileID2=fopen(filename_0,'w');
while ischar(tline)
 if regexp(tline,'^\[.*')
     line=regexprep(tline,'\[','');
     line=regexprep(line,'\):.*','');
     line=regexprep(line,',','');
     fprintf(fileID2,line);
     fprintf(fileID2,'\n');
 elseif regexp(tline,'^Dimension')
     i=i+1;
     fclose(fileID2);
     filename=[input_file,'_',num2str(i),'.txt'];
     fileID2=fopen(filename,'w');
 end
 tline=fgetl(fileID);
end

fclose(fileID);
fclose(fileID2);
delete(filename_0);

end



