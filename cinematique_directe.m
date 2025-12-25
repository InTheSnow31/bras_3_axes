function p = cinematique_directe(dims,q)
    repere0 = trans(0,0);
    repere1 = repere0 * rot(q(1)) * trans(dims(1),0);
    repere2 = repere1 * rot(q(2)) * trans(dims(2),0);
    repere3 = repere2 * rot(q(3)) * trans(dims(3),0);
    repere4 = repere3 * rot(q(4)) * trans(dims(4),0);
    p = [repere4(3,1),repere4(3,2),sum(q)];
end