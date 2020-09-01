clc,clear,close all
%inputs
n=input('enter the number of cells in the CA');
t=input('enter the number of time steps');
d=input('enter the mahalanobis distance for neighbours');
r=input('enter the rule number');
choice_config=input('enter 1 for random intial configration and any number for central point configration');
choice_neigh=input('enter 1 for no bounday cond. and any other number for periodic boundary cond.');
ne=2*d+1;
%rule lookup-table
rule=0:(2^ne-1);
rule=rule';
rule(:,2)=(de2bi(r,(2^ne),'right-msb'))';
%display grid
x=zeros(t,n);
if choice_config==1
    x(1,:)=randi([0 1], 1,n);
else
    x(1,floor(n/2))=1;
end
%main
if choice_neigh==1
    for i=1:(t-1)
        for j=(d+1):(n-d)
            %neighbourhood
            ln=[];
            rn=[];
            for k=1:d
                ln=[ln,(j-k)];
                rn=[rn,(j+k)];
            end
            ln=fliplr(ln);
            nbd=[ln,j,rn];
            nv=bi2de(x(i,nbd),'left-msb');
            %assign states
            for q=1:(2^ne)
                if isequal(rule(q,1),nv)
                    x(i+1,j)=rule(q,2);
                    break
                end
            end
        end
    end
else
    for i=1:(t-1)
        for j=1:n
            ln=[];
            rn=[];
            for k=1:d
                if (j-k)<1
                    ln=[ln,n+j-k];
                else
                    ln=[ln,j-k];
                end
                if (j+k)>n
                    rn=[rn,j+k-n];
                else
                    rn=[rn,j+k];
                end
            end
            ln=fliplr(ln);
            nbd=[ln,j,rn];
            nv=bi2de(x(i,nbd),'left-msb');
            %assign states
            for q=1:(2^ne)
                if isequal(rule(q,1),nv)
                    x(i+1,j)=rule(q,2);
                    break
                end
            end
        end
    end
end
%plot
imagesc(x)
colormap(gray)
