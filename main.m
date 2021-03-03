cd algorithms/
addpath(pwd)
cd ../support
addpath(pwd)
cd ..


[s,fs] = audioread('EQ2401Project2data2021.wav');
% soundsc(s,fs)

%% LMS
N = 150;            % Filter Length
D = 50;             % Delay
muu = 0.005;        % Step size

[~, ~, e_hat_lms] = ale(s, N, D, muu, 'LMS');
soundsc(e_hat_lms,fs)

plot_output(e_hat_lms, 'LMS')


%% NLMS
N = 150;            % Filter length
D = 50;             % Delay
muu = 0.005;        % Step size

[~, ~, e_hat_nlms] = ale(s, N, D, muu, 'NLMS');
soundsc(e_hat_nlms,fs)

plot_output(e_hat_nlms, 'NLMS')


%% RLS
N = 100;            % Filter length
D = 150;            % Delay
lambda = 0.999;     % Forgetting factor

[~, ~, e_hat_rls] = ale(s, N, D, lambda, 'RLS');
% soundsc(e_hat_rls, fs)

plot_output(e_hat_rls, 'RLS')


%% Block LMS
N = 150;            % Filter length
D = 50;             % Delay
muu = 0.003;        % Step size
L = 10;             % Block length

[theta_hat, y_hat_lms, e_hat_block_lms] = ale(s, N, D, muu, 'Block LMS', L);
% soundsc(e_hat_block_lms,fs)

plot_output(e_hat_block_lms, 'Block LMS')

%% Test execution speed (LMS vs Block LMS)
N = 150;
D = 50;
muu = 0.003;
L = 10;
runs = 50;          % Number of runs to average

time_lms = 0;
for i = 1:1:runs
    tic;
    [theta_hat, y_hat_lms, e_hat_lms] = ale(s, N, D, muu, 'LMS', L, 0);
    x = toc;
    time_lms = time_lms + x;
end

time_block_lms = 0;
for i = 1:1:runs
    tic;
    [theta_hat, y_hat_lms, e_hat_lms] = ale(s, N, D, muu, 'Block LMS', L, 0);
    x = toc;
    time_block_lms = time_block_lms + x;
end

disp('LMS average exectution time (s):')
disp(time_lms/runs)
disp('Block LMS average exectution time (s):')
disp(time_block_lms/runs)

%% Execution speed plot
% N = 150;
% D = 50;
% muu = 0.003;
% runs = 20;
% L_array = [1, 2, 4, 6, 8, 10, 12, 15, 20, 50, 100];
% times = zeros(length(L_array),1);
% 
% for i = 1:1:length(L_array)
%     L = L_array(i);
%     time = 0;
%     for j = 1:1:runs
%         tic;
%         [theta_hat, y_hat_lms, e_hat_lms] = ale(s, N, D, muu, 'Block LMS', L, 0);
%         x = toc;
%         time = time + x;
%     end
%     times(i) = time/runs;
% end
% 
% plot(L_array, times_1*1000, 'LineWidth', 1.5, 'DisplayName', 'Block LMS')
% yline(46, '-.','LineWidth', 2, 'DisplayName', 'LMS')
% xlabel('Block size (L)')
% ylabel('Avg execution time (ms)')
% title('Average execution time (N=150, D=50, mu=0.003)')
% legend



