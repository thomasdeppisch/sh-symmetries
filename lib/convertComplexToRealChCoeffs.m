function YReal = convertComplexToRealChCoeffs(YCmp, makeZeroOrderReal)
% This works in time and in frequency domain!
arguments
    YCmp
    makeZeroOrderReal = false; % set to true to make sure output is fully real valued (without numerical issues), do not apply for frequency-domain coefficients
end

numCoeffs = size(YCmp,2);
chOrder = (numCoeffs-1)/2;

YReal = zeros(size(YCmp));
YReal(:,1) = YCmp(:,1); % do not apply "real()" in case you are dealing with frequency-domain coefficients
if makeZeroOrderReal
    YReal(:,1) = real(YReal(:,1));
end
for nn = 1:chOrder
        chIdxNegM = 2*nn;
        chIdxPosM = 2*nn+1;

        YReal(:,chIdxPosM) = 1/sqrt(2) * (YCmp(:,chIdxPosM) + YCmp(:,chIdxNegM));
        YReal(:,chIdxNegM) = -1i/sqrt(2) * (YCmp(:,chIdxNegM) - YCmp(:,chIdxPosM));
end
