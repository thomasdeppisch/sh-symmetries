function YCmp = convertRealToComplexShCoeffs(YReal)
% Compared to conversions in literature, these ones have an additional
% factor (-1)^m as the SHs are assumed to be implemented including the
% Condon-shortley phase.

numCoeffs = size(YReal,2);
shOrder = sqrt(numCoeffs)-1;

YCmp = zeros(size(YReal));
for nn = 0:shOrder
    for mm = -nn:nn
        acnIdxPos = nn.^2+nn+mm+1;
        acnIdxNeg = nn.^2+nn-mm+1;

        if mm == 0
            YCmp(:,acnIdxPos) = YReal(:,acnIdxPos);
        else
            YCmp(:,acnIdxPos) = (-1)^mm / sqrt(2) * (YReal(:,acnIdxPos) - 1i * YReal(:,acnIdxNeg));
            YCmp(:,acnIdxNeg) = 1 / sqrt(2) * (YReal(:,acnIdxPos) + 1i * YReal(:,acnIdxNeg));
        end
    end
end
