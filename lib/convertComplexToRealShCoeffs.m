function YReal = convertComplexToRealShCoeffs(YCmp,makeZeroOrderReal)
% This works in time and in frequency domain!
arguments
    YCmp
    makeZeroOrderReal = false; % set to true to make sure output is fully real valued (without numerical issues), do not apply for frequency-domain coefficients
end

% Compared to conversions in literature, these ones have an additional
% factor (-1)^m as the SHs are assumed to be implemented including the
% Condon-shortley phase.

numCoeffs = size(YCmp,2);
shOrder = sqrt(numCoeffs)-1;

YReal = zeros(size(YCmp));
for nn = 0:shOrder
    for mm = -nn:nn
        acnIdxPos = nn.^2+nn+mm+1;
        acnIdxNeg = nn.^2+nn-mm+1;

        if mm == 0
            YReal(:,acnIdxPos) = YCmp(:,acnIdxPos); % do not apply "real()" in case you are dealing with frequency-domain coefficients
            if makeZeroOrderReal
                YReal(:,acnIdxPos) = real(YReal(:,acnIdxPos));
            end
        else
            % YReal(:,acnIdxPos) = sqrt(2) * (-1)^mm * real(YCmp(:,acnIdxPos));
            % YReal(:,acnIdxNeg) = -sqrt(2) * (-1)^mm * imag(YCmp(:,acnIdxPos));

            YReal(:,acnIdxPos) = (-1)^mm / sqrt(2) * (YCmp(:,acnIdxPos) + (-1)^mm * YCmp(:,acnIdxNeg));
            YReal(:,acnIdxNeg) = -(-1)^mm * 1i / sqrt(2) * ((-1)^mm * YCmp(:,acnIdxNeg) - YCmp(:,acnIdxPos));
        end
    end
end
