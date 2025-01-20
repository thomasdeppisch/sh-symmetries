clear all
close all

% This script tests the symmetry properties of complex-valued spherical 
% harmonic (SH) expansion coeffcients of real-valued functions.
%
% td, 2025

addpath(genpath('./lib/'))
addpath(genpath('./dependencies/'))

%% create test signal
shOrder = 10;
[~,dirsAziEleRad] = getTdesign(2*shOrder);
dirZenRad = pi/2 - dirsAziEleRad(:,2);
numChannels = size(dirsAziEleRad,1);
shCmpx = getSH(shOrder, [dirsAziEleRad(:,1), dirZenRad], 'complex');

sigLenSec = 0.01;
fs = 48000;
sigLenSmp = fs*sigLenSec;
sig = randn(sigLenSmp,numChannels); % real-valued time-domain signal
shCoeffCmpx = sig * pinv(shCmpx).'; % CH domain coefficients

fftLen = 2^(ceil(log2(length(shCoeffCmpx))));
shCoeffCmpxFd = fft(shCoeffCmpx,fftLen); % frequency-domain CH coefficients

%% time-domain symmetry
shCoeffCmpxFromSymm = zeros(size(shCoeffCmpx));
shCoeffCmpxFromSymm(:,1) = shCoeffCmpx(:,1);
for nn = 1:shOrder
    for mm = 0:nn
        acnIdxPos = nn^2+nn+mm+1;
        acnIdxNeg = nn^2+nn-mm+1;
        shCoeffCmpxFromSymm(:,acnIdxNeg)  = (-1)^mm * conj(shCoeffCmpx(:,acnIdxPos)); % use symmetry to compute negative-m SH coeffs: Y_-m = (-1)^m Y_m^*
        shCoeffCmpxFromSymm(:,acnIdxPos) = shCoeffCmpx(:,acnIdxPos);
    end
end

maxErrorCoeffFromSymm = max(abs(shCoeffCmpxFromSymm - shCoeffCmpx),[],"all");
disp(['Maximum error for extension of complex CH coeffs from symmetry: ' num2str(maxErrorCoeffFromSymm)])

%% frequency-domain symmetry
% Recover negative-frequency coefficients from positive-frequency ones
shCoeffCmpxFdSingleSided = shCoeffCmpxFd(1:fftLen/2+1,:);
shCoeffCmpxFdDoubleSided = getShFreqDomainConjugate(shCoeffCmpxFdSingleSided);

maxErrorCoeffFromSymmFd = max(abs(shCoeffCmpxFdDoubleSided - shCoeffCmpxFd),[],"all");
disp(['Maximum error for extension of complex freq-domain SH coeffs from symmetry: ' num2str(maxErrorCoeffFromSymmFd)])