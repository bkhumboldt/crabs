function [xCrab,yCrab,thetaCrab] = moveCrab(cmd,x,y,theta,size,height,width)

  dTheta = pi/6;
  dStep = 50;

  if(cmd == "i")
    xCrab = x;
    yCrab = y;
    thetaCrab = theta + dTheta;
  elseif(cmd == ",")
    xCrab = x;
    yCrab = y;
    thetaCrab = theta - dTheta;
  elseif(cmd == "j")
    xCrab = x + dStep*sin(theta);
    yCrab = y - dStep*cos(theta);
    thetaCrab = theta;
  elseif(cmd == "l")
    xCrab = x - dStep*sin(theta);
    yCrab = y + dStep*cos(theta);
    thetaCrab = theta;
  elseif(cmd == "k")
    xCrab = x - dStep*cos(theta);
    yCrab = y - dStep*sin(theta);
    thetaCrab = theta;
  else
    xCrab = x;
    yCrab = y;
    thetaCrab = theta;
  endif

  if(xCrab < size || xCrab > width-size)
    xCrab = x;
  endif

  if(yCrab < size || yCrab > height-size)
    yCrab = y;
  endif

endfunction
