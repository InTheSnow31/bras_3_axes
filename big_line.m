function big_line(r1,r2)

    l1 = line([r1(1,3),r2(1,3)],[r1(2,3),r2(2,3)], 'Color', [0.2 0.2 0.2], 'LineWidth', 15);
    l2 = line([r1(1,3),r2(1,3)],[r1(2,3),r2(2,3)], 'Color', [0.5 0.5 0.5], 'LineWidth', 10);
    
    uistack(l2, 'bottom'); 
    uistack(l1, 'bottom'); 
end