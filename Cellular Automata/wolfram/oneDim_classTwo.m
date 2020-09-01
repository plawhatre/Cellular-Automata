clc,clear,close all
x=zeros(5);
x(3,3)=1;
x=reshape(x,1,25);
for k=1:10
i=[];
a=x(k,:);
for j=1:25% find indices where cell value is 1 
    if a(j)==1
        i=[i;j];
    end
end
[nx,ny]=size(i);
for j=1:nx%update neighbouring cells whoes indices are stored in i()
    if i(j)==1
        a(i(j))=0;
        a(i(j)+1)=1;
    end
    if i(j)==25
        a(i(j)-1)=1;
        a(i(j))=0;
    end
    if i(j)~=1&i(j)~=25
        a(i(j)-1)=1;
        a(i(j))=0;
        a(i(j)+1)=1;
    end
end
x=[x;a];
end
imagesc(x)