function [y,f] = Bartlett(x,Nfft, Fe)
%MON_WELCH1 Summary of this function goes here
%   Prend en param�tre un signal x, un nombre de points par fenetres Nfft et la
%   fr�quence d'�chantillonge du singal.
%renvoie y qui correspond a la DP du signal x et 

Nb = length(x);
nombre_fenetre = round(Nb/Nfft);
matrix = zeros(nombre_fenetre,Nfft);
DSP_vector = zeros(1,Nfft);



%% Calcul de la DSP par fen�tre

% for i = 0 :: nombre_fenetre -1  
%     fourier_transform = fftshift(fft(x(i*Nfft+1:(i*Nfft+1)+Nfft)));
%     size(fourier_transform)
%     matrix(i+1,:) = abs(fourier_transform(1:Nfft)).^2; % pour le calcule de la DSP mise au carr� de fft
%     
% end

for i = 1 :Nfft: nombre_fenetre -1  
    fourier_transform = fftshift(fft(x(i:i+Nfft)));
    size(fourier_transform)
    matrix(i+1,:) = abs(fourier_transform(1:Nfft)).^2; % pour le calcule de la DSP mise au carr� de fft
    
end
%% Calcul de la moyenne de la DSP

for j = 1 : Nfft
    DSP_vector(j) = mean(matrix(:,j));
end
y = DSP_vector./4;

f = -Fe/2:Fe/Nfft:(Fe/2)-(Fe/Nfft);
%[y, f] = Mon_Welch_(x, Nfft, Fe);
end
