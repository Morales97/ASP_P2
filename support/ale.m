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
        [theta_hat, y_hat] = lms(s, s_delayed, N, muu_lambda);

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

samples = [4500, 11000, 19500, 32000];
for i=1:length(samples)
    figure
    w=linspace(0,pi);
    [magf,~,wf]=dbode(theta_hat(samples(i),:),1,1,w);
    plt = semilogy(wf, magf.^2);
    set(plt, 'LineWidth', 1.5)
    title('LMS adaptive filter response')
    xlabel('Frequency (rad/s)')
    ylabel('Magnitude')
    grid on
    set(gca,'FontSize', 12)
end
