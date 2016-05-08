
function []=vietoris_rips_javaplex(filename,max_dimension,max_filtration_value,...
    number_steps)

% This function computes PH with the VR complex calling javaPlex scripts.

% Input: 
% filename: text file with point cloud, one point per line.
%
% max_dimension: This is an upper bound for the simplicial complex that we
% construct; only simplices up to dimension max_dimension will be
% constructed.
%
% max_filtration_value: we construct the vietoris rips complex up to this
% value for its parameter.
% 
% number_steps: number of filtration steps. The initial filtration step is 
% zero by default.


% Output: text file with intervals, one file for each
% homological dimension. These are the files ending with i_right_format.txt
% where i=0,...,max_dimension indicates the homological dimension.

% Nina Otter, Oxford September 2015. 

clc
import edu.stanford.math.plex4.*;
warning('off','all')

% Load the input file
point_cloud = load(filename);
filename = regexprep(filename,'.txt',''); 

% Create a Vietoris-Rips stream 
stream = api.Plex4.createVietorisRipsStream(point_cloud, max_dimension,...
    max_filtration_value, number_steps);
num_simplices = stream.getSize()


% Get the default persistence algorithm
persistence =api.Plex4.getModularSimplicialAlgorithm(max_dimension, 2);

% Compute intervals
intervals = persistence.computeIntervals(stream);

% Save intervals to text file, one text file for each homological dimension
for i=0:max_dimension
    output_intervals=[filename,'_intervals','_',num2str(i),'.txt'];
    % Delete file in case it already exists, since diary appends output
    % at the end of existing files.
    delete(output_intervals);
    diary(output_intervals)
    intervals.getIntervalsAtDimension(i)
    diary off
end

% Modify the output text files, so that they are in the right format,
% that is, we have an interval per line
% a_0 a_1
% b_0 b_1
%
for i=0:max_dimension
    filename_old=[filename,'_intervals','_',num2str(i),'.txt'];
    fileID=fopen(filename_old,'r');
    filename_formatted=[filename,'_intervals','_',num2str(i),'_','right_format','.txt'];
    fileID_formatted=fopen(filename_formatted,'w');
    line=fgetl(fileID); 
    while ischar(line)
        if length(line)> 1
        line=regexprep(line,'ans =', '');
        line=regexprep(line,'\[','');
        line=regexprep(line,'\), ','\n');
        line=regexprep(line,',','');
        line=regexprep(line,'\)\]','');
        line=regexprep(line,'\]','');
         line=regexprep(line,'infinity','inf');
        if length(line)>0
        fprintf(fileID_formatted,line);
        end
        end
    line=fgetl(fileID);
    end
    fclose(fileID_formatted);
end
fclose(fileID);

end
