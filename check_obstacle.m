% obstacle = [1 0 1 1]; % x0 y0 lx ly
% dims = [1 1 2 1];
% q =[-4.6702   -5.4556   -5.4556   -5.4556;
%      6.8843    6.0989    6.0989    6.0989;
%      3.8132    3.0278    3.0278    3.0278;
%     -5.2418   -6.0272   -6.0272   -6.0272]

function obstacle_clear = check_obstacle(dims,q,obstacle)
    obstacle_clear = true;

    repere0 = trans(0,0);
    repere1 = repere0 * rot(q(1)) *  trans(dims(1),0);
    %line([repere0(1,3),repere1(1,3)],[repere0(2,3),repere1(2,3)],'Color',[0 0 1])
    if check_segment([repere0(1,3),repere1(1,3)], [repere0(2,3),repere1(2,3)], obstacle)
        obstacle_clear = false;
        return;
    end

    repere2 = repere1 * rot(q(2)) *  trans(dims(2),0);
    %line([repere1(1,3),repere2(1,3)],[repere1(2,3),repere2(2,3)],'Color',[0 0 1])
    if check_segment([repere1(1,3),repere2(1,3)],[repere1(2,3),repere2(2,3)], obstacle)
        obstacle_clear = false;
        return;
    end

    repere3 = repere2 * rot(q(3)) *  trans(dims(3),0);
    %line([repere2(1,3),repere3(1,3)],[repere2(2,3),repere3(2,3)],'Color',[0 0 1])
    if check_segment([repere2(1,3),repere3(1,3)],[repere2(2,3),repere3(2,3)], obstacle)
        obstacle_clear = false;
        return;
    end

    repere4 = repere3 * rot(q(4)) *  trans(dims(4),0);
    %line([repere3(1,3),repere4(1,3)],[repere3(2,3),repere4(2,3)],'Color',[0 0 1])
    if check_segment([repere3(1,3),repere4(1,3)],[repere3(2,3),repere4(2,3)], obstacle)
        obstacle_clear = false;
        return;
    end

end

%function collision = check_segment(seg_x, seg_y, obstacle)
%    rect_x = [obstacle(1), obstacle(1)+obstacle(3), obstacle(1)+obstacle(3), obstacle(1), obstacle(1)];
%    rect_y = [obstacle(2), obstacle(2), obstacle(2)+obstacle(4), obstacle(2)+obstacle(4), obstacle(2)];
%
%    [xi, ~] = polyxpoly(seg_x, seg_y, rect_x, rect_y); % test des intersections avec le rectangle
%
%    collision = ~isempty(xi);
%end

function collision = check_segment(seg_x, seg_y, obstacle)
    P1 = [seg_x(1), seg_y(1)];
    P2 = [seg_x(2), seg_y(2)];

    % Les 4 coins du rectangle
    corners = [
        obstacle(1), obstacle(2);
        obstacle(1)+obstacle(3), obstacle(2);
        obstacle(1)+obstacle(3), obstacle(2)+obstacle(4);
        obstacle(1), obstacle(2)+obstacle(4)
    ];

    % Tester avec chaque côté du rectangle
    for i = 1:4
        j = mod(i, 4) + 1;  % Index du coin suivant
        P3 = corners(i,:);
        P4 = corners(j,:);

        % Test d'intersection
        d1 = P2 - P1;
        d2 = P4 - P3;
        d3 = P1 - P3;

        denom = d1(1)*d2(2) - d1(2)*d2(1);

        if abs(denom) > 1e-10
            t = (d3(2)*d2(1) - d3(1)*d2(2)) / denom;
            u = (d3(2)*d1(1) - d3(1)*d1(2)) / denom;

            if t >= 0 && t <= 1 && u >= 0 && u <= 1
                collision = true;
                return;
            end
        end
    end

    collision = false;
end