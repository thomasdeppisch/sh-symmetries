function YReal = convertComplexToRealChs(YCmp)
% This works in time and in frequency domain!

numCoeffs = size(YCmp,2);
chOrder = (numCoeffs-1)/2;

YReal = zeros(size(YCmp));
YReal(:,1) = real(YCmp(:,1)); % "real" is just used here to remove tiny imaginary parts due to numerical error
for nn = 1:chOrder
    chIdxNegM = 2*nn;
    chIdxPosM = 2*nn+1;

    YReal(:,chIdxPosM) = 1/sqrt(2) * (YCmp(:,chIdxPosM) + YCmp(:,chIdxNegM));
    YReal(:,chIdxNegM) = 1i/sqrt(2) * (YCmp(:,chIdxNegM) - YCmp(:,chIdxPosM));
end
