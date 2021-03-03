function plot_spectral_estimates(s, M, legend_name)

% Get AR parametric estimation of the spectrum
[A_hat_full, sigma2_hat_full] = aryule(s, M);

% ----- PLOT ------
w=linspace(0, pi, 512);
[magfull,~,wfull]=dbode(1,A_hat_full,1,w);

semilogy(wfull,magfull.^2*sigma2_hat_full, 'LineWidth', 1.5, 'DisplayName', legend_name);
title('RLS - Spectrum of segment 2 (samples 5k-12k)')
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
grid on
hold on
legend