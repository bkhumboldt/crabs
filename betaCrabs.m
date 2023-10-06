function betaCrabs ()
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

  lastMouse = get(gca,'CurrentPoint');

  TARGET_FPS = 60;
  CAPT_SPEED = 40;

  while(true)
    tic;
    for i = captainLines
      % set(i,'Visible','off');
      delete(i);
    endfor

    mousePos = get(gca,'CurrentPoint');
    if(mousePos(1) != lastMouse(1) || mousePos(1,2) != lastMouse(1,2))
      thetaCapt = getMouseAngle(xCapt, yCapt, mousePos);
      lastMouse = mousePos;
      % CAPT_SPEED = 10;
      % printf("%s", "Updated mouse ");
    endif

    velocity = [lastMouse(1,1) - xCapt, lastMouse(1,2) - yCapt];
    if(abs(velocity(1)) > CAPT_SPEED || abs(velocity(1,2)) > CAPT_SPEED)
      velocity = velocity / (hypot(velocity(1,1), velocity(1,2)));
      xCapt += velocity(1,1) * CAPT_SPEED;
      yCapt += velocity(1,2) * CAPT_SPEED;
      % CAPT_SPEED += 1;
    endif

    captainLines = drawCapt(xCapt, yCapt, thetaCapt, sizeCapt);

    if(kbhit(1) == 'q')
      break;
    endif

    pause(1/TARGET_FPS);
    endtime = toc;
    printf("%f", endtime - (1/TARGET_FPS));
    printf("%s", " ");
  endwhile

  close;

endfunction

