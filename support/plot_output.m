function plot_output(out, algo_name, N, D)
    
figure
plot(out)
title(sprintf('%s error (estimated signal) (N=%.0f, D=%.0f)',algo_name, N, D), 'FontSize', 12)
xlabel('Samples', 'FontSize', 12);
ylabel('Magnitude', 'FontSize', 12);