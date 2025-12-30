function [sol_q,sol_err] = cinematique_inverse_obstacle(dims,q0,x,y,angle,obstacle)
    % Applique la cinématique inverse en tenant compte de l'obstacle
    [sol_q,sol_err] = cinematique_inverse_obstacle_aleatoire(dims,q0,x,y,angle,obstacle)
end

function [sol_q,sol_err] = cinematique_inverse_obstacle_aleatoire(dims,q0,x,y,angle,obstacle)
    % Itere la cinematique inverse plusieur fois jusqu'a trouver une solution 
    n_iter = 100
    min_distance = 0.1;

    q = q0;
    for k=1:n_iter
        q = 2*pi * rand(4,1);
        [res_q,res_err] = cinematique_inverse(dims,q,x,y,angle)
        if(res_err < 10^-3 && check_obstacle(dims,res_q,obstacle) && dist_obstacle(dims,q,obstacle) > min_distance)
            sol_q = res_q;
            sol_err = res_err;
            break;
        end
    end
end