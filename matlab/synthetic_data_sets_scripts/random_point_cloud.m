function [ output_args ] = random_point_cloud( N ,d)
%This function outputs N points sampled uniformly at random from [0,1]^d
% 
%   
%Input: N number of points 
% d dimension
%
%Output: text file with on each line the coordinates of a points 

% Nina Otter, Oxford August 2015

P=rand(N,d)


point_cloud=['random_point_cloud_',num2str(N),'_',num2str(d),'_.txt']
fileID=fopen(point_cloud,'w');

dlmwrite(point_cloud,P,'delimiter',' ');

end

