function [delta,pdelta,r,res]=twtm(K,N,lbd,pdelta,r,res)
npc=floor(lbd*(K^N));%number of non-quescent state
npc=npc-res;%incremental non-quescent states
rnpc=r(1:npc);
for tq=1:npc
    pdelta(rnpc(tq),end)=floor((K-1)*rand+1);
end
r=setdiff(r,rnpc);
delta=pdelta;
res=floor(lbd*(K^N));
end