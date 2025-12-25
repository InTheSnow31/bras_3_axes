function circle_color(x,y,r,color)
%x and y are the coordinates of the center of the circle
%r is the radius of the circle
%0.01 is the angle step, bigger values will draw the circle faster but
%you might notice imperfections (not very smooth)
ang=0:0.01:2*pi; 
xp=r*cos(ang);
yp=r*sin(ang);
%%c = plot(x+xp,y+yp,'Color',color);
h = fill(x+xp,y+yp, [0.4 0.4 0.4], 'EdgeColor', color, 'LineWidth', 3);
uistack(h, 'top'); 
end