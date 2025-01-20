function yConj = getChFreqDomainConjugate(y)
% This function extends a single-sided (positive-frequency)
% frequency-domain signal to a double-sided representation adhering the CH
% domain symmetry property.
% Complex-valued frequency-domain CH coefficients adhere to the following
% symmetry: f_{n,m}(-w) = f_{n,-m}^*(w)
% The function assumes an even FFT length.
% 
% td, 2024

numChs = size(y,2);
chOrder = (numChs-1)/2;
yConjFlip = conj(flipud(y(2:end-1,:)));

yNegFreq = zeros(size(yConjFlip));
yNegFreq(:,1) = yConjFlip(:,1); % zeroth order is simply conjugated, so nothing else to do here
for ii = 1:chOrder
    yNegFreq(:,2*ii) = yConjFlip(:,2*ii+1);
    yNegFreq(:,2*ii+1) = yConjFlip(:,2*ii);
end

% put it together
yConj = [y;yNegFreq];
