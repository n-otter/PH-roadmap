function [] = plot_barcodes( filename,header )
% Input: text file with persistence diagram for
% a given homological dimension, one birth death pair per line
% Output: plot of barcodes
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


[rows,indices,indices]=unique(intervals,'rows');

occurrence=accumarray(indices,1)
%disp([occurrence,rows]);
size(occurrence)
size(rows)
%new_interv=(occurrence>0);
%intervals;
%intervals=intervals(new_interv);
%occurrence=occurrence(new_interv);

%Order by increasing births
rows=sortrows(rows)
N=size(rows,1);
h=figure
j=1;
for i=1:N
    a=rows(i,1)
    b=rows(i,2)
    m=occurrence(i);
    if b ~= -1
    S=ceil(b-a)+1;
    x=linspace(a,b,S);
    for k=j:m+j-1;
    y=k*ones(1,S)
    plot(x,y,'b', 'LineWidth',3); 
     axis([0 maxd-minb+1 0 sum(occurrence)]);
     hold on;
    end
    hold on;
    else S=ceil(maxd-a)
        x=linspace(a,maxd+20,S*100)
        for k=j:m+j-1;
            y=k*ones(1,S*100)
        plot(x,y,'b','LineWidth',2);
         %axis([0 25 0 15]);
        %hold on;
    end
   
    end
 j=j+m;
 hold on;
end

%Create plot
title(header);
xlabel('filtration step');

%Save plot
plot_name=[sprintf(filename) '.pdf'];
saveas(h, plot_name);

end

