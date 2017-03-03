function [plot_name] = plot_barcodes( filename,header )
% Input: 
% filename text file with persistence diagram for a given homological dimension, one birth death pair per line
% header title for plot
%
% Output: pdf file with plot of barcodes
%
% Nina Otter, Oxford September 2015.

%Load file containing persistence diagram
intervals=load(filename);
filename=regexprep(filename,'.txt',''); 

% Substitute inf with -1
intervals(intervals==inf)=-1

% Extract maximum and death and birth time encountered:
maxd = max(intervals(:,2));
minb=min(intervals(:,1));
maxb=max(intervals(:,1));
if (maxd < 0) 
    maxd = maxb+1;
end


%The following piece of code counts the number of times an interval occurrs
[rows,indices,indices]=unique(intervals,'rows');
occurrence=accumarray(indices,1);

%Order by increasing births
rows=sortrows(rows);
N=size(rows,1);
h=figure;
j=1;
for i=1:N %loop over all intervals
    a=rows(i,1);
    b=rows(i,2);
    m=occurrence(i);
    if b ~= -1 %First we plot the finite intervals
    S=ceil(b-a)+2;
    x=linspace(a,b,S);
    for k=j:m+j-1;
    y=k*ones(1,S);
    plot(x,y,'b', 'LineWidth',5); 
    box off
     axis([0 maxd 0 sum(occurrence)]);
     hold on;
    end
    hold on;
    else S=ceil(maxd-a)+2; %Now we plot the infinite intervals
        x=linspace(a,maxd,S)
        for k=j:m+j-1;
            y=k*ones(1,S);
            %plot(x,y,'b','LineWidth',5);
            hold on;
            %Set parameters for arrowheads, so that they scale with the axes of the plot
            epsilon1=0.02*maxd;
            epsilon2=0.02*sum(occurrence);
            %Plot arrowheads 
            v=[maxd k ; maxd-epsilon1 k-epsilon2; maxd+epsilon1 k; maxd-epsilon1 k+epsilon2];
            f=[1 2 3 4];
            outside_arrowhead=patch('Faces',f,'Vertices',v,'EdgeColor','b','FaceColor','b','LineWidth',3);
            hold on
            outside_line=plot([0,maxd+epsilon1],[k,k],'b','LineWidth',5);
            hold on
            set(outside_arrowhead,'Clipping','off');
            set(outside_line,'Clipping','off');
        end
    end
 j=j+m;
 hold on;
end

%Label plot and x axis
title(header);
xlabel('filtration step');

%Save plot
plot_name=[sprintf(filename),'_barcodes','.pdf'];
saveas(h, plot_name);

end

