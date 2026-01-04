function from_a_to_b_smart(dims, a, b, angle, obstacles)
    % Création de la figure
    figure;
    axis equal
    xlim([-2 4])
    ylim([-2 4])
    path = optimal_path(a, b, obstacles) 
    q = [-pi/2; pi/4; pi/4; pi/4];
    for i = 2:size(path,1)
        q = from_a_to_b_linear(dims, path(i-1,:), path(i,:), angle, obstacles, q);
    end
end