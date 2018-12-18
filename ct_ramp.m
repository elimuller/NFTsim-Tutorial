clear all
clc

output = nf.run('NFTsim_Tutorial/ct_ramp.conf');
Qe = output.data{1}(:,1);
nu_t = output.data{4}(:,1);

figure
subplot(221)
plot(output.time, nu_t,'-k')
dnu = abs(max(nu_t) - min(nu_t))/5;
ylim([min(nu_t)-dnu max(nu_t)+dnu])
xlabel('Time (s)')
ylabel('SRN-cortical coupling (mV.s)')
title('Coupling ramp')

subplot(222)
plot(output.time, Qe,'-k')
xlabel('Time (s)')
ylabel('Excitatory firing rate (s^-1)')
title('Firing rate timeseries')

subplot(223)
[f, P] = nf.spectrum(output,'Pop.1.Q');
loglog(f,P,'-k')
xlabel('Frequency (Hz)')
ylabel('Power Q_e (arb. units)')
title('Power spectrum')
axis xy

subplot(224)
fs = 1/output.deltat;
fmin = 0.5;
fmax = 200;
nfreqs = 1200;
cfreqs = linspace(fmin,fmax,nfreqs);
[cfx, cfreqso] = nf.wavelet_spectrogram(output, 'Pop.1.Q',Qe,fs,cfreqs,7,0);
Z = log(abs(cfx));
imagesc(output.time, cfreqso, Z)
xlabel('Time (s)')
ylabel('Frequency (Hz)')
title('Morlet wavelet power')
axis xy
