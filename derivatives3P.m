function D = derivatives3P(V,sigma)

D = derivatives3(V,sigma);
D4 = zeros(size(V,1),size(V,2),size(V,3),length(D));
for i = 1:length(D)
    D4(:,:,:,i) = D{i};
end
D = cat(4,D4,sqrt(D{2}.^2+D{3}.^2+D{4}.^2));

end