function [x1,x2,x3,x4,x5,x6,x7,x8]=nbh(a,i,j,m,n,b,c,d,e)
%1
if b==0||d==0
    x1=NaN;
else
    x1=a(b,d);
end
%2
if b==0
    x2=NaN;
else
    x2=a(b,j);
end
%3 
if b==0||e==n+1
    x3=NaN;
else
    x3=a(b,e);
end
%4
if d==0
    x4=NaN;
else
    x4=a(i,d);
end
%5
if e==n+1
    x5=NaN;
else
    x5=a(i,e);
end
%6
if c==m+1||d==0
    x6=NaN;
else
    x6=a(c,d);
end
%7
if c==m+1
    x7=NaN;
else
    x7=a(c,j);
end
%8
if c==m+1||e==n+1
    x8=NaN;
else
    x8=a(c,e);
end
end

