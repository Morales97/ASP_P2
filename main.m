cd algorithms/
addpath(pwd)
cd ../support
addpath(pwd)
cd ..


[s,fs] = audioread('EQ2401Project2data2021.wav');
% soundsc(s,fs)

%% 
%
%  ---------------------------------
%  --------- ALGORITHMS ------------
%  ---------------------------------
%

%% LMS
N = 150;            % Filter Length
D = 50;             % Delay
muu = 0.005;        % Step size

[~, ~, e_hat_lms] = ale(s, N, D, muu, 'LMS');
soundsc(e_hat_lms,fs)

plot_output(e_hat_lms, 'LMS', N, D)


%% NLMS
N = 150;            % Filter length
D = 50;             % Delay
muu = 0.01;         % Step size

[~, ~, e_hat_nlms] = ale(s, N, D, muu, 'NLMS');
% soundsc(e_hat_nlms,fs)

plot_output(e_hat_nlms, 'NLMS', N, D)


%% RLS
N = 100;            % Filter length
D = 150;            % Delay
lambda = 0.9995;     % Forgetting factor

[~, ~, e_hat_rls] = ale(s, N, D, lambda, 'RLS');
% soundsc(e_hat_rls, fs)

plot_output(e_hat_rls, 'RLS', N, D)


%% Block LMS
N = 150;            % Filter length
D = 50;             % Delay
muu = 0.003;        % Step size
L = 10;             % Block length

[~, ~, e_hat_block_lms] = ale(s, N, D, muu, 'Block LMS', L);
% soundsc(e_hat_block_lms,fs)

plot_output(e_hat_block_lms, 'Block LMS', N, D)

%% Test execution speed (LMS vs Block LMS)
N = 150;
D = 50;
muu = 0.003;
L = 10;
runs = 25;          % Number of runs to average

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

%% 
%
%  ---------------------------------
%  --------- OTHER PLOTS -----------
%  ---------------------------------
%

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

%% LMS theta diff plot
% N = 150; %50
% D = 50;  %150
% figure
% 
% muu = [0.001, 0.005, 0.010];
% for i = 1:length(muu)
%     [theta_hat_lms, ~, ~] = ale(s, N, D, muu(i), 'LMS');
%     diffs = diff(theta_hat_lms, 1, 1);
%     abs_diffs = abs(diffs);
%     abs_diffs_sum = sum(abs_diffs, 2);
%     abs_smooth = conv(ones(100,1) * 1/100, abs_diffs_sum);
%     muu_char = sprintf('step-size = %.4f', muu(i));
%     plot(abs_smooth, 'DisplayName', muu_char);
%     hold on;
% end
% legend('show', 'FontSize', 12);
% title_char = sprintf('LMS Parameter Convergence (N=%.0f, D=%.0f)',N, D);
% title(title_char, 'FontSize', 12);
% xlabel('Samples', 'FontSize', 12);
% ylabel('Sum of absolute first-differences', 'FontSize', 12);

%% NLMS theta diff plot
% N = 150;
% D = 50;
% figure
% 
% muu = [0.003, 0.005, 0.007];
% for i = 1:length(muu)
%     [theta_hat_lms, ~, ~] = ale(s, N, D, muu(i), 'NLMS');
%     diffs = diff(theta_hat_lms, 1, 1);
%     abs_diffs = abs(diffs);
%     abs_diffs_sum = sum(abs_diffs, 2);
%     abs_smooth = conv(ones(100,1) * 1/100, abs_diffs_sum);
%     muu_char = sprintf('step-size = %.4f', muu(i));
%     plot(abs_smooth, 'DisplayName', muu_char);
%     hold on;
% end
% legend('show', 'FontSize', 12);
% title_char = sprintf('NLMS Parameter Convergence (N=%.0f, D=%.0f)',N, D);
% title(title_char, 'FontSize', 12);
% xlabel('Samples', 'FontSize', 12);
% ylabel('Sum of absolute first-differences', 'FontSize', 12);

%% RLS theta diff plot
% N = 100;
% D = 150;
% figure;
% 
% lambda = [0.9995, 0.9999, 0.999];
% for i = 1:length(lambda)
%     [theta_hat_lms, ~, ~] = ale(s, N, D, lambda(i), 'RLS');
%     diffs = diff(theta_hat_lms, 1, 1);
%     abs_diffs = abs(diffs);
%     abs_diffs_sum = sum(abs_diffs, 2);
%     abs_smooth = conv(ones(100,1) * 1/100, abs_diffs_sum);
%     lambda_char = sprintf('lambda = %.4f', lambda(i));
%     plot(abs_smooth, 'DisplayName', lambda_char);
%     hold on;
% end
% legend('show', 'FontSize', 12);
% title_char = sprintf('RLS Parameter Convergence (N=%.0f, D=%.0f)',N, D);
% title(title_char, 'FontSize', 12);
% xlabel('Samples', 'FontSize', 12);
% ylabel('Sum of absolute first-differences', 'FontSize', 12);
