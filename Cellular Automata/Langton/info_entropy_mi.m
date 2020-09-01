clc,clear,close all
load('output.mat')
y=cm;
pu=[];
[t,n]=size(y);
for i=1:K
    c=0;
    g=[];
    for j=1:n
        for k=1:t
            if y(k,j)==i
                c=c+1;
            end
        end
        g=[g,c];
    end
    pu=[pu;g];
end
%Average Entropy
H=[];
for i=1:n
    x=pu(:,i);
    xt=sum(x);
    x=x./xt;
    s=0;
    for j=1:K
        if x(j)~=0
            s=s-(x(j)*log2(x(j)));
        end
    end
    H=[H,s]
end
ht=sum(H);
H=ht/length(H);
%Mutual information
I=[];
for i=1:n
    a=y(1:(t-1),i);
    b=y(2:t,i);
    pa=zeros(K,1);
    pb=zeros(K,1);
    pu=zeros(K,K);
    for j=1:(t-1)
        pa(a(j))=pa(a(j))+1;
        pb(b(j))=pb(b(j))+1;
        pu(a(j),b(j))=pu(a(j),b(j))+1;
    end
    pas=sum(pa);
    pbs=sum(pb);
    pus=sum(sum(pu));
    %a distribution
    pa=pa./pas;
    %b distribution
    pb=pb./pbs;
    %joint distribution
    pu=pu./pus;
    ha=0;
    hb=0;
    hab=0;
    for k=1:K
        %entropy of h(a)
        if pa(k)~=0
            ha=ha-(pa(k)*log2(pa(k)));
        end
        %entropy of h(b)
        if pb(k)~=0
            hb=hb-(pb(k)*log2(pb(k)));
        end
    end
    %entropy of h(a,b)
    for k=1:(K^2)
        if pu(k)~=0
            hab=hab-(pu(k)*log2(pu(k)));
        end
    end
    %actual information
    iab=ha+hb-hab;
    I=[I,iab]
end 
it=sum(I);
I=it/length(I);        
