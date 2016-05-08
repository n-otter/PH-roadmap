function [ ] = witness_javaPlex( filename, max_dimension,...
    num_landmark_points, type, filtr_steps)

% This function computes PH with the witness complex calling javaPlex 
% scripts.

% Input: 
% filename: text file with point cloud, one point per line.
% 
% max_dimension: This is an upper bound for the simplicial complex that we
% construct; only simplices up to dimension max_dimension will be
% constructed.
% 
% num_landmark_points: This is the number of landmark points.
%
% type: this indicated how to choose the landmark points:
% type='random' the points are chosen at random
% type='maxmin' the points are chosen using the sequential maxmin selector
%
% filtr_steps: number of filtration steps. The initial filtration step is 
% zero by default.
%

% Output: text file with intervals, one file for each
% homological dimension. These are the files ending with i_right_format.txt
% where i=0,...,max_dimension indicates the homological dimension.


% Nina Otter, Oxford September 2015. 


import edu.stanford.math.plex4.*;
import java.util.*;
warning('off','all')

%Load input file
point_cloud=load(filename);

% Choose the landmark points from the point cloud, this will be at random or
% using minmax, depending if type='random' or type='maxmin'.
if type=='random'
landmark_selector = api.Plex4.createRandomSelector(point_cloud,...
    num_landmark_points);
end

if type=='maxmin'
landmark_selector = api.Plex4.createMaxMinSelector(point_cloud,...
    num_landmark_points)
random_points = point_cloud(landmark_selector.getLandmarkPoints() + 1, :);
end

% We will compute the witness complex up to maximum distance R (see tutorial
% at http://appliedtopology.github.io/javaplex/ for details)
% 
R = landmark_selector.getMaxDistanceFromPointsToLandmarks();

% Create a witness stream
stream = api.Plex4.createWitnessStream(landmark_selector, max_dimension, R,...
filtr_steps);

% Size of filtered complex. Remove the semicolon to print out the size of the
% complex.
stream.getSize();


% Get persistence algorithm over Z/2Z
persistence = api.Plex4.getModularSimplicialAlgorithm(max_dimension, 2);

% Compute the intervals
intervals = persistence.computeIntervals(stream)


% Save intervals to text file, one text file for each homological dimension
for i=0:max_dimension
    output_intervals=[filename,'_W_intervals','_',num2str(i),'.txt'];
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
    filename_old=[filename,'_W_intervals','_',num2str(i),'.txt'];
    fileID=fopen(filename_old,'r');
    filename_formatted=[filename,'_W_intervals','_',num2str(i),'_','right_format','.txt'];
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

