function S = steerableDetector3DP(W,id,sizeOut)

R = steerableDetector3D(W,id,1);
S = imresize3(R,sizeOut);

end