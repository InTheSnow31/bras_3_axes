function dessin_bras(dims,q)
    hold on
    axis equal
    set(gca, 'Color', 'w');   % fond de la figure en blanc
    repere0 = trans(0,0);
    circle_color(repere0(1,3),repere0(2,3),0.1,[1 1 0])

    repere1 = repere0 * rot(q(1)) *  trans(dims(1),0);
    big_line(repere0, repere1)
    circle_color(repere1(1,3),repere1(2,3),0.1,[0 0 1])

    repere2 = repere1 * rot(q(2)) *  trans(dims(2),0);   
    big_line(repere1, repere2)
    circle_color(repere2(1,3),repere2(2,3),0.1,[0 0 1])

    repere3 = repere2 * rot(q(3)) *  trans(dims(3),0);
    big_line(repere2, repere3)
    circle_color(repere3(1,3),repere3(2,3),0.1,[0 0 1])

    repere4 = repere3 * rot(q(4)) *  trans(dims(4),0);
    big_line(repere3, repere4)
    circle_color(repere4(1,3),repere4(2,3),0.1,[1 0 1])

    hold off
end