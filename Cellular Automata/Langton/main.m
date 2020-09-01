clc,clear,close all
K=input('enter the number of states');
d=input('enter the radius for neighbours');
N=2*d+1;
%Langton lambda
lambda=1-1/K;
%Input alphabet
alp=alpha(K,N);
%Transition function
disp('press 1 for random table method')
disp('press 2 for table walk method')
choice_delta=input('enter your choice');
c=1;
pdelta=alp;
pdelta(:,end+1)=K;
r=randperm(K^N);
res=0;
for i=0:0.05:lambda
    if choice_delta==1
        %Random table method
        delta(:,:,c)=rtm(K,N,alp,i);
    else
        %Table walk-through method
        [delta(:,:,c),pdelta,r,res]=twtm(K,N,i,pdelta,r,res);
    end
    c=c+1;
end
%quiescent and isotropic condition
c=1;
for i=0:0.05:lambda
        for v=1:K^N
            %isotropic condition
            ip=delta(:,1:(end-1),c);
            ic=fliplr(delta(v,1:(end-1),c));
            [iq,iidx]=ismember(ic,ip,'rows');
            if iq==1
                delta(v,end,c)=delta(iidx,end,c);
            end
            %quiescent condition
            if isequal(delta(v,1:d,c),delta(v,(d+2):(2*d+1),c))&& isequal(delta(v,1:d,c),delta(v,d+1,c)*ones(1,d))
                delta(v,end,c)=delta(v,(d+1),c);
            end
        end
c=c+1;        
end
%plotting number of quescent states versus lambda
chip=0;%input('\npress 1 to plot quescent state versus lambda');
if chip==1
    cmm=[];
    for i=1:(c-1)
        ct=0;
        for j=1:K^N
            if delta(j,end,i)==K
                ct=ct+1;
            end
        end
        cmm=[cmm,ct];
    end
    xmm=1:(c-1);
    plot(xmm,cmm)
end
%initial configration 
disp('press 1 fully random initial condition')
disp('press 2 partially random initial condition')
choice_ic=input('enter your choice');
ti=input('enter time steps')
n=input('enter number of cells in the grid')
cm=zeros(ti,n);%matrix of cellular automata
if choice_ic==1
    cm(1,:)=floor((K)*rand(1,n)+1);
else
    pn=floor(0.60*n);
    cm(1,(floor(n/2)-pn):floor(n/2))=floor((K-1)*rand(1,pn+1)+1);
    cm(1,(floor(n/2)+1):(floor(n/2)+1+pn))=floor((K-1)*rand(1,pn+1)+1);
end
%main
ml=0:0.05:lambda
c=0;
xm=input('enter the lambda value from the above matrix');
for li=1:length(ml)
    if (ml(li)+1)/(xm+1)==1
        c=li
        break
    end
end
if c==0
    disp('enter a valid lambda')
    run('main.m')
end
for t=1:(ti-1)
    for i=1:n
        %checking neighbour
        lim=fliplr((i-1):-1:(i-d));
        cim=[i];
        rim=(i+1):1:(i+d);
        im=[lim cim rim];
        %index correction for index<=0
        for v=1:length(im)
            if im(v)<=0
                im(v)=n+im(v);
            end
        end
        %index correction for index>N
        for v=1:length(im)
            if im(v)>n
                im(v)=im(v)-n;
            end
        end
        %assign states
        sm=cm(t,im);%state matrix
        for smi=1:(K^N)
            if isequal(delta(smi,1:N,c),sm)
                cm(t+1,i)=delta(smi,(N+1),c);
                break
            end
        end
    end
    pause(0.001)
    imagesc(cm)
    colormap(gray)
end
%save output variable
save('output.mat','cm','K')

