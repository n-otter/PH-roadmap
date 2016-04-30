function [plot_name] = plot_barcodes( filename,header )
% Input: text file with persistence diagram for
% a given homological dimension, one birth death pair per line
% Output: pdf file with plot of barcodes
%
% Nina Otter, Oxford September 2015.

%Load file containing persistence diagram
intervals=load(filename);

% Substitute inf with -1
intervals(intervals==inf)=-1

% Extract maximum death time encountered:
maxd = max(intervals(:,2));
minb=min(intervals(:,1));
if (maxd < 0) 
    maxd = max(A)+1
end

if (minb == maxd)
    maxd = maxd+1;
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
     axis([0 maxd 0 sum(occurrence)]);
     hold on;
    end
    hold on;
    else S=ceil(maxd-a)+2; %Now we plot the infinite intervals
        maxd
        x=linspace(a,maxd,S)
        for k=j:m+j-1;
            y=k*ones(1,S);
            plot(x,y,'b','LineWidth',5);
            hold on;
            outside_1=plot([maxd+0.05,maxd-0.05],[k,k+0.4],'b','LineWidth',5);
            hold on
            outside_2=plot([maxd+0.05,maxd-0.05],[k,k-0.4],'b','LineWidth',5);
            hold on
            outside_3=plot([maxd,maxd+0.05],[k,k],'b','LineWidth',5);
            hold on
            set(outside_1,'Clipping','off');
            set(outside_2,'Clipping','off');
            set(outside_3,'Clipping','off');
        end
    end
 j=j+m;
 hold on;
end

%Label plot and x axis
title(header);
xlabel('filtration step');

%Save plot
plot_name=[sprintf(filename) '.pdf'];
saveas(h, plot_name);

end

