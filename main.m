
%% Dimensionement du robot
dims = [1 1 2 1];


%% Dessin du robot
%%hold on
%%dessin_bras(dims,[pi/2 pi/4 pi/4 pi/4])
%%hold off

%% Cinematique directe
%%cinematique_directe(dims,[-pi/2 pi/4 pi/4 pi/4])

%% Cinematique inverse
[q,erreur] = cinematique_inverse(dims,[-pi/2 pi/4 pi/4 pi/4],1,1,pi/4)
dessin_bras(dims,q)