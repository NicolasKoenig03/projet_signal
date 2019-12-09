close all, clear all, clc;
load('fcno03fz.mat');
load('fcno04fz.mat');
signal1 = fcno03fz;
signal2 = fcno04fz;
%% paramètres 
sigma = 10;
mu = 0;
var = sigma^2;
N = length(signal1);
L = 1000;
nfft = 512;
fs = 8e3;
Ts = 1/fs;

t = [0:Ts:N*Ts-Ts];
f = [-1/2:1/nfft:1/2-(1/nfft)];


%% Définition du bruit blanc gaussien centré et de sa DSP Théorique
bbcg = mu+randn(1,L)*var;

% DSP Théorique
theorique=mu^2*ones(1,2*N-1);
theorique(1,floor(N-1)) = mu^2 + sigma^2;

%% Définition des estimateurs de la fct d'autocorr 
corr_theo = xcorr(bbcg);
corr_biased = xcorr(bbcg, 'biased');
corr_unbiased = xcorr(bbcg, 'unbiased');
% Affichage
subplot(311)
plot(corr_theo);title('corr theorique')
subplot(312)
plot(corr_biased);title('corr biased')
subplot(313)
plot(corr_unbiased);title('corr unbiased')
ylim([-4e3,1e4]);

%% Spectre de puissance du bbcg & DSP du bruit
spectre_bbcg = fftshift(abs(fft(bbcg)).^2)/L; 
% DSP du bruit
DSP_bruit = fftshift(abs(fft(bbcg)))
%Affichage  
subplot(211), plot(spectre_bbcg);title('DSP theorique')
hold on, plot([0,length(bbcg)],[mean(spectre_bbcg) mean(spectre_bbcg)],'-.r');
subplot(212),plot(DSP_bruit);title('DSP')
hold on, plot([0, length(DSP_bruit)],[mean(DSP_bruit) mean(DSP_bruit)],'-.r');
hold off;
 
%% bruit
[signal_bruite1] = bruitage(signal1);
[signal_bruite2] = bruitage(signal2);

% Affichage
plot_spectrogram(signal1);
plot_spectrogram(signal_bruite1);
plot_spectrogram(signal2);
plot_spectrogram(signal_bruite2);
%% Rehaussement
signal_rehausse = add_recouvrement(signal_bruite1);

%% Lecture de la piste audio
soundsc(signal_rehausse);


