function V = volumeRead(volumePath)
    BFData = bfopen(volumePath);
    nPlanes = size(BFData{1},1);
    [nr,nc] = size(BFData{1}{1,1});
    V = zeros(nr,nc,nPlanes);
    for k = 1:nPlanes
        VK = BFData{1}{k,1};
        V(:,:,k) = VK;
    end
end