function [y,f] = Bartlett(x,Nfft, Fe)
%MON_WELCH1 Summary of this function goes here
%   Prend en paramètre un signal x, un nombre de points par fenetres Nfft et la
%   fréquence d'échantillonge du singal.
%renvoie y qui correspond a la DP du signal x et 

Nb = length(x);
nombre_fenetre = round(Nb/Nfft);
matrix = zeros(nombre_fenetre,Nfft);
DSP_vector = zeros(1,Nfft);


%% Calcul de la DSP par fenètre

compteur = 0
for i = 1 :Nfft: nombre_fenetre -1  
    fourier_transform = fftshift(fft(x(i:i+Nfft)).^2)
    size(fourier_transform)
    matrix(i+1,:) = abs(fourier_transform(1:Nfft)) % pour le calcule de la DSP mise au carré de fft
    compteur = compteur +1;
end
%% Calcul de la moyenne de la DSP

for j = 1 : Nfft
    DSP_vector(j) = mean(matrix(:,j));
end

coefnormalisation = norm(ones(1,Nfft))^2*compteur;

y = DSP_vector/coefnormalisation;
f = -1/2:1/Nfft:(1/2)-(1/Nfft);
%f = -Fe/2:Fe/Nfft:(Fe/2)-(Fe/Nfft);
end

