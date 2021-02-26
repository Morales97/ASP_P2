function [y_hat, e_hat] = ale(s, N, D, muu_lambda, method)

% [y_hat, e_hat]= ale_(y,N,muu)
%
%	s           - Input data sequence
%	N			- Dimension of the parameter vector
%   D           - Delay for decorrelation
%	muu         - Step size
%	y_hat       - D-step ahead prediction y_hat(n|n-D)
%   e_hat       - error
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% s(n) is the original noisy signal
% y(n) are the noisy tones
% e(n) is the speach signal

% s(n) = y(n) + e(n)

% Decorrelate input by a delay D
s_delayed = [zeros(D, 1); s(1:end-D)];

switch method
    case 'lms' 
        % Estimate noisy tones y_hat(n) with LMS filtering
        [~, y_hat] = lms(s, s_delayed, N, muu_lambda);

        % Obtain error (speach signal) estimate
        e_hat = s - y_hat; 
    
    case 'nlms'
        % Estimate noisy tones y_hat(n) with LMS filtering
        [~, y_hat] = nlms(s, s_delayed, N, muu_lambda);

        % Obtain error (speach signal) estimate
        e_hat = s - y_hat; 

    case 'rls'
        % Estimate noisy tones y_hat(n) with RLS filtering
        [~, y_hat] = rls(s, s_delayed, N, muu_lambda);

        % Obtain error (speach signal) estimate
        e_hat = s - y_hat; 
        
end