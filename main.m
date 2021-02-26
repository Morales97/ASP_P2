cd algorithms/
addpath(pwd)
cd ../support
addpath(pwd)
cd ..


[s,fs] = audioread('EQ2401Project2data2021.wav');
soundsc(s,fs)

%% LMS
N = 100;
D = 100;
muu = 0.002;

[y_hat, e_hat] = ale(s, N, D, muu, 'lms');
soundsc(e_hat,fs)


%% NLMS
N = 100;
D = 150;
muu = 0.003;

[y_hat, e_hat] = ale(s, N, D, muu, 'nlms');
soundsc(e_hat,fs)


%% RLS
N = 50;
D = 150;    % interstingly, D=100 gives very bad results, while for LMS it is good enough
lambda = 0.998;

[y_hat, e_hat] = ale(s, N, D, lambda, 'rls');
soundsc(e_hat,fs)