function delta = rtm(K,N,alp,lambda)
dm=zeros(K^N,N+1);
dm(:,1:N)=alp;
for rti=1:K^N
    c=rand;
    if c>lambda
        dm(rti,N+1)=K;
    else
        dm(rti,N+1)=floor((K-1)*rand+1);
    end
end
delta= dm;
end