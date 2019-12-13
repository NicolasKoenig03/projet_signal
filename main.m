close all, clear all, clc;
load('fcno03fz.mat');
load('fcno04fz.mat');
signal1 = fcno03fz;
signal2 = fcno04fz;
%% paramètres 
sigma = 2; % écart-type du bruit blanc gaussien
mu = 0; % moyenne du bruit (centré)
var = sigma^2; % variance du bruit
N = length(signal1); % Longueur du signal de parole
L = 1000; % nbre d'échantillons du bruit blanc
fs = 8e3; % fréquence d'échantillonnage
Ts = 1/fs; % periode d'échantillonnage

p2 = nextpow2(L);
nfft = 2^p2; % pour faciliter la FFT 
% Quand nfft > L le signal est zero paddé jusqu'à nfft

t = [0:Ts:N*Ts-Ts]; % axe des temps
f = [-1/2:1/nfft:1/2-(1/nfft)]; % axe des fréquences


%% Définition du bruit blanc gaussien centré et de sa DSP Théorique
bbcg = mu+randn(1,L)*sigma;

%% Définition des estimateurs de la fct d'autocorr 
corr_theo = zeros(1,2*L-1);
corr_theo(ceil(L-1)) = mu^2+var;
[corr_biased, lags_biased] = xcorr(bbcg, 'biased');
[corr_unbiased, lags_unbiased] = xcorr(bbcg, 'unbiased');
% Affichage
figure,subplot(311)
plot(lags_unbiased,corr_theo);title('corr theorique')
subplot(312)
plot(lags_biased,corr_biased);title('corr biased')
subplot(313)
plot(lags_unbiased,corr_unbiased);title('corr unbiased')
% ylim([-4e3,1e4]);

%% Spectre de puissance du bbcg & DSP du bruit
spectre_bbcg = (abs(fftshift(fft(bbcg,nfft))).^2)/L; 
% DSP du bruit
DSP_bruit = fftshift(fft(corr_theo,nfft));
% DSP théorique
DSP_theo = ones(1,nfft)*var; % stationnaire + ergodique → puissance = variance

%Affichage  
subplot(211), plot(f,spectre_bbcg);title('Spectre de puissance')
hold on, plot([-1/2,1/2],[mean(spectre_bbcg) mean(spectre_bbcg)],'-.r');
subplot(212),plot(f,DSP_bruit);title('DSP du bruit')
% hold on, plot(f,[mean(DSP_bruit) mean(DSP_bruit)],'-.r');
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


