function [volumeList,labelList,classIndices] = parseLabelFolder(dirPath)

files = dir(dirPath);

% how many annotated volumes (all that don't have 'Class' in the name)
nVolumes = 0;
for i = 1:length(files)
    fName = files(i).name;
    if ~contains(fName,'Class') && ~contains(fName,'.mat') && fName(1) ~= '.'
        nVolumes = nVolumes+1;
        volumePaths{nVolumes} = [dirPath filesep fName];
    end
end

% list of class indices per volume
classIndices = [];
[~,volName] = fileparts(volumePaths{1});
for i = 1:length(files)
    fName = files(i).name;
    k = strfind(fName,'Class');
    if contains(fName,volName) && ~isempty(k)
        [~,imn] = fileparts(fName);
        classIndices = [classIndices str2double(imn(k(1)+5:end))];
    end
end
nClasses = length(classIndices);

% read volumes/labels
volumeList = cell(1,nVolumes);
labelList = cell(1,nVolumes);
parfor i = 1:nVolumes
    fprintf('parsing training example %d of %d\n', i, nVolumes);
    V = volumeRead(volumePaths{i});
    [imp,imn] = fileparts(volumePaths{i});
    L = uint8(zeros(size(V)));
    for j = 1:nClasses
        classJ = volumeRead([imp filesep imn sprintf('_Class%d.tif',classIndices(j))]) > 0;
        L(classJ) = j;
    end

    volumeList{i} = V;
    labelList{i} = L;
end

end