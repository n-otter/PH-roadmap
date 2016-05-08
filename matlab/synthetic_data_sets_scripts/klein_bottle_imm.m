
function [output_file_name_1,output_file_name_2] = klein_bottle_imm(N)

% With this function one can sample N^2 points from the image
% of the immersion of the Klein bottle in R^3
% 
% Input: number N

% Output:
% output_file_name_1: name of text file storing distance matrix
% output_file_name_2: name of text file storing point cloud, with one point per line

% Nina Otter, Oxford September 2015

%If no input value is provided compute point cloud of size 100
if nargin < 1
   N = 10;
end



%Parameters
r=3;
a=0;
b=2*pi;

%Sample N points uniformly at random from (0,2pi)^2
u = (b-a).*rand(N,1) + a;
v = (b-a).*rand(N,1) + a;

%Alternatively, sample points linearly (choose this is if you want to get a nice
%plot)
%u=linspace(0,2*pi,N);
%v=linspace(0,2*pi,N);

[u,v]=meshgrid(u,v);


%Figure eight embedding: parametric equations
x=(r+cos(u/2).*sin(v)-sin(u/2).*sin(2*v)).*cos(u);
y=(r+cos(u/2).*sin(v)-sin(u/2).*sin(2*v)).*sin(u);
z=sin(u/2).*sin(v)+cos(u/2).*sin(2*v);

%Uncomment to create plot
%surf(x,z,y);
%axis square
%axis off
%grid off
%set(gca,'LooseInset',get(gca,'TightInset'))


%Point cloud
points=[x(:),y(:),z(:)];

%Save point cloud to .mat file
output_file_name_1=['klein_bottle_',num2str(N^2),'.mat'];
save(output_file_name_1,'points', 'N' );

%Save point cloud to text file
output_file_name_2=['klein_bottle_pointcloud_',num2str(N^2), '.txt'];
fileID=fopen(output_file_name_2,'w');
n=length(x(:));
for i=1:n
output_line=sprintf('%4.8f ', points(i,:));
fprintf(fileID,'%s\n',output_line);
end
fclose(fileID);

end
