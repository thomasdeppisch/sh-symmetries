clear all
close all

% This script tests the symmetry properties of complex-valued circular 
% harmonic (CH) expansion coeffcients of real-valued functions.
%
% td, 2025

addpath(genpath('./lib/'))
addpath(genpath('./dependencies/'))

%% create test signal
chOrder = 10;
numChannels = 2*chOrder+1;
dirsAziRad = pi/180 * (0:360/numChannels:360-360/numChannels)';
chCmpx = getCH(chOrder,dirsAziRad,'complex');

sigLenSec = 0.01;
fs = 48000;
sigLenSmp = fs*sigLenSec;
sig = randn(sigLenSmp,numChannels); % real-valued time-domain signal
chCoeffCmpx = sig * pinv(chCmpx).'; % CH domain coefficients

fftLen = 2^(ceil(log2(length(chCoeffCmpx))));
chCoeffCmpxFd = fft(chCoeffCmpx,fftLen); % frequency-domain CH coefficients

%% time-domain symmetry
chCoeffCmpxFromSymm = zeros(size(chCoeffCmpx));
chCoeffCmpxFromSymm(:,1) = chCoeffCmpx(:,1);
for nn = 1:chOrder
    chCoeffCmpxFromSymm(:,2*nn)   = conj(chCoeffCmpx(:,2*nn+1)); % use symmetry to compute negative-m CH coeffs: C_-m = C_m^*
    chCoeffCmpxFromSymm(:,2*nn+1) = chCoeffCmpx(:,2*nn+1);
end

maxErrorCoeffFromSymm = max(abs(chCoeffCmpxFromSymm - chCoeffCmpx),[],"all");
disp(['Maximum error for extension of complex CH coeffs from symmetry: ' num2str(maxErrorCoeffFromSymm)])

%% frequency-domain symmetry
% Recover negative-frequency coefficients from positive-frequency ones
chCoeffCmpxFdSingleSided = chCoeffCmpxFd(1:fftLen/2+1,:);
chCoeffCmpxFdDoubleSided = getChFreqDomainConjugate(chCoeffCmpxFdSingleSided);

maxErrorCoeffFromSymmFd = max(abs(chCoeffCmpxFdDoubleSided - chCoeffCmpxFd),[],"all");
disp(['Maximum error for extension of complex freq-domain CH coeffs from symmetry: ' num2str(maxErrorCoeffFromSymmFd)])