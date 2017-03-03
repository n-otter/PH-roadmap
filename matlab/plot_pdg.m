function [] = plot_pdg( filename,header )
% Input: text file with persistence diagram for
% a given homological dimension, one birth death pair per line
% Output: plot of the persistence diagram
%
% Nina Otter, Oxford February 2016.

%Load file containing persistence diagram
intervals=load(filename);
filename=regexprep(filename,'.txt',''); 

% Substitute inf with -1
intervals(intervals==inf)=-1;


% Extract maximum and minimum death time encountered:
maxd = max(intervals(:,2));
minb=min(intervals(:,1));
maxb=max(intervals(:,1));
if (maxd < 0) 
    maxd = maxb+1;
end

if (minb == maxd)
    maxd = maxd+1;
end

e=(maxd-minb)/10;

[rows,indices,indices]=unique(intervals,'rows');
occurrence=accumarray(indices,1);



N=size(rows,1);
h=figure;

for i=1:N

    a=rows(i,1);
    b=rows(i,2);
    m=50*occurrence(i);

    if b~=-1
        scatter(a,b,m,'filled','MarkerEdgeColor',[0.5 0 0.5],...
            'MarkerFaceColor',[0.5 0 0.5]);
        hold on
    else scatter(a,maxd+e,m,'filled','s','MarkerEdgeColor',[0 0.6 0.6],...
            'MarkerFaceColor',[0 0.6 0.6]);
     
        hold on
    end
    hold on;
end

%Create plot
title(header);
xlabel('birth');
ylabel('death');
axis([0 maxd+e 0 maxd+e])
%Plot diagonal
x=linspace(0,maxd+e,200);
plot(x,x,'Color',[0.5 0 0.5]);

%Save plot
plot_name=[sprintf(filename) '.pdf'];
saveas(h, plot_name);

end
