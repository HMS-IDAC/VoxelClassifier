clear, clc

%% set parameters

path = '~/Workspace/DataForVC/Drosophila.tif';
% where is the volume to segment

rfModelPath = '~/Workspace/model.mat';
% where is the trained model

nSubsets = 100;
% the set of voxels to be classified is split in this many subsets;
% if nSubsets > 1, the subsets are classified using 'parfor' with
% the currently-opened parallel pool (or a new default one if none is open);
% see vlClassify.m for details;
% it's recommended to set nSubsets > the number of cores in the parallel pool;
% this can make classification substantially faster than when a
% single thread is used (nSubsets = 1).

% 
% no parameters to set beyond this point
%

%% read volume/model

load(rfModelPath);
V = volumeRead(path);
sizeV = size(V);
V = imresize3(V,[round(model.vResizeFactor*size(V,1)),...
                 round(model.vResizeFactor*size(V,2)),...
                 round(model.vResizeFactor*model.zStretch*size(V,3))]);

%% compute features

tic, disp('volumeFeatures')
F = volumeFeaturesP(V,model.sigmas,model.offsets,model.osSigma,model.logSigmas,model.sfSigmas,model.sfIDs,true);
toc

%% classify

tic, disp('vlClassify')
[vlL,classProbs] = vlClassify(F,model.treeBag,nSubsets);
vlL = imresize3(vlL,sizeV,'nearest');
vlP = zeros(sizeV(1),sizeV(2),sizeV(3),size(classProbs,4));
for i = 1:size(classProbs,4)
    vlP(:,:,:,i) = imresize3(classProbs(:,:,:,i),sizeV);
end
toc

%% display

PM = cat(3,vlP(:,:,:,1),cat(3,vlP(:,:,:,2),vlP(:,:,:,3)));
volumeViewer(PM)