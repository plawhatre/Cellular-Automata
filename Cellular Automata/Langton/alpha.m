function alp = alpha(K,N)
a=[];
for i=1:K
    a=[a,i];
end
v={};
for i=1:N
    v{end+1}=a;
end
v = flipud(v(:));
c= cell(1, numel(v));
[c{:}]= ndgrid(v{:});
c= fliplr(c);
alp= cell2mat(cellfun(@(v)v(:), c, 'UniformOutput',false));
end
