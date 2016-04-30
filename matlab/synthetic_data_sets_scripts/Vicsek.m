function [  ] = vicsek(N,R,n,v_0,l,T )
% This function implements the Vicsek model for biological aggregations  
% in the way it appears in the paper 'Topological
% Data Analysis of Biological Aggregation Models'.
% 

%Input: N is the number of particles
%       R is the interaction radius
%       n is the noise
%       v_0 is the fixed particle speed
%       l the box size
%       delta_t the time step
%       T is an integer specifying the number of time steps starting from 
%        t_0.
        
%Output: this function saves the produced point clouds in T different text
%files, one text file for each time step

%Nina Otter, May 2015, Oxford.

%Initialisation
X=zeros(N,2,T);
Theta=zeros(N,T);
D=zeros(N,N,T);
v=zeros(N,2,T);

%U=-n/2+n*rand(1,1);
%Intial condition
r=rand(N,2);
l*r(:,1)
X(1,1,1)
for i=1:N
    X(i,1,1)=l*r(i,1);
    X(i,2,1)=l*r(i,2);
    Theta(i,1)=2*pi*rand(1,1); 
    v(i,1,1)=v_0*cos(Theta(i,1));
    v(i,2,1)=v_0*sin(Theta(i,1));
end

D_1 = pdist(X(:,:,1)); %make a vector with stored distances from one point 
% to the other
Z=squareform(D_1); %make a square matrix with distance from i to j 
% in component (i,j)
for i=1:N
    for j=1:N
        D(i,j,1)=Z(i,j);
    end
end

for t=2:T
    for i=1:N 
        for j=i+1:N
            if D(i,j,t-1)<=R
                Theta(i,t)=Theta(i,t)+Theta(j,t-1);
            end
        end
        Theta(i,t)=Theta(i,t)/N+(-n/2+n*rand(1,1));
        v(i,1,t)=v_0*cos(Theta(i,t));
        v(i,2,t)=v_0*sin(Theta(i,t));
        X(i,1,t)=X(i,1,t-1)+v(i,1,t);
        X(i,1,t)=mod(X(i,1,t),l);
        X(i,2,t)=X(i,2,t-1)+v(i,2,t);
        X(i,2,t)=mod(X(i,2,t),l);
    end
end
P=zeros(N,3,T);
for t=1:T
P(:,:,t)=[X(:,1,t),X(:,2,t),Theta(:,t)];

output_name=['Vicsek_','_particles_',num2str( N),'_distance_',num2str(R),'_noise_',num2str(n),...
   '_v0_',num2str(v_0),'_box_',num2str(l),'_timestep_',num2str(t),'_of_',num2str(T), '.txt'];
fileID=fopen(output_name,'w');

dlmwrite(output_name,P(:,:,t), 'delimiter', ' ');

fclose(fileID);
end

end

