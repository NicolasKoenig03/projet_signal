function [y,f] = Daniell(x,Nbfenetre,Fe)
%DANIELL Summary of this function goes here
% Lors de la méthod de Daniell nous calculons d'abord la DSP sur
% l'intégralité du signal et nous réalisons ensuite des moyennes sur des
% tranches de signaux

  fourier_transform = fftshift(fft(x));
  matrix = abs(fourier_transform).^2; % pour le calcule de la DSP mise au carré de fft

  Dsp_vector = zeros(Nbfenetre);
  
  for i = 0 : Nbfenetre -1
      Dsp_vector(i+1) = mean(matrix(:,i+1));
  end
  
  y = Dsp_vector;
  f = -Fe/2:Fe/Nbfenetre:(Fe/2)-(Fe/Nbfenetre);
  
  
end

