clear all
close all

% This script tests the conversion relations between complex- and
% real-valued spherical harmonics (SHs) and their expansion coefficients.
%
% td, 2025

addpath(genpath('./lib/'))
addpath(genpath('./dependencies/'))

%% test the conversion of SHs
shOrder = 10;
[~,dirsAziEleRad] = getTdesign(2*shOrder);
dirZenRad = pi/2 - dirsAziEleRad(:,2);
numChannels = size(dirsAziEleRad,1);

shCmpx = getSH(shOrder, [dirsAziEleRad(:,1), dirZenRad], 'complex');
shReal = getSH(shOrder, [dirsAziEleRad(:,1), dirZenRad], 'real');

shRealFromCompx = convertComplexToRealShs(shCmpx);
maxErrorCompxToReal = max(abs(shRealFromCompx - shReal),[],"all");
disp(['Maximum error for conversion from complex to real SHs: ' num2str(maxErrorCompxToReal)])

shCmpxFromReal = convertRealToComplexShs(shReal);
maxErrorRealToCmpx = max(abs(shCmpxFromReal - shCmpx),[],"all");
disp(['Maximum error for conversion from real to complex SHs: ' num2str(maxErrorRealToCmpx)])

%% test the conversion of expansion coefficients
% Create a real-valued time-domain signal, transform it to the SH domain, and compare
% differences between directly employing a real/complex SH definition to
% converting between real/complex SHs.
sigLenSec = 0.01;
fs = 48000;
sigLenSmp = fs*sigLenSec;
sig = randn(sigLenSmp,numChannels);

shCoeffCmpx = sig * pinv(shCmpx).';
shCoeffReal = sig * pinv(shReal).';

shCoeffCmpxFromReal = convertRealToComplexShCoeffs(shCoeffReal);
shCoeffRealFromCmpx = convertComplexToRealShCoeffs(shCoeffCmpx);

maxErrorCoeffCompxToReal = max(abs(shCoeffReal - shCoeffRealFromCmpx),[],"all");
disp(['Maximum error for conversion from complex to real SH coefficients: ' num2str(maxErrorCoeffCompxToReal)])

maxErrorCoeffRealToCmpx = max(abs(shCoeffCmpx - shCoeffCmpxFromReal),[],"all");
disp(['Maximum error for conversion from real to complex SH coefficients: ' num2str(maxErrorCoeffRealToCmpx)])


%% test converting coefficients in the frequency domain
fftLen = 2^(ceil(log2(length(shCoeffReal))));
shCoeffRealFd = fft(shCoeffReal,fftLen);
shCoeffCmpxFd = fft(shCoeffCmpx,fftLen);

shCoeffFdRealFromCmpx = convertComplexToRealShCoeffs(shCoeffCmpxFd); 
shCoeffFdCmpxFromReal = convertRealToComplexShCoeffs(shCoeffRealFd); 

maxErrorFdCoeffCompxToReal = max(abs(shCoeffRealFd - shCoeffFdRealFromCmpx),[],"all");
disp(['Maximum error for conversion from complex to real frequency-domain SH coefficients: ' num2str(maxErrorFdCoeffCompxToReal)])

maxErrorFdCoeffRealToCmpx = max(abs(shCoeffCmpxFd - shCoeffFdCmpxFromReal),[],"all");
disp(['Maximum error for conversion from real to complex frequency-domain SH coefficients: ' num2str(maxErrorFdCoeffRealToCmpx)])
