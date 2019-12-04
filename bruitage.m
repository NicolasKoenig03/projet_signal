function [signal_bruite] = bruitage( signal )
%bruitage permet de bruiter un signal donné 
varSignal = std2(signal)^2; % variance du bruit
SNRdB = 5:5:15;
for i=1:numel(SNRdB)
  sigma_noise = sqrt(varSignal/10^(SNRdB(i)/10));
  bruit = sigma_noise*randn(size(signal));
  signal_bruite = signal+bruit;
  signal_bruite = signal_bruite';   
  figure,plot(signal_bruite)
  title(['SNR = ' int2str(SNRdB(i)) 'dB' ...
  ', \sigma_{noise} = ' num2str(sigma_noise)]);
end
end

