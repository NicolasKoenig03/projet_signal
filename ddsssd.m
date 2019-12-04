clear all ; clc ; close all ;

%% Préliminaire 1

% Question 1

% Génération d'un bruit blanc de moyenne nulle et de variance sigma carré

N = 2^15; % Nombre de points
sigma = 2; % Variance
mu = 0; % Moyenne

b = mu + randn(1,N)*sigma; % Génération du signal bruité

% Fonction d'autocorrélation théorique du signal bruité :
% Rbb(tau) = sigma^2 * delta(tau)

[Rbb_theorique, LAGS] = xcorr(b,'coeff'); % Fonction d'autocorrélation théorique du signal bruité

%figure(1);
%plot(LAGS, Rbb_theorique); % Représentation graphique de la fonction d'autocorrélation
title('Fonction dautocorrélation théorique dun bruit blanc');
xlabel('Tau');
ylabel('Rbb');


[Estimateur_biase, LAGS] = xcorr(b, 'biased'); % Estimateur biaisé de la fonction d'autocorrélation théorique du signal bruité

%figure(2);
%plot(LAGS, Estimateur_biase); % Représentation graphique de l'estimateur biaisé de la fonction d'autocorrélation
title('Estimateur biaisé de la fonction dautocorrélation théorique dun bruit blanc');
xlabel('Tau');
ylabel('Rbb');


[Estimateur_non_biase, LAGS] = xcorr(b, 'unbiased'); % Estimateur non biaisé de la fonction d'autocorrélation théorique du signal bruité

%figure(3);
%plot(LAGS, Estimateur_non_biase); % Représentation graphique de l'estimateur non biaisé de la fonction d'autocorrélation
title('Estimateur non biaisé de la fonction dautocorrélation théorique dun bruit blanc');
xlabel('Tau');
ylabel('Rbb');

% Spectre de puissance
SP = abs(fftshift(fft(b))).^2/N;

figure(4);
plot(-N/2:N/2-1, SP); % Représentation graphique du spectre de puissance
title('Spectre de Puissance');
xlabel('Fréquence');
ylabel('Puissance');

% Densité spectral de puissance
DSP = fftshift(fft(Rbb_theorique));

figure(5);
plot(-N+1:N-1, DSP); % Représentation graphique de la densité spectral de puissance
title('Densité spectral de Puissance');
xlabel('Fréquence');
ylabel('Densité de puissance');

% Question 2

% Periodogramme de Welch, Bartlett et Daniell

Nfft = 2^8; % Nombre de point de la fenêtre
window_welch = hamming(Nfft); % Choix de la fenêtre de Welch
window_bartlett = bartlett(Nfft); % Choix de la fenêtre de Bartlett
k = N/Nfft; % Nombre de fenêtre dans le signal  

pwelch1 = zeros(Nfft, 1); % Vecteur du Peridogramme de Welch 
pbartlett = zeros(Nfft, 1); % Vecteur du Peridogramme de Bartlett
pdaniell = zeros(N, 1); % Vecteur du Peridogramme de Daniell
pbruit = abs(fftshift(fft(b).^2)); % Periodogramme sur l'ensemble du bruit
index = 1; % Début de la fenêtre 

% Periodogramme de Bartlett et Periodogramme de Welch

for i = 1:k % Pour chaque fenêtre 
    xwindow = window_welch.*b(1,index:index+Nfft-1)'; % Fenêtrage du signal par la fenêtre de Welch
    ywindow = window_bartlett.*b(1,index:index+Nfft-1)'; % Fenêtrage du signal par la fenêtre de Bartlett
    
	index = index + Nfft; % Changement d'index pour la prochaine fenêtre
    
    pwelch1 = pwelch1 + abs(fftshift(fft(xwindow, Nfft).^2)); % Ajout au vecteur du periodogramme de Welch
    pbartlett = pbartlett + abs(fftshift(fft(ywindow, Nfft).^2));% Ajout au vecteur du periodogramme de Bartlett
end

% Periodogramme de Daniell 

for j = 1:N - Nfft % Pour chaque point du periodogramme
    pdaniell(j) = sum(pbruit(j:j+Nfft))/(Nfft); % Remplacement par la moyenne des echantillons suivants (Méthode de Daniell) 
end

for j = N-Nfft+1:N
    pdaniell(j) = sum(pbruit(j-Nfft:j))/(Nfft); % Remplacement par la moyenne des echantillons précédents (Méthode de Daniell)
end 

pwelch1 = pwelch1./(k*norm(window_welch)^2); % Normalisation
figure(6);
plot(-Nfft/2:Nfft/2-1,pwelch1); % Représentation graphique du periodogramme de Welch

pbartlett = pbartlett./(k*norm(window_bartlett)^2); % Normalisation
figure(7);
plot(-Nfft/2:Nfft/2-1,pbartlett); % Représentation graphique du periodogramme de Bartlett

pdaniell = pdaniell./N; % Normalisation
figure(8);
plot(-N/2:N/2-1,pdaniell); % Représentation graphique du periodogramme de Daniell

pxx = periodogram(b); %pwelch(b,window_welch,0,2^8);
figure(9);
plot(pxx); 
