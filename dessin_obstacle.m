function dessin_obstacle(obstacle_coords)
    hold on
    rectangle('Position', obstacle_coords, 'EdgeColor', 'g', 'LineWidth', 2)
    hold off
end