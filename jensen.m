function [trame_filtered] = jensen(trame, ratio)

N = length(trame);
M = floor(N * ratio);
L = N + 1 - M;

%% Creation de la matrice de hankel
left = trame(1:L);
right = trame(L:N);
Hy = hankel(left,right);

%% Décomposition SVD
[U,S,V] = svd(Hy, 'econ');
sing_val = diag(S).';
sing_val = sing_val/max(sing_val);

%% Valeurs singulières après seuillage
K = length(find(sing_val > 0.3));
dominant_sing_val = diag([diag(S(1:K,1:K))', zeros(1,M-K)]);

%% Reconstruction de la matrie
Hs = U*dominant_sing_val*V';
trame_filtered = [Hs(1:end,1).' Hs(end,2:end)];

%% Estimation au sens du minimum de variance

end

%% Commentaires 
%% SVD
% U et V vecteurs singuliers gauche et droit
% Sigma Vecteur de valeurs propres (à vérifier)
% Mettre certaines valeurs singulières à 0 pour la première estimation
% On reconstruit avec U et V (perte de la structure hankel)
% moyenne des anti diagonales pour retrouver le signal réhaussé
% VALEURS SING = VALEURS PROPRES DUNE MATRICE QUELCONQUE