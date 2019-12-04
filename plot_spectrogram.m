function [] = plot_spectrogram(signal)
% Periodogram & représentation temporelle
% pour un signal
fs = 8e3;
Ts = 1/fs;
N = length(signal);
t = [0:Ts:N*Ts-Ts];


figure,
subplot(211)
spectrogram(signal,[],[],N,fs,'yaxis')
colorbar('off') 
xlim([0.5 6])
subplot(212)
plot(t,signal)
xlim([0.5 6])
end

