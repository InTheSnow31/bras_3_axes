
%% Dimensionement du robot
dims = [1 1 2 1];


%% Dessin du robot
%%hold on
%%dessin_bras(dims,[pi/2 pi/4 pi/4 pi/4])
%%hold off

%% Cinematique directe
%%cinematique_directe(dims,[-pi/2 pi/4 pi/4 pi/4])

%% Cinematique inverse
%%[q,erreur] = cinematique_inverse(dims,[-pi/2 pi/4 pi/4 pi/4],0,0,pi/4)
%%dessin_bras(dims,q)
%%from_a_to_b_linear(dims, [2 2]s, [2 3])

%%optimal_path([0, 1], [0, 4], [[0 2 1 1]])
from_a_to_b_smart(dims, [0, 1], [0, 4], [[0 2 1 1]])