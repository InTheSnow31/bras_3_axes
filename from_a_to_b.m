function from_a_to_b(a,b)
    [q_a,erreur1] = cinematique_inverse(dims,[-pi/2 pi/4 pi/4 pi/4],a(0),a(1),pi/4)
    [q_b, erreur2] = cinematique_inverse(dims,[-pi/2 pi/4 pi/4 pi/4],b(0),b(1),pi/4)
    N = 50;  % nombre de frames pour l'animation
    % Création de la figure
    figure;
    % Boucle d'animation
    for k = 0:N
        % interpolation linéaire des angles
        q = q_a + (q_b - q_a) * (k / N);
        
        cla   % efface uniquement le contenu des axes
        dessin_bras(dims, q)
        
        drawnow   % met à jour la figure
        pause(0.02)  % petite pause pour voir le mouvement
    end
end