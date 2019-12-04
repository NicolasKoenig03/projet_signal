function [] = add_recouvrement(signal)

%% Sans recouvrement
% M = 1000;                       % window length
% R = floor(length(signal)/M);    % hop size
% w = hanning(M);                 % window
% N = length(signal) - mod(length(signal),M);
%  
% %  sans recouvrement
%  trames = reshape(signal(1:N),[],M);
%  recomposition = zeros(N/M,M);
%  for i=1:N/M
%      recomposition(i,:) = trames(i,:).*w';
%      recomposition(i,:) = recomposition(i,:)./w';
%      signal_recomp = reshape(recomposition,[],1);
%  end
%  figure, plot(signal)
%  hold on; plot(signal_recomp/w, '*r')

 
 
%% Avec recouvrement 50%
close all
windowLength = 1000; % store this value
w = hanning(windowLength);
overlap = 0.5;  % in portion of windowLength - 20% in this example
increment = floor(windowLength*overlap);
startPos = 1;
endPos = startPos + windowLength;
j = 1;
recomposition = [];

% Parties des fenêtres de hanning qui overlap
w_middle1 = w(1:increment);
w_middle2 = w(increment+1:windowLength);

BOS = signal(1:increment).*w(1:increment); % Begin of signal
EOS = signal(length(signal)-windowLength:length(signal)-1).*w; % End of signal
EOSbis = signal(length(signal)-increment:length(signal)-1).*w(increment+1:endPos-1);
figure,plot(signal,'r');
hold on;
while endPos < length(signal)-increment
    trame1 = signal(startPos:endPos-1).*w;
    trame2 = signal(startPos+increment:endPos+increment-1).*w;
    
    % Normalisation du signal qui overlap
    overlap_zone = (trame1(increment+1:windowLength)+trame2(1:increment))./(w_middle1+w_middle2);
    recomposition(j,:) = overlap_zone;
    
%     plot([startPos+increment:endPos-1],recomposition(j,:));
    startPos = startPos + increment ;
    endPos = endPos + increment;
    j=j+1;
end
BOS = BOS./w(1:increment);
EOS = EOS./w;
EOSbis = EOSbis./w(increment+1:1000);
plot(BOS);
plot([length(signal)-increment:length(signal)-1],EOSbis)
plot([length(signal)-windowLength:length(signal)-1],EOS)
recomp_reshape = reshape(recomposition',1,[]);
signal_recomp = cat(2,BOS',recomp_reshape,EOSbis')
figure, plot(signal_recomp,'b');
hold on; plot(signal,'r')

end


%% Commentaires
% On réhausse chaque trames càd on estime notre signal (signal + erreur)
% Une moyenne des fenetres induit une amplification
% quand la fenêtre 1 est grande la 2eme est petite donc la somme des
% fenêtres peut être égale à 1 si elles sont bien choisies
% 
    
