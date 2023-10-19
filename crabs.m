function crabs ()

  %initialize command and map dimensions and draw map
   cmd = "null";
   [mapHeight,mapWidth] = drawMap("BGImage.png");

  %initialize captain location, heading and size
    xCapt = 1000;
    yCapt = 500;
    thetaCapt = -pi/2;
    sizeCapt = 50;

  %initialize crab location, heading and size
    xCrab = 1000;
    yCrab = 1200;
    thetaCrab = -pi/2;
    sizeCrab = 50;

    %draw initial captain and crab
    captGraphics = drawCapt(xCapt,yCapt,thetaCapt,sizeCapt);
    crabGraphics = drawCrab(xCrab,yCrab,thetaCrab,sizeCrab);

%%%%%          main loop       %%%%%%%%%%

  while ( cmd != "Q") % while not quit read keyboard and respond

    %read the keyboard.
     cmd = kbhit();

     if( cmd == "w" || cmd == "a" || cmd == "d" ) %respond to keyboard. captain has moved

       %erase old captain
        for i=1:length(captGraphics)
          delete(captGraphics(i));
        endfor

        %move capt
        [xCapt,yCapt,thetaCapt] = moveCapt(cmd,xCapt,yCapt,thetaCapt,sizeCapt, mapHeight, mapWidth);

        %draw new capt
        captGraphics = drawCapt(xCapt,yCapt,thetaCapt,sizeCapt);

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

endwhile

close all
clear

endfunction

