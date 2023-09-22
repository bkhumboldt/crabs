function rotation = getRotation (thetaCapt)

  theta = thetaCapt * (pi/180);
  rotation = [cos(theta), -sin(theta), 0; sin(theta), cos(theta), 0; 0, 0, 1];

endfunction
