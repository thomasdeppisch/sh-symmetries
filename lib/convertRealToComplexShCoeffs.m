function YCmp = convertRealToComplexShCoeffs(YReal)

numCoeffs = size(YReal,2);
shOrder = sqrt(numCoeffs)-1;

YCmp = zeros(size(YReal));
for nn = 0:shOrder
    for mm = -nn:nn
        acnIdx = nn.^2+nn+mm+1;
        acnIdxNeg = nn.^2+nn-mm+1;

        if mm == 0
            YCmp(:,acnIdx) = YReal(:,acnIdx);
        elseif mm < 0
            YCmp(:,acnIdx) = 1 / sqrt(2) * (YReal(:,acnIdxNeg) + 1i * YReal(:,acnIdx));
        else
            YCmp(:,acnIdx) = (-1)^mm / sqrt(2) * (YReal(:,acnIdx) - 1i * YReal(:,acnIdxNeg));
        end
    end
end
