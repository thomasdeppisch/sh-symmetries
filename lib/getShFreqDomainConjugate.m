function yConj = getShFreqDomainConjugate(y)
% This function extends a single-sided (positive-frequency)
% frequency-domain signal to a double-sided representation adhering the SH
% domain symmetry property.
% Complex-valued frequency-domain SH coefficients adhere to the following
% symmetry: f_{n,m}(-w) = (-1)^m f_{n,-m}^*(w)
% The function assumes an even FFT length.
%
% td, 2024


numShs = size(y,2);
shOrder = sqrt(numShs)-1;
yConjFlip = conj(flipud(y(2:end-1,:)));

yNegFreq = zeros(size(yConjFlip));
yNegFreq(:,1) = yConjFlip(:,1); % zeroth order is simply conjugated, so nothing else to do here
for nn=1:shOrder
    for mm=-nn:nn
        acnIdx = nn^2+nn+mm+1;
        acnIdxNeg = nn^2+nn-mm+1;
        yNegFreq(:,acnIdx) = (-1)^(mm) * yConjFlip(:,acnIdxNeg);
    end
end

% put it together
yConj = [y;yNegFreq];
