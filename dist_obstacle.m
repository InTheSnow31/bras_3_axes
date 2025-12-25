% obstacle = [1 0 1 1]; % x0 y0 lx ly
% dims = [1 1 2 1];
% q =[-4.6702   -5.4556   -5.4556   -5.4556;
%      6.8843    6.0989    6.0989    6.0989;
%      3.8132    3.0278    3.0278    3.0278;
%     -5.2418   -6.0272   -6.0272   -6.0272]

function min_distance = dist_obstacle(dims,q,obstacle)
    min_distance = inf;

    % Coins du rectangle

    c0 = [obstacle(1), obstacle(2)];
    c1 = [obstacle(1)+obstacle(3), obstacle(2)];
    c2 = [obstacle(1)+obstacle(3), obstacle(2)+obstacle(4)];
    c3 = [obstacle(1), obstacle(2)+obstacle(4)];

    corners = [c0;
               c1;
               c2;
               c3];

    repere0 = trans(0,0);
    repere1 = repere0 * rot(q(1)) *  trans(dims(1),0);
    repere2 = repere1 * rot(q(2)) *  trans(dims(2),0);
    repere3 = repere2 * rot(q(3)) *  trans(dims(3),0);
    repere4 = repere3 * rot(q(4)) *  trans(dims(4),0);

    joints = [repere0(1,3),repere0(2,3);
              repere1(1,3),repere1(2,3);
              repere2(1,3),repere2(2,3);
              repere3(1,3),repere3(2,3);
              repere4(1,3),repere4(2,3)];

    min_distance = min(min_distance, distance_point_segment(corners, [repere0(1,3),repere1(1,3)], [repere0(2,3),repere1(2,3)]));
    min_distance = min(min_distance, distance_point_segment(corners, [repere1(1,3),repere2(1,3)], [repere1(2,3),repere2(2,3)]));
    min_distance = min(min_distance, distance_point_segment(corners, [repere2(1,3),repere3(1,3)], [repere2(2,3),repere3(2,3)]));
    min_distance = min(min_distance, distance_point_segment(corners, [repere3(1,3),repere4(1,3)], [repere3(2,3),repere4(2,3)]));

    min_distance = min(min_distance, distance_point_segment(joints, [c0(1), c1(1)], [c0(2), c1(2)]));
    min_distance = min(min_distance, distance_point_segment(joints, [c1(1), c2(1)], [c1(2), c2(2)]));
    min_distance = min(min_distance, distance_point_segment(joints, [c2(1), c3(1)], [c2(2), c3(2)]));
    min_distance = min(min_distance, distance_point_segment(joints, [c3(1), c0(1)], [c3(2), c0(2)]));

end

function min_dist = distance_point_segment(points, seg_x, seg_y)
    % Calcule la distance minimale entre plusieurs points et un segment
    
    P1 = [seg_x(1), seg_y(1)];
    P2 = [seg_x(2), seg_y(2)];
    
    min_dist = inf;
    
    for i = 1:size(points, 1)
        point = points(i, :);
        
        % Vecteur du segment
        seg_vec = P2 - P1;
        seg_length_sq = dot(seg_vec, seg_vec);
        
        if seg_length_sq == 0
            % Le segment est un point
            dist = norm(point - P1);
        else
            % Projection du point sur la droite du segment
            t = dot(point - P1, seg_vec) / seg_length_sq;
            
            % Contraindre t à [0,1] pour rester sur le segment
            t = max(0, min(1, t));
            
            % Point le plus proche sur le segment
            closest = P1 + t * seg_vec;
            
            % Distance
            dist = norm(point - closest);
        end
        
        min_dist = min(min_dist, dist);
    end
end