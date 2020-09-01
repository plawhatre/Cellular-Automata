clc,clear,close all
x=zeros(5);
x(3,3)=1;
x=reshape(x,1,25);
for k=1:10
a=x(k,:);
b=reshape(zeros(5),1,25);
for j=1:25%update neighbouring cells whoes indices are stored in i()
    if j==1
        cnd1(k)=xor(a(j),a(j+1));
        cnd2(k)=and(a(j),a(j+1));
    end
    if j==25
        cnd1(k)=xor(a(j-1),a(j));
        cnd2(k)=a(j);
    end
    if j~=1&j~=25
        cnd1(k)=or(and(and(a(j-1),not(a(j))),not(a(j+1))),and(not(a(j-1)),xor(a(j),a(j+1))));
%         if ((a(j-1)==1&a(j)==0&a(j+1)==0)|(a(j-1)==0&a(j)==1&a(j+1)==0)|(a(j-1)==0&a(j)==0&a(j+1)==1))
%             cnd1(k)=1;
%             disp('ghjk')
%         end
        cnd2(k)=and(a(j),a(j+1));
    end
    if or(cnd1(k)==1,cnd2(k))==1 
        b(j)=1;
    else
        b(j)=0;
    end
end
x=[x;b];
a=b;
end
imagesc(x)