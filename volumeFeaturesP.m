function [F,featNames] = volumeFeaturesP(V,sigmas,offsets,osSigma,logSigmas,sfSigmas,sfIDs,runParallel)

F = [];
featIndex = 0;
featNames = {};

if ~isempty(V)
    nFCalls = 0;
    fHandles = {};
    fParams = {};
end


% feature names, function handles, function parameters

if ~isempty(sigmas)
    derivNames = {'d0','dx','dy','dz','dxx','dyx','dzx','dyy','dzy','dzz'};
    for sigma = sigmas
        for i = 1:length(derivNames)
            featIndex = featIndex+1;
            featNames{featIndex} = [sprintf('sigma%d',sigma) derivNames{i}];
        end
        featIndex = featIndex+1;
        featNames{featIndex} = sprintf('sigma%dedges',sigma);
        
        if ~isempty(V)
            nFCalls = nFCalls+1;
            fHandles{nFCalls} = @derivatives3P;
            fParams{nFCalls} = {V,sigma};
        end
    end
end
if ~isempty(offsets)
    if ~isempty(V)
        W = filterGauss3D(V,osSigma);
    end
    for i = 1:size(offsets,1)
        featIndex = featIndex+1;
        featNames{featIndex} = sprintf('offsetind%d',i);
        
        if ~isempty(V)
            nFCalls = nFCalls+1;
            fHandles{nFCalls} = @imtranslate;
            fParams{nFCalls} = {W,offsets(i,:)};
        end
    end
end
if ~isempty(logSigmas)
    for sigma = logSigmas
        featIndex = featIndex+1;
        featNames{featIndex} = sprintf('sigma%dlog',sigma);
        
        if ~isempty(V)
            nFCalls = nFCalls+1;
            fHandles{nFCalls} = @filterLoGND;
            fParams{nFCalls} = {V,sigma};
        end
    end
end
if ~isempty(sfSigmas)
    for sigma = sfSigmas
        if ~isempty(V)
            W = imresize3(V,1/sigma);
        end
        for id = sfIDs
            featIndex = featIndex+1;
            featNames{featIndex} = sprintf('sigma%dsteerID%d',sigma,id);
            
            if ~isempty(V)
                nFCalls = nFCalls+1;
                fHandles{nFCalls} = @steerableDetector3DP;
                fParams{nFCalls} = {W,id,size(V)};
            end
        end
    end
end


% features

% https://www.mathworks.com/help/matlab/matlab_prog/pass-contents-of-cell-arrays-to-functions.html
if ~isempty(V)
    featList = cell(1,length(fHandles));
    if runParallel
        parfor i  = 1:length(fHandles)
            featList{i} = fHandles{i}(fParams{i}{:});
        end
    else
        for i  = 1:length(fHandles)
            featList{i} = fHandles{i}(fParams{i}{:});
        end
    end
    for i = 1:length(fHandles)
        F = cat(4,F,featList{i});
    end
end

end