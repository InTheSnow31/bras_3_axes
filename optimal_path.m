function path = optimal_path(begin_node, goal_node, obstacles)
% A* pas forcément optimal mais facilité pour ce cas
%
% begin_node : [x y]
% goal_node  : [x y]
% obstacles  : Nx4 matrix [x0 y0 w h]
%
% path       : Mx2 matrix of nodes [x y] 

    % Déclarations
    [min_x_value, max_x_value, min_y_value, max_y_value] = border_limits(begin_node, goal_node, obstacles)
    grid_size = [(max_x_value - min_x_value + 1) (max_y_value - min_y_value + 1)];

    % Pour le bazar des coordonnées, on déduit d'abord les coordonéens
    % minimums de partout pour avoir les mêmes coordonnées que le tableau
    % qu'on va utiliser (merci matlab de commencer à 1...) 
    new_begin_node = [begin_node(1) - min_x_value + 1, begin_node(2) - min_y_value + 1];
    new_goal_node = [goal_node(1) - min_x_value + 1, goal_node(2) - min_y_value + 1];
    fprintf("Nouveaux noeuds : \n Départ : (%d, %d) \n Objectif : (%d, %d) \n", new_begin_node(1), new_begin_node(2), new_goal_node(1), new_goal_node(2))

    directions = [1 0; 1 1; 0 1; -1 1; -1 0; -1 -1; 0 -1; 1 -1;];
    openSet = []; % Ensembles de [x, y, g, h, f]
    closedSet = false(grid_size(1), grid_size(2)); % Noeuds parcourus

    % Cost maps
    gScore = inf(grid_size(1), grid_size(2)); % Distances initalisées à l'infini
    parent = zeros(grid_size(1), grid_size(2), 2); %Parent (x,y)

    % Initialisations
    gScore(new_begin_node(1) , new_begin_node(2)) = 0;
    h0 = heuristique(new_begin_node, new_goal_node);
    openSet = [new_begin_node(1) new_begin_node(2) 0 h0 h0];

    fprintf("Initialisation finie \n")
    while ~isempty(openSet)
        % Recherche de l'heuristique minimal dans openSet
        [~, idx] = min(openSet(:,3));
        current = openSet(idx,:);
        openSet(idx,:) = []; % On supprime la ligne correspondante

        x = current(1);
        y = current(2);        
        fprintf("> Noeud (%d, %d) dans la boucle \n",x,y)

        % Vérification si c'est l'objectif
        if x == new_goal_node(1) && y == new_goal_node(2)
            path = reconstruct_path(parent, new_begin_node, new_goal_node, min_x_value, min_y_value);
            return;
        end

        closedSet(x,y) = true;
        
        fprintf('>> Recherche des voisins \n')
        % On visite les voisins
        for i = 1:size(directions,1)
            xn = x + directions(i,1);
            yn = y + directions(i,2);
            fprintf(">>> Voisin examiné : (%d, %d)\n", xn, yn)
       
            if ~is_valid(xn, yn, grid_size, obstacles, min_x_value, min_y_value)
                continue;
            end

            if closedSet(xn, yn)
                continue;
            end

            if mod(i,2) == 0
                diff_g = 1.41421; %diagonale
            else
                diff_g = 1;
            end
            
            tentative_g = gScore(x,y) + diff_g;

            if tentative_g < gScore(xn, yn)
                parent(xn, yn, :) = [x y];
                gScore(xn, yn) = tentative_g;
                h = heuristique([xn, yn], goal_node);
                f = tentative_g + h;

                % Add or update open set
                openSet = add_or_update(openSet, [xn yn tentative_g h f]);
            end
        end
    end

    % No path found
    path = [];
end


% Limites du terrain de recherche
function [min_x_value, max_x_value, min_y_value, max_y_value] = border_limits(begin_node, goal_node, obstacles)
    min_x_value = min(begin_node(1), goal_node(1));
    max_x_value = max(begin_node(1), goal_node(1));
    min_y_value = min(begin_node(2), goal_node(2));
    max_y_value = max(begin_node(2), goal_node(2));

    for i = 1:size(obstacles,1)
        x0 = obstacles(i,1);
        y0 = obstacles(i,2);
        w = obstacles(i,3);
        h = obstacles(i,4);
        
        x_min_obstacle = x0;
        y_min_obstacle = y0;
        x_max_obstacle = x0 + w;
        y_max_obstacle = y0 + h;
        
        if x_min_obstacle < min_x_value  + 1
            min_x_value = x_min_obstacle - 1;
        end

        if x_max_obstacle > max_x_value - 1
            max_x_value = x_max_obstacle + 1;
        end
        
        if y_min_obstacle < min_y_value + 1
            min_y_value = y_min_obstacle - 1;
        end

        if y_max_obstacle > max_y_value - 1
            max_y_value = y_max_obstacle + 1;
        end
    end 
end


% Heuristique
function h = heuristique(node, goal)
    h = abs(goal(1)-node(1)) + abs(goal(2)-node(2)); 
end

%
function openSet = add_or_update(openSet, node)
    % node = [x y g h f]
    if isempty(openSet)
        openSet = node;
        return;
    end
    for i = 1:size(openSet,1)
        if openSet(i,1) == node(1) && openSet(i,2) == node(2)
            if node(5) < openSet(i,5)
                openSet(i,:) = node;
            end
            return;
        end
    end
    openSet = [openSet; node];
end

% Teste si un moove est valide par rapport à un obstacle

function valid = is_valid(x, y, grid_size, obstacles, x_min, y_min)
    
    % Limites par rapport à la grille
    if x < 1 || y < 1 || x > grid_size(1) || y > grid_size(2)
        valid = false;
        fprintf(">>>> Dépasse les limites \n")
        return;
    end

    % Limites par rapport aux obstacles
    for i = 1:size(obstacles,1)
        x0 = obstacles(i,1) - x_min + 1;
        y0 = obstacles(i,2) - y_min + 1;
        w  = obstacles(i,3);
        h  = obstacles(i,4);

        if x >= x0 && x <= x0 + w && y >= y0 && y <= y0 + h
            valid = false;
            return;
        end
    end

    valid = true;
end

% RECONSTRUCTION DU CHEMIN

function path = reconstruct_path(parent, start_node, goal_node, x_min, y_min)

    path = goal_node+[x_min-1, y_min-1];
    current = goal_node;

    while ~(current(1) == start_node(1) && current(2) == start_node(2))
        px = parent(current(1), current(2), 1);
        py = parent(current(1), current(2), 2);

        if px == 0 && py == 0
            path = [];
            return;
        end

        current = [px py];
        path = [current+[x_min-1, y_min-1]; path];
    end
end