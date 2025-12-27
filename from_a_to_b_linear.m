function from_a_to_b(dims, a, b)
    [q_a,erreur1] = cinematique_inverse(dims,[-pi/2 pi/4 pi/4 pi/4],a(1),a(2),pi/4)
    [q_b, erreur2] = cinematique_inverse(dims,[-pi/2 pi/4 pi/4 pi/4],b(1),b(2),pi/4)
    q_a = mod(q_a + pi, 2*pi) - pi;
    q_b = mod(q_b + pi, 2*pi) - pi;
    N = 25;  % nombre de frames pour l'animation
    % Création de la figure
    figure;
    axis equal
    xlim([-2 4])
    ylim([-2 4])
    % Boucle d'animation
    dq = mod(q_b - q_a + pi, 2*pi) - pi;  % différence minimale [-pi, pi]
    for k = 0:N
        % interpolation linéaire des angles
        q = q_a + dq * (k / N);
        
        cla   % efface uniquement le contenu des axes
        xlim([-2 4])
        ylim([-2 4])
        pbaspect([1 1 1])  % rapport fixe
        axis manual         % verrouille les axes
        
        dessin_bras(dims, q)
        
        drawnow   % met à jour la figure
        pause(0.001)  % petite pause pour voir le mouvement
    end
end