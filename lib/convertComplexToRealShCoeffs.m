function YReal = convertComplexToRealShCoeffs(YCmp,makeZeroOrderReal)
% This works in time and in frequency domain!
arguments
    YCmp
    makeZeroOrderReal = false; % set to true to make sure output is fully real valued (without numerical issues), do not apply for frequency-domain coefficients
end

numCoeffs = size(YCmp,2);
shOrder = sqrt(numCoeffs)-1;

YReal = zeros(size(YCmp));
for nn = 0:shOrder
    for mm = -nn:nn
        acnIdx = nn.^2+nn+mm+1;
        acnIdxNeg = nn.^2+nn-mm+1;

        if mm == 0
            YReal(:,acnIdx) = YCmp(:,acnIdx); % do not apply "real()" in case you are dealing with frequency-domain coefficients
            if makeZeroOrderReal
                YReal(:,acnIdx) = real(YReal(:,acnIdx));
            end
        elseif mm < 0
            % YReal(:,acnIdx) = -sqrt(2) * (-1)^mm * imag(YCmp(:,acnIdxNeg));
            YReal(:,acnIdx) = -1i / sqrt(2) * (YCmp(:,acnIdx) - (-1)^mm * YCmp(:,acnIdxNeg));
        else
            % YReal(:,acnIdx) = sqrt(2) * (-1)^mm * real(YCmp(:,acnIdx));
            YReal(:,acnIdx) = 1 / sqrt(2) * ((-1)^mm * YCmp(:,acnIdx) + YCmp(:,acnIdxNeg));
            
        end
    end
end
