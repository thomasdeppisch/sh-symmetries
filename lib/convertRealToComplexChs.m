function YCmp = convertRealToComplexChs(YReal)

numCoeffs = size(YReal,2);
chOrder = (numCoeffs-1)/2;

YCmp = zeros(size(YReal));
YCmp(:,1) = YReal(:,1); 
for nn = 1:chOrder
        chIdxNegM = 2*nn;
        chIdxPosM = 2*nn+1;

        YCmp(:,chIdxPosM) = 1/sqrt(2) * (YReal(:,chIdxPosM) + 1i * YReal(:,chIdxNegM));
        YCmp(:,chIdxNegM) = 1/sqrt(2) * (YReal(:,chIdxPosM) - 1i * YReal(:,chIdxNegM));
end
