function [ xCapt, yCapt, thetaCapt ] = moveCapt( cmd, x, y, theta, size, height, width);

  dTheta = pi/6;
  dStep = 50;

  xCapt = x;
  yCapt = y;
  thetaCapt = theta;

  if( cmd(1) )% == "w" ) %move forward
    xCapt = x + (dStep * cos(theta));
    yCapt = y + (dStep * sin(theta));
  endif

  if ( cmd(4) ) % == "d" ) %turn right
    thetaCapt = theta + dTheta;
  endif

  if ( cmd(2) ) % == "a" ) %turn left
    thetaCapt = theta - dTheta;
  endif
  % if none of the cases are true, set the new variables equal to the old inputs.

  if(xCapt < size || xCapt > width-size)
    xCapt = x;
  endif

  if(yCapt < size || yCapt > height-size)
    yCapt = y;
  endif

endfunction

