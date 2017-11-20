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

V = volumeRead(path);
load(rfModelPath);

%% compute features

tic, disp('volumeFeatures')
F = volumeFeaturesP(V,model.sigmas,model.offsets,model.osSigma,model.logSigmas,model.sfSigmas,model.sfIDs,true);
toc

%% classify

tic, disp('vlClassify')
[vlL,classProbs] = vlClassify(F,model.treeBag,nSubsets);
toc

%% display

PM = cat(3,classProbs(:,:,:,1),cat(3,classProbs(:,:,:,2),classProbs(:,:,:,3)));
volumeViewer(PM)