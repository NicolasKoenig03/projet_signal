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
windowLength = 1000; % store this value
w = hanning(windowLength);
overlap = 0.5;  % in portion of windowLength - 20% in this example
startPos = 1;
endPos = startPos + windowLength;
increment = floor(windowLength*overlap);
j = 1;

while endPos <= length(signal)-increment
    recomposition(j,:) = (signal(startPos:endPos).*w+signal(startPos+increment:endPos+increment).*w)./(2*w);
    startPos = startPos + increment ;
    endPos = endPos + increment;
    j=j+1;
end
plot([startPos + increment: endPos + increment-1],w)
signal_recomp = reshape(recomposition,[],1);
figure, plot(signal_recomp);
hold on; plot(signal/max(signal));

% hold on; plot(1:windowLength, signal_recomp(1:windowLength))
% hold on; plot(1+increment:2*windowLength, signal_recomp(1+increment:2*windowLength))
% hold on; plot(1+2*increment:3*windowLength, signal_recomp(1+2*increment:3*windowLength))
% hold on; plot(1+3*increment:4*windowLength, signal_recomp(1+3*increment:4*windowLength))



% for j=0:R:N
%   ndx = j+1:j+M;        % current window location
%   signal(ndx) = signal(ndx) + w;    % window overlap-add
%   wzp = signal;
%   wzp(ndx) = w;  % for plot only
%   plot(wzp(ndx),'--ok');       % plot just this window
% end
% plot(signal);  hold off;  % plot window overlap-add
end
    
