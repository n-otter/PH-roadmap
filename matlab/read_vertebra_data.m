fileID=fopen('vertebra16.raw','r');

A=fread(fileID,512*512*512,'int16');

B=reshape(A,[512 512 512]);

B = B / max(B(:));
