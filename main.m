%% 
close all, clear all, clc;
load('fcno03fz.mat');
load('fcno04fz.mat');
%% paramètres 
sigma = 10;
mu = 0;
var = sigma^2;
N = 10000;
nfft = 512;
fs = 8e3;
Ts = 1/fs;

t = [0 : Ts : N*Ts-1];
f = [-1/2: 1/nfft : 1/2 - (1/nfft)];

bbcg = mu+randn(1,N)*var;
DSP = abs(fftshift(fft(bbcg))).^2/length(bbcg);

corr_biased = xcorr(bbcg, 'biased');
corr_unbiased = xcorr(bbcg, 'unbiased');
theorique=mu^2*ones(1,2*N-1);
theorique(1,floor(N-1)) = mu^2 + sigma^2;
plot(fcno03fz/sum(fcno03fz))

t1 = -floor(length(corr_biased)/2): 1 :floor(length(corr_biased)/2);

%% bruit
sl = fcno03fz/sum(fcno03fz);

RSB = 0.000001;

sigma = sqrt(RSB)
yl = sl + mu+randn(size(fcno03fz))*sigma;
figure,
plot([1:1:length(fcno03fz)],yl);















%% affichage 
% vect_freq = linspace(0,pi,length(DSP));
% plot(vect_freq,DSP);
% title('DSP')
% hold on, plot([vect_freq(1) vect_freq(end)],[sigma^2 sigma^2],'r');
% hold on, plot([vect_freq(1) vect_freq(end)],[mean(DSP) mean(DSP)],'-.b');
% 
% 
% figure(2)
% subplot(1,3,1)
% plot(t1,corr_biased)
% title('biaisé')
% subplot(1,3,2)
% plot(t1,corr_unbiased)
% title('non biaisé')
% subplot(1,3,3)
% plot(t1, theorique);
% ylim([-40,40]);
% title('théorique')
