function plot_output(out, algo_name)
    
figure
plot(out)
title(sprintf('%s - Estimated speech signal', algo_name))