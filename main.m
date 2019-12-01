
close all, clear all, clc;
load('fcno03fz.mat');
load('fcno04fz.mat');
%% paramètres 
sigma = 10;
mu = 0;
var = sigma^2;
N = length(fcno03fz);
nfft = 512;
fs = 8e3;
Ts = 1/fs;

t = [0:Ts:N*Ts-Ts];
f = [-1/2:1/nfft:1/2-(1/nfft)];


%% Définition du bruit blanc gaussien centré et de sa DSP Théorique
bbcg = mu+randn(1,N)*var;

% DSP Théorique
theorique=mu^2*ones(1,2*N-1);
theorique(1,floor(N-1)) = mu^2 + sigma^2;

%% Définition des estimateurs de la fct d'autocorr 
corr_biased = xcorr(bbcg, 'biased');
corr_unbiased = xcorr(bbcg, 'unbiased');

% plot(fcno03fz/sum(fcno03fz))

t1 = -floor(length(corr_biased)/2): 1 :floor(length(corr_biased)/2);

%% Spectre de puissance du bbcg & DSP du bruit
spectre_bbcg = (abs(fft(bbcg)).^2); % en dB
% DSP du bruit
DSP_bruit = (pwelch(bbcg,[],[],[],nfft)); % en dB
%Affichage  
% subplot(211), plot(spectre_bbcg);
% hold on, plot([0,length(bbcg)],[mean(spectre_bbcg) mean(spectre_bbcg)],'-.r');
% subplot(212),plot(DSP_bruit)
% hold on, plot([0, length(DSP_bruit)],[mean(DSP_bruit) mean(DSP_bruit)],'-.r');

 
%% bruit
[signal_bruite1] = bruitage(fcno03fz);
% [signal_bruite2] = bruitage(fcno04fz);
% 
% 
% Periodogram & représentation temporelle
% pour le signal non bruité
figure,
subplot(211)
spectrogram(fcno03fz,[],[],N,fs,'yaxis')
colorbar('off') 
xlim([0.5,6])
subplot(212)
plot(t,fcno03fz)
xlim([0.5,6])

% pour le signal bruité
figure,
subplot(211)
spectrogram(signal_bruite1,[],[],N,fs,'yaxis')
colorbar('off')
xlim([0.5,6])
subplot(212)
plot(t,signal_bruite1)
xlim([0.5,6])
%% affichage  
% 
% figure(2)
% subplot(1,3,1)
% plot(t1,corr_biased)
% ylim([-1000,10e3]);
% title('biaisé')
% subplot(1,3,2)
% plot(t1,corr_unbiased)
% ylim([-1000,10e3]);
% title('non biaisé')
% subplot(1,3,3)
% plot(t1, theorique);
% ylim([-0.1,1]);
% title('théorique')
