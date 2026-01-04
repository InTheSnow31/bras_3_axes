function dessin_obstacles(obstacles)
% obstacles : Nx4 matrix [x0 y0 w h]
    if isempty(obstacles)
        return
    end

    hold on
    axis equal
    grid on

    for i = 1:size(obstacles,1)
        x0 = obstacles(i,1);
        y0 = obstacles(i,2);
        w  = obstacles(i,3);
        h  = obstacles(i,4);

        rectangle('Position',[x0 y0 w h], ...
                  'FaceColor',[0.7 0.7 0.7], ...
                  'EdgeColor','k', ...
                  'LineWidth',1.5);
    end

    hold off
end