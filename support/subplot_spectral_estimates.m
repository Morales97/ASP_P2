function subplot_spectral_estimates(s, M, legend_name, algo_name)

% Divide signal into subsignals of interest, where noisy tones are constant
samples_tones_change = [5000, 12000, 20000];
s1 = s(1:samples_tones_change(1));
s2 = s(samples_tones_change(1) : samples_tones_change(2));
s3 = s(samples_tones_change(2) : samples_tones_change(3));
s4 = s(samples_tones_change(3) : length(s));

% Get AR parametric estimation of the spectrum
[A_hat_s1, sigma2_hat_s1] = aryule(s1, M);
[A_hat_s2, sigma2_hat_s2] = aryule(s2, M);
[A_hat_s3, sigma2_hat_s3] = aryule(s3, M);
[A_hat_s4, sigma2_hat_s4] = aryule(s4, M);


% ----- PLOT ------
w=linspace(0, pi, 512);
[mags1,~,ws1]=dbode(1,A_hat_s1,1,w);
[mags2,~,ws2]=dbode(1,A_hat_s2,1,w);
[mags3,~,ws3]=dbode(1,A_hat_s3,1,w);
[mags4,~,ws4]=dbode(1,A_hat_s4,1,w);



%figure
subplot(2,2,1)
sgtitle(sprintf('%s - Spectrum estimation (AR-50)', algo_name))
semilogy(ws1,mags1.^2*sigma2_hat_s1, 'LineWidth', 1.5, 'DisplayName', legend_name);
title('Segment 1')
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
hold on
grid on
legend

subplot(2,2,2)
semilogy(ws2,mags2.^2*sigma2_hat_s2, 'LineWidth', 1.5, 'DisplayName', legend_name);
title('Segment 2')
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
hold on
grid on
legend

subplot(2,2,3)
semilogy(ws3,mags3.^2*sigma2_hat_s3, 'LineWidth', 1.5, 'DisplayName', legend_name);
title('Segment 3')
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
hold on
grid on
legend

subplot(2,2,4)
semilogy(ws4,mags4.^2*sigma2_hat_s4, 'LineWidth', 1.5, 'DisplayName', legend_name);
title('Segment 4')
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
hold on
grid on
legend
