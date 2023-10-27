function crabs (level)

  %initialize command and map dimensions and draw map
   cmd = "null";
   [mapHeight,mapWidth] = drawMap("BGImage.png");

  %initialize captain location, heading and size
    xCapt = 1000;
    yCapt = 500;
    thetaCapt = -pi/2;
    sizeCapt = 50;
    healthCapt = 100;
    crabsCaught = 0;

    xNet = -100;
    yNet = -100;

  %initialize crab location, heading and size
    xCrab = 1000;
    yCrab = 1200;
    thetaCrab = -pi/2;
    sizeCrab = 50;

    % init jellyfish values
    xJelly = rand*mapWidth;
    yJelly = 0;
    thetaJelly = -pi/2;
    sizeJelly = 25;
    jellySting = 2;

    %draw initial captain and crab
    captGraphics = drawCapt(xCapt,yCapt,thetaCapt,sizeCapt);
    crabGraphics = drawCrab(xCrab,yCrab,thetaCrab,sizeCrab);
    jellyGraphics = drawJelly(xJelly, yJelly, thetaJelly, sizeJelly);

%%%%%          main loop       %%%%%%%%%%

healthLoc = [100,100];
crabsCaughtLoc = [100,175];
healthStatus = text(healthLoc(1), healthLoc(2), strcat('Health = ', ...
num2str(healthCapt)), 'FontSize', 12, 'Color', 'red');
crabsCaughtStatus = text(crabsCaughtLoc(1), crabsCaughtLoc(2), ...
strcat('Crabs Caught = ',num2str(crabsCaught)), 'FontSize', 12, 'Color', 'red');


  while (1) % while not quit read keyboard and respond
    % update UI
    delete(healthStatus);
    delete(crabsCaughtStatus);
    healthStatus = text(healthLoc(1), healthLoc(2), strcat('Health = ', ...
    num2str(healthCapt)), 'FontSize', 12, 'Color', 'red');
    crabsCaughtStatus = text(crabsCaughtLoc(1), crabsCaughtLoc(2),
    strcat('Crabs Caught = ', ...
      num2str(crabsCaught)), 'FontSize', 12, 'Color', 'red');


    % erase old jellyfish
    for i=1:length(jellyGraphics)
      delete(jellyGraphics(i));
    endfor

    % move jellyfish
    [xJelly,yJelly,thetaJelly] = moveJelly(level, xJelly, yJelly,thetaJelly, sizeJelly, mapHeight,mapWidth);

    % draw jellyfish
    jellyGraphics = drawJelly(xJelly,yJelly,thetaJelly,sizeJelly);

    %read the keyboard.
     cmd = kbhit(1);
     if(cmd == "q")
      break;
     endif

     if( cmd == "w" || cmd == "a" || cmd == "d" ) %respond to keyboard. captain has moved

       %erase old captain
        for i=1:length(captGraphics)
          delete(captGraphics(i));
        endfor

        %move capt
        [xCapt,yCapt,thetaCapt] = moveCapt(cmd,xCapt,yCapt,thetaCapt,sizeCapt, mapHeight, mapWidth);

        %draw new capt
        [captGraphics, xNet, yNet] = drawCapt(xCapt,yCapt,thetaCapt,sizeCapt);

 elseif (cmd == "i" || cmd == "j" || cmd == "k" || cmd == "l" || cmd ==",") % respond crab moved

        %erase old crab
        for i=1:length(crabGraphics)
          delete(crabGraphics(i));
        endfor

        %move crab
        [xCrab,yCrab,thetaCrab] = moveCrab(cmd,xCrab,yCrab,thetaCrab,sizeCrab, mapHeight, mapWidth);

        %draw new captain and crab
        crabGraphics = drawCrab(xCrab,yCrab,thetaCrab,sizeCrab)
 endif
    %crab is caught
    if( getDist(xNet,yNet,xCrab,yCrab) < 2*sizeCapt )
      %keep track of how many crabs are caught
      crabsCaught++;

      %erase old crab
      for i=1:length(crabGraphics)
        delete(crabGraphics(i));
      endfor

      %create a new crab. initialize new crab location, heading and size
      xCrab = rand*mapWidth;
      yCrab = rand*mapHeight;
      thetaCrab = -pi/2;
      sizeCrab = 50;

      %draw new crab
      crabGraphics = drawCrab(xCrab,yCrab,thetaCrab,sizeCrab);
    endif

    if(getDist(xJelly,yJelly,xCapt,yCapt) <= 3*sizeCapt)
      healthCapt -= jellySting;
    endif

 fflush(stdout);
 pause(0.01);

endwhile

close all
clear

endfunction

