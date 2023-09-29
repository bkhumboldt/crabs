function crabs ()
% Crabs is a kids computer game where a fisherman,  called the captain,
% hunts for a very clever and powerful crab.

 % Draw the game map and initialize map dimensions.
   [mapHeight , mapWidth] = drawMap( "BGImage.png" );

  % Initialize captain location,  heading and size
    xCapt   = 1000;
    yCapt  = 1000;
    thetaCapt  = -pi/2;
    sizeCapt  =  50;

  % Draw the captain and initialize graphics handles
%*********************************************************
  % Put your call to  drawCapt() here ….. You must give drawCapt its
   % input and output arguments.

   captainLines = drawCapt(xCapt, yCapt, thetaCapt, sizeCapt);

%*******************************************************

  while(true)
    for i = captainLines
      delete(i);
    endfor

    thetaCapt = getMouseAngle(xCapt, yCapt);

    captainLines = drawCapt(xCapt, yCapt, thetaCapt, sizeCapt);

    C = kbhit(1);
    if(C == 'q')
      break;
    endif

    pause(0.017);
  endwhile

  close;

endfunction

