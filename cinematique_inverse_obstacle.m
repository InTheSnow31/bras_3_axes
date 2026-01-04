function [sol_q,sol_err] = cinematique_inverse_obstacle(dims,q0,x,y,angle,obstacle)
    % Applique la cinématique inverse en tenant compte de l'obstacle
    [sol_q,sol_err] = cinematique_inverse_obstacle_genetique(dims,q0,x,y,angle,obstacle);
end

function [sol_q,sol_err] = cinematique_inverse_obstacle_aleatoire(dims,q0,x,y,angle,obstacle)
    % Itere la cinematique inverse plusieur fois jusqu'a trouver une solution 
    n_iter = 500;
    min_distance = 0.1;

    sol_found = false;

    q = q0;
    for k=1:n_iter
        q = 2*pi * rand(4,1);
        [res_q,res_err] = cinematique_inverse(dims,q,x,y,angle);
        if(res_err < 10^-3 && check_obstacle(dims,res_q,obstacle) && dist_obstacle(dims,res_q,obstacle) > min_distance)
            sol_q = res_q;
            sol_err = res_err;
            sol_found = true;
            break;
        end
    end
    if(~sol_found)
        error("Pas de solution trouvée pour l'obstacle donné")
    end
end

function [sol_q,sol_err] = cinematique_inverse_obstacle_genetique(dims,q0,x,y,angle,obstacle)
    % Itere la cinematique inverse plusieur fois jusqu'a trouver une solution 
    n_pop = 500; % Taille population (valeur initiale)
    n_gen = 3; % Nombre de génération
    n_parent = 1; % Nombre de parents séléctionner
    n_child = 25; % Nombre d'enfants par parent
    alpha = 0.1; % Taux de mutation
    % Initialisation de la population, qui sont des positions aléatoire
    population = repmat(q0, 1, n_pop) + 2 * pi * rand(4, n_pop);
    for gen = 1:n_gen
        % Evaluate fitness and select parents
        fitness = zeros(1, n_pop);
        for i = 1:n_pop
            [q,err] = cinematique_inverse(dims, population(:, i), x, y, angle);
            if(check_obstacle(dims,q,obstacle))
                fitness(i) = dist_obstacle(dims,q,obstacle) - err;
            else
                fitness(i) = -1;
            end
            
        end
        % Selection sur la fitness (distance à l'obstacle)
        [fit, idx] = sort(fitness,"descend");
        parents = population(:, idx(1:n_parent));

        if(fit(1) < 0.0) % Aucune solution correcte dans la population
            error("Pas de solution trouvée pour l'obstacle donné")
        end
        
        % Generation de la génération suivante
        for p = 1:n_parent
            selected_parent = parents(:, p);
            for j = 1:n_child
                child = selected_parent + alpha * rand(4, 1); % mutation
                population(:, p + j) = child; % Ajout de l'enfant
            end
        end
        n_pop = n_parent*n_child;
    end

     [sol_q,sol_err] = cinematique_inverse(dims,selected_parent,x,y,angle);
end