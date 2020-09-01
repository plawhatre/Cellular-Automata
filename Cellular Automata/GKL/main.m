clc,clear,close all;
%inputs
% n=input('enter the number of cells in the CA');
% t=input('enter the number of time steps');
% d=input('enter the odd number of neighbours');
% pc=input('enter the threshold density');
n=299;
t=148;
d=3;
pc=0.5;
p=input('enter the initial density');
%rule table
r=de2bi(0:(2^d-1),d,'left-msb');
r(:,d+1)=bi2de(r(:,1:d),'left-msb');
for i=1:(2^d)
    n1=sum(r(i,1:d)==1);
    n2=d-n1;
    if (n1/(n1+n2))>pc
        r(i,d+2)=1;
    else
        r(i,d+2)=0;
    end
end
%main grid
x=zeros(t,n);
%req modification
w1=ones(1,floor(n*p));
w2=zeros(1,n-floor(n*p));
w=[w1,w2];
x(1,:)=w(randperm(length(w)));
%main 
for i=1:(t-1)
    for j=1:n
        ngb=[j];
        for k=1:2:d
            if x(i,j)==0
                if (j-k)<1
                    ngb=[n+j-k,ngb];
                else
                    ngb=[ngb,j-k];
                end
            else
                if (j+k)>n
                    ngb=[ngb,j+k-n];
                else
                    ngb=[ngb,j+k];
                end
            end
        end
        tmp=bi2de(x(i,ngb),'left-msb');
        x(i+1,j)=r(tmp+1,d+2);
    end
end
%plot
imagesc(x)
colormap(gray)          