clc,clear,close all
x=zeros(5);
x(3,3)=1;
x=reshape(x,1,25);
for k=1:25
    i=[];
    a=x(k,:);
    b=reshape(zeros(5),1,25);
    for j=1:25% find ind
        i=[i;j];
    end
[nx,ny]=size(i);
for j=1:nx%update neighbouring cells whoes indices are stored in i()
        if i(j)==1
            if a(i(j)+1)==1
                b(i(j))=1;
            end
        end
        if i(j)==25
            if a(i(j)-1)==1
                b(i(j))=1;
            end
        end
        if i(j)~=1&i(j)~=25
            if xor(a(i(j)-1),a(i(j)+1))
                b(i(j))=1;
            end
        end
    end
    x=[x;b];
    a=b;
end
imagesc(x)