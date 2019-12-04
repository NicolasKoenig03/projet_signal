clear all ; clc ; close all ;

%% Pr�liminaire 1

% Question 1

% G�n�ration d'un bruit blanc de moyenne nulle et de variance sigma carr�

N = 2^15; % Nombre de points
sigma = 2; % Variance
mu = 0; % Moyenne

b = mu + randn(1,N)*sigma; % G�n�ration du signal bruit�

% Fonction d'autocorr�lation th�orique du signal bruit� :
% Rbb(tau) = sigma^2 * delta(tau)

[Rbb_theorique, LAGS] = xcorr(b,'coeff'); % Fonction d'autocorr�lation th�orique du signal bruit�

%figure(1);
%plot(LAGS, Rbb_theorique); % Repr�sentation graphique de la fonction d'autocorr�lation
title('Fonction dautocorr�lation th�orique dun bruit blanc');
xlabel('Tau');
ylabel('Rbb');


[Estimateur_biase, LAGS] = xcorr(b, 'biased'); % Estimateur biais� de la fonction d'autocorr�lation th�orique du signal bruit�

%figure(2);
%plot(LAGS, Estimateur_biase); % Repr�sentation graphique de l'estimateur biais� de la fonction d'autocorr�lation
title('Estimateur biais� de la fonction dautocorr�lation th�orique dun bruit blanc');
xlabel('Tau');
ylabel('Rbb');


[Estimateur_non_biase, LAGS] = xcorr(b, 'unbiased'); % Estimateur non biais� de la fonction d'autocorr�lation th�orique du signal bruit�

%figure(3);
%plot(LAGS, Estimateur_non_biase); % Repr�sentation graphique de l'estimateur non biais� de la fonction d'autocorr�lation
title('Estimateur non biais� de la fonction dautocorr�lation th�orique dun bruit blanc');
xlabel('Tau');
ylabel('Rbb');

% Spectre de puissance
SP = abs(fftshift(fft(b))).^2/N;

figure(4);
plot(-N/2:N/2-1, SP); % Repr�sentation graphique du spectre de puissance
title('Spectre de Puissance');
xlabel('Fr�quence');
ylabel('Puissance');

% Densit� spectral de puissance
DSP = fftshift(fft(Rbb_theorique));

figure(5);
plot(-N+1:N-1, DSP); % Repr�sentation graphique de la densit� spectral de puissance
title('Densit� spectral de Puissance');
xlabel('Fr�quence');
ylabel('Densit� de puissance');

% Question 2

% Periodogramme de Welch, Bartlett et Daniell

Nfft = 2^8; % Nombre de point de la fen�tre
window_welch = hamming(Nfft); % Choix de la fen�tre de Welch
window_bartlett = bartlett(Nfft); % Choix de la fen�tre de Bartlett
k = N/Nfft; % Nombre de fen�tre dans le signal  

pwelch1 = zeros(Nfft, 1); % Vecteur du Peridogramme de Welch 
pbartlett = zeros(Nfft, 1); % Vecteur du Peridogramme de Bartlett
pdaniell = zeros(N, 1); % Vecteur du Peridogramme de Daniell
pbruit = abs(fftshift(fft(b).^2)); % Periodogramme sur l'ensemble du bruit
index = 1; % D�but de la fen�tre 

% Periodogramme de Bartlett et Periodogramme de Welch

for i = 1:k % Pour chaque fen�tre 
    xwindow = window_welch.*b(1,index:index+Nfft-1)'; % Fen�trage du signal par la fen�tre de Welch
    ywindow = window_bartlett.*b(1,index:index+Nfft-1)'; % Fen�trage du signal par la fen�tre de Bartlett
    
	index = index + Nfft; % Changement d'index pour la prochaine fen�tre
    
    pwelch1 = pwelch1 + abs(fftshift(fft(xwindow, Nfft).^2)); % Ajout au vecteur du periodogramme de Welch
    pbartlett = pbartlett + abs(fftshift(fft(ywindow, Nfft).^2));% Ajout au vecteur du periodogramme de Bartlett
end

% Periodogramme de Daniell 

for j = 1:N - Nfft % Pour chaque point du periodogramme
    pdaniell(j) = sum(pbruit(j:j+Nfft))/(Nfft); % Remplacement par la moyenne des echantillons suivants (M�thode de Daniell) 
end

for j = N-Nfft+1:N
    pdaniell(j) = sum(pbruit(j-Nfft:j))/(Nfft); % Remplacement par la moyenne des echantillons pr�c�dents (M�thode de Daniell)
end 

pwelch1 = pwelch1./(k*norm(window_welch)^2); % Normalisation
figure(6);
plot(-Nfft/2:Nfft/2-1,pwelch1); % Repr�sentation graphique du periodogramme de Welch

pbartlett = pbartlett./(k*norm(window_bartlett)^2); % Normalisation
figure(7);
plot(-Nfft/2:Nfft/2-1,pbartlett); % Repr�sentation graphique du periodogramme de Bartlett

pdaniell = pdaniell./N; % Normalisation
figure(8);
plot(-N/2:N/2-1,pdaniell); % Repr�sentation graphique du periodogramme de Daniell

pxx = periodogram(b); %pwelch(b,window_welch,0,2^8);
figure(9);
plot(pxx); 
