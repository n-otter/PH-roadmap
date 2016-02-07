function [ ] = dipha_reformat_output( file )
%INPUT: binary file containing persistence diagram output of DIPHA
%OUTPUT: one text file for each homological dimension containing
%the persistence diagram in format
%x_1 y_1
%x_2 y_2
%....
%where for every i the numbers x_i and y_i are the left and right endpoint 
% of an interval, respectively.
%
% Nina Otter, Oxford February 2016

%Load persistence diagram: births(i) deaths(i) is an interval in homological
% dimension dims(i)
% If dims(i)<0 then births deaths(i) is an infinite interval in homological
% dimension -dims(i)-1.

addpath('./DIPHA/')
[dims,births, deaths]=load_persistence_diagram(file);

m=size(dims);
% If an interval births(i) deaths(i) is infinite we redefine dims(i) as 
% -dims(i)-1 and we set deaths(i)=-1
for i=1:m
    if dims(i)<0
        dims(i)=-dims(i)-1;
        deaths(i)=-1;
    end
end

%Maximum homological dimension
N=max(dims);

%Initialise output files
file_ids=zeros(1,N);
for i=0:N
    filename=[file,'intervals_',num2str(i),'.txt'];
    file_ids(i+1)=fopen(filename,'w');
end

%Write intervals to output files
for i=1:m
  k=dims(i);
  interval=[num2str(births(i)),' ',num2str(deaths(i)),'\n'];
  fprintf(file_ids(k+1), interval);
end

%Close all files
for i=0:N
    fclose(file_ids(i+1));
end



end

