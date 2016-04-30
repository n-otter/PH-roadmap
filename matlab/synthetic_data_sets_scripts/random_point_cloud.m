function [ point_cloud ] = random_point_cloud( N ,d)
% Sample N points uniformly at random from [0,1]^d
%   
%Input: 
% N number of points 
% d dimension
%
%Output: name of text file storing on each line the coordinates of a point.

% Nina Otter, Oxford August 2015

P=rand(N,d)

point_cloud=['random_point_cloud_',num2str(N),'_',num2str(d),'_.txt']
fileID=fopen(point_cloud,'w');

dlmwrite(point_cloud,P,'delimiter',' ');

end

