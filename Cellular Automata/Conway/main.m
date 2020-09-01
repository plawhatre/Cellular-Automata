clc,clear,close all;
load('input.mat')
disp('press 1 to run the code for a random matrix')
disp('press 2 to run the code for your own matrix')
choice=input('enter your choice:');
speed=input('enter the speed at which image is to be displayed in seconds:');
g=input('enter the number of simulation:');
if choice==1
    m=input('enter the number of rows');
    n=input('enter the number of columns');
    a=randi([0 1],m,n);
end
if choice==2
    a=input('enter the matrix=');
    [m n]=size(a);
end
am=a;
for gen=2:g
x=[];
cn=[];
count_n=0;
for i=1:1:m
    for j=1:1:n
        b=i-1;  
        c=i+1;
        d=j-1;
        e=j+1;
        [x1,x2,x3,x4,x5,x6,x7,x8]=nbh(am,i,j,m,n,b,c,d,e);
        x=[x;x1,x2,x3,x4,x5,x6,x7,x8];
    end
end
clear x1 x2 x3 x4 x5 x6 x7 x8
 [mx,nx]=size(x);
 for i=1:mx
     for j=1:nx
         if x(i,j)==1                                         
            count_n=count_n+1;
         end
     end
     cn=[cn;count_n];
     count_n=0;
 end
 cn=reshape(cn,n,m);
 cn=cn';% neighbourhoood matrix
 for i=1:m
     for j=1:n
         if cn(i,j)<2%die-deserted
             am(i,j)=0;
         end
         if cn(i,j)==2%live-favourable envirnment
             am(i,j)=a(i,j);
         end
         if cn(i,j)>3% die-overcrowded
             am(i,j)=0;
         end
         if cn(i,j)==3%reproduce-favaurable environment
             am(i,j)=1;
         end
     end
 end
 a(:,:,gen)=am;
end
disp('yellow=1')
disp('blue=0')
for q=1:gen
    imagesc(a(:,:,q))
    grid
    colormap(gray)
    pause(speed)
end