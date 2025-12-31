%% 
clear all;close all;clc;
axis equal

%% Dimensionement du robot
dims = [1; 1; 2; 1];

%% Dessin du robot
dessin_bras(dims,[pi/2; pi/4; pi/4; pi/4]);

%% Dessin de l'obstacle
obstacle = [1 0 1 3]; % x0 y0 lx ly
dessin_obstacle(obstacle);

%% Cinematique directe
cinematique_directe(dims,[-pi/2; pi/4; pi/4; pi/4]);

%% Cinematique inverse
[q,erreur] = cinematique_inverse_obstacle(dims,[pi/2; pi/4; pi/4; pi/4],3,1,pi/2,obstacle)
dessin_bras(dims,q);

obstacle_clear = check_obstacle(dims,q,obstacle);
min_dist = dist_obstacle(dims,q,obstacle);
