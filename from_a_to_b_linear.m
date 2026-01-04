function q = from_a_to_b_linear(dims, a, b, angle, obstacles, q)
    %[q_a,erreur1] = cinematique_inverse_obstacle(dims,[-pi/2 pi/4 pi/4 pi/4],a(1),a(2),pi/4,obstacles)
    %[q_b, erreur2] = cinematique_inverse_obstacle(dims,[-pi/2 pi/4 pi/4 pi/4],b(1),b(2),pi/4,obstacles)
    %q_a = mod(q_a + pi, 2*pi) - pi;
    %q_b = mod(q_b + pi, 2*pi) - pi;
    %q = cinematique_inverse_obstacle(dims,q ,obstacles)
    N = 10;  % nombre de frames pour l'animation
    % Boucle d'animation
    %dq = mod(q_b - q_a + pi, 2*pi) - pi;  % différence minimale [-pi, pi]
    dc = b - a;
    for k = 0:N
        % interpolation linéaire des angles
        %q = q_a + dq * (k / N);
        c = a + dc * (k / N);
        [q_plus1, erreur] = cinematique_inverse_obstacle(dims, q ,c(1),c(2),angle,obstacles);
        cla   % efface uniquement le contenu des axes
        xlim([-2 6])
        ylim([-2 6])
        pbaspect([1 1 1])  % rapport fixe
        axis manual         % verrouille les axes
        dessin_obstacles(obstacles)
        dessin_bras(dims, q_plus1)
        
        drawnow   % met à jour la figure
        pause(0.001)  % petite pause pour voir le mouvement
        q = q_plus1;
    end
end