close all, clear all, clc;
load('fcno03fz.mat');
load('fcno04fz.mat');
sigma = 4;
mu = 0;
var = sigma^2;
N = 10000;
nfft = 1024;
fs = 8e3;
Ts = 1/fs;

bbcg = mu+randn(1,N)*var;

[y,f] = Bartlett(bbcg,nfft,fs);
y1=y
a = var*ones(1,length(f));
figure
plot(f,y1);
hold on;

plot(f,a);
