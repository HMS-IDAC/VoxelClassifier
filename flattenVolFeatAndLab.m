function [flatFeat,flatLbl] = flattenVolFeatAndLab(vlFeat,vlLbl)

nVariables = size(vlFeat,4);

nLabels = max(vlLbl(:)); % assuming labels are 1, 2, 3, ...

nVoxelsPerLabel = zeros(1,nLabels);
vxlIndices = cell(1,nLabels);

for i = 1:nLabels
    vxlIndices{i} = find(vlLbl == i);
    nVoxelsPerLabel(i) = numel(vxlIndices{i});
end

nSamples = sum(nVoxelsPerLabel);

flatFeat = zeros(nSamples,nVariables);
flatLbl = zeros(nSamples,1);

offset = [0 cumsum(nVoxelsPerLabel)];
for i = 1:nVariables
    F = vlFeat(:,:,:,i);
    for j = 1:nLabels
        flatFeat(offset(j)+1:offset(j+1),i) = F(vxlIndices{j});
    end
end
for j = 1:nLabels
    flatLbl(offset(j)+1:offset(j+1)) = j;
end

end