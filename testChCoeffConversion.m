clear all
close all

% This script tests the conversion relations between complex- and
% real-valued circular harmonics (CHs) and their expansion coefficients.
%
% td, 2025

addpath(genpath('./lib/'))
addpath(genpath('./dependencies/'))

%% test the conversion of CHs
chOrder = 10;
numChannels = 2*chOrder+1;
dirsAziRad = pi/180 * (0:360/numChannels:360-360/numChannels)';

chCmpx = getCH(chOrder,dirsAziRad,'complex');
chReal = getCH(chOrder,dirsAziRad,'real');

chRealFromCompx = convertComplexToRealChs(chCmpx);
maxErrorCompxToReal = max(abs(chRealFromCompx - chReal),[],"all");
disp(['Maximum error for conversion from complex to real CHs: ' num2str(maxErrorCompxToReal)])

chCmpxFromReal = convertRealToComplexChs(chReal);
maxErrorRealToCmpx = max(abs(chCmpxFromReal - chCmpx),[],"all");
disp(['Maximum error for conversion from real to complex CHs: ' num2str(maxErrorRealToCmpx)])

%% test the conversion of expansion coefficients
% Create a real-valued time-domain signal, transform it to the CH domain, and compare
% differences between directly employing a real/complex CH definition to
% converting between real/complex CHs.
sigLenSec = 0.01;
fs = 48000;
sigLenSmp = fs*sigLenSec;
sig = randn(sigLenSmp,numChannels);

chCoeffCmpx = sig * pinv(chCmpx).';
chCoeffReal = sig * pinv(chReal).';

chCoeffCmpxFromReal = convertRealToComplexChCoeffs(chCoeffReal);
chCoeffRealFromCmpx = convertComplexToRealChCoeffs(chCoeffCmpx);

maxErrorCoeffCompxToReal = max(abs(chCoeffReal - chCoeffRealFromCmpx),[],"all");
disp(['Maximum error for conversion from complex to real CH coefficients: ' num2str(maxErrorCoeffCompxToReal)])

maxErrorCoeffRealToCmpx = max(abs(chCoeffCmpx - chCoeffCmpxFromReal),[],"all");
disp(['Maximum error for conversion from real to complex CH coefficients: ' num2str(maxErrorCoeffRealToCmpx)])

%% test converting coefficients in the frequency domain
fftLen = 2^(ceil(log2(length(chCoeffReal))));
chCoeffRealFd = fft(chCoeffReal,fftLen);
chCoeffCmpxFd = fft(chCoeffCmpx,fftLen);

chCoeffFdRealFromCmpx = convertComplexToRealChCoeffs(chCoeffCmpxFd); 
chCoeffFdCmpxFromReal = convertRealToComplexChCoeffs(chCoeffRealFd); 

maxErrorFdCoeffCompxToReal = max(abs(chCoeffRealFd - chCoeffFdRealFromCmpx),[],"all");
disp(['Maximum error for conversion from complex to real frequency-domain CH coefficients: ' num2str(maxErrorFdCoeffCompxToReal)])

maxErrorFdCoeffRealToCmpx = max(abs(chCoeffCmpxFd - chCoeffFdCmpxFromReal),[],"all");
disp(['Maximum error for conversion from real to complex frequency-domain CH coefficients: ' num2str(maxErrorFdCoeffRealToCmpx)])

