cd algorithms/
addpath(pwd)
cd ../support
addpath(pwd)
cd ..


[s,fs] = audioread('EQ2401Project2data2021.wav');
%soundsc(s,fs)

%% LMS
N = 150;
D = 100;
muu = 0.002;

[y_hat_lms, e_hat_lms] = ale(s, N, D, muu, 'lms');
soundsc(e_hat_lms,fs)


%% NLMS
N = 150;
D = 100;
muu = 0.002;

[y_hat_nlms, e_hat_nlms] = ale(s, N, D, muu, 'nlms');
soundsc(e_hat_nlms,fs)


%% RLS
N = 50;
D = 150;    % interstingly, D=100 gives very bad results, while for LMS it is good enough
lambda = 0.999;

[y_hat_rls, e_hat_rls] = ale(s, N, D, lambda, 'rls');
soundsc(e_hat_rls,fs)

%% Low pass filter 
% Tested performance by simply filtering out the lower frequencies - noisy
% tones are always of low freq. 
% Results: 
%   1. the noisy tones are filtered quite good, but not perfectly. Adaptive
%       filters, once converged, attenuate better the tones
%   2. the speech frequency content in the lower frequencies is erased -
%       speech quality is worse

M = 50;

lowpass(s, 0.18)    % this one generates the plots
y_hat = lowpass(s, 0.18);
e_hat = s - y_hat;
soundsc(e_hat, fs)

figure
plot_spectral_estimates(s, M, 'Input signal s(n)')
plot_spectral_estimates(y_hat, M, 'Estimated noise tones y(n)')
plot_spectral_estimates(e_hat, M, 'Estimated speech e(n)')
title('ALE using a plain low pass filter')

