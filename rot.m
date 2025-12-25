  function T=rotx(theta_rad)
    c=cos(theta_rad); s=sin(theta_rad);
    T=[[ c,-s, 0]
       [ s, c, 0]       
       [ 0, 0, 1]       
      ]; 
  end
