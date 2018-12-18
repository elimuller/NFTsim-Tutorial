clear all
clc

output = nf.run('NFTsim_Tutorial/ct_model.conf');

Qe = output.data{1}(:,1);

figure
subplot(121)
plot(output.time, Qe,'-k')
xlabel('Time (s)')
ylabel('Excitatory firing rate (s^-1)')
title('Firing rate timeseries')
axis xy

subplot(122)
[f, P] = nf.spectrum(output,'Pop.1.Q');
loglog(f,P,'-k')
ylabel('Power Q_e (arb. units)')
xlabel('Frequency (Hz)')
title('Power spectrum')
axis xy
