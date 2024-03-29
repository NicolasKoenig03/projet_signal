function [y,f] = Welch(x,Nfft,fenetrePond, Fe)
%MON_WELCH1 Summary of this function goes here
%   Prend en param�tre un signal x, un nombre de fenetres Nfft et la
%   fr�quence d'�chantillonge du singal.
%renvoie y qui correspond a la DP du signal x et 




% Cr�ations de diff�rentes fen�tres de pond�rations

    switch fenetrePond
        case 'bartlett'
           window = barlett(Nfft);
        case 'Hann'
           window = hann(Nfft);
        case 'Hamming'
           window = hamming(Nfft);
        case 'Blackman'
           window = blakcman(Nfft);
        otherwise
           window = ones(Nfft);
    end



Nb = length(x);
nombre_fenetre = round(Nb/Nfft);
matrix = zeros(nombre_fenetre,Nfft);
DSP_vector = zeros(1,Nfft);



%% Calcul de la DSP par fen�tre

for i = 0 : nombre_fenetre -1  
    if i == 0
        fourier_transform = fftshift(fft(x(i*Nfft+1:(i*Nfft+1)+Nfft).*window'));
        matrix(i+1,:) = abs(fourier_transform(1:Nfft)).^2;
    else
        fourier_transform = fftshift(fft(x(i*Nfft+1-L:(i*Nfft+1)+Nfft).*window'));
        matrix(i+1,:) = abs(fourier_transform(1:Nfft)).^2; % pour le calcule de la DSP mise au carr� de fft
    end
end

%% Calcul de la moyenne de la DSP

for j = 0 : Nfft-1
    DSP_vector(j+1) = mean(matrix(:,j+1));
end
y = DSP_vector;

f = -Fe/2:Fe/Nfft:(Fe/2)-(Fe/Nfft);
%[y, f] = Mon_Welch_(x, Nfft, Fe);



end
