function angle = getMouseAngle (x, y, mousePos)

  mouseVector = [mousePos(1,1) - x,mousePos(1,2) - y];
  angle = atan(mouseVector(2)/mouseVector(1));
  if(mouseVector(1) < 0)
   angle += pi;
  endif

endfunction
