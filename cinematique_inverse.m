function [q,erreur] = cinematique_inverse(dims,q0,x,y,angle)
    q = q0;
    for k=1:100
        [F,J] = diff(dims,q,x,y,angle);
        q = q - J\F;
        if(norm(F) < 10^-6)
            break;
        end
    
    end
    erreur = norm(F);
end

function [F,J] = diff(dims,q,x,y,angle)
F = [(dims(1) * cos(q(1)) + dims(2) * cos(q(1) + q(2)) + dims(3) * cos(q(1)+q(2)+q(3)) + dims(4) * cos(q(1) + q(2) + q(3) + q(4)) - x);
    (dims(1) * sin(q(1)) + dims(2) * sin(q(1) + q(2)) + dims(3) * sin(q(1)+q(2)+q(3)) + dims(4) * sin(q(1) + q(2) + q(3) + q(4)) - y); 
    (q(1)+q(2)+q(3)+q(4)) - angle];
J = [dims(1) * -sin(q(1)) + dims(2) * -sin(q(1) + q(2)) + dims(3) * -sin(q(1)+q(2)+q(3)) + dims(4) * -sin(q(1) + q(2) + q(3) + q(4)), dims(2) * -sin(q(1) + q(2)) + dims(3) * -sin(q(1)+q(2)+q(3)) + dims(4) * -sin(q(1) + q(2) + q(3) + q(4)), dims(3) * -sin(q(1)+q(2)+q(3)) + dims(4) * -sin(q(1) + q(2) + q(3) + q(4)), dims(4) * -sin(q(1) + q(2) + q(3) + q(4));
     dims(1) * cos(q(1)) + dims(2) * cos(q(1) + q(2)) + dims(3) * cos(q(1)+q(2)+q(3)) + dims(4) * cos(q(1) + q(2) + q(3) + q(4)), dims(2) * cos(q(1) + q(2)) + dims(3) * cos(q(1)+q(2)+q(3)) + dims(4) * cos(q(1) + q(2) + q(3) + q(4)), dims(3) * cos(q(1)+q(2)+q(3)) + dims(4) * cos(q(1) + q(2) + q(3) + q(4)), dims(4) * cos(q(1) + q(2) + q(3) + q(4));
     1,1,1,1 ];
end