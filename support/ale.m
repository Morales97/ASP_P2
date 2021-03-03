function [theta_hat, y_hat, e_hat] = ale(s, N, D, muu_lambda, method, ...
    block_length, show)

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% ------------- Adaptive filtering ---------------
% ------------------------------------------------

% Decorrelate input by a delay D
s_delayed = [zeros(D, 1); s(1:end-D)];

switch method
    case 'LMS' 
        % Estimate noisy tones y_hat(n) with LMS filtering
        [theta_hat, y_hat] = clean_lms(s, s_delayed, N, muu_lambda);

        % Obtain error (speach signal) estimate
        e_hat = s - y_hat;
        
        
    case 'NLMS'
        % Estimate noisy tones y_hat(n) with LMS filtering
        [theta_hat, y_hat] = nlms(s, s_delayed, N, muu_lambda);

        % Obtain error (speach signal) estimate
        e_hat = s - y_hat; 

    case 'RLS'
        % Estimate noisy tones y_hat(n) with RLS filtering
        [theta_hat, y_hat] = rls(s, s_delayed, N, muu_lambda);

        % Obtain error (speach signal) estimate
        e_hat = s - y_hat; 
        
    case 'Block LMS'
        % Estimate noisy tones y_hat(n) with Block LMS filtering
        L = block_length;
        [theta_hat, y_hat] = block_lms(s, s_delayed, N, L, muu_lambda);

        % Obtain error (speach signal) estimate
        e_hat = s - y_hat; 
    otherwise
        disp('No adaptive algorithm selected')
end


% ----------- Parametric estimation  -------------
% ------------------------------------------------

if ~exist('show','var')
     % if parameter 'show' doesn't exist, set to 1
      show = 1;
end

if show
    M = 50;
    figure
    subplot_spectral_estimates(s, M, 'Input signal s(n)', method)
    subplot_spectral_estimates(y_hat, M, 'Estimated noise tones y(n)', method)
    subplot_spectral_estimates(e_hat, M, 'Estimated speech e(n)', method)
end
