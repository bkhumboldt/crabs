function crabs (level)

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

    % init jellyfish values
    xJelly = rand*mapWidth;
    yJelly = 0;
    thetaJelly = -pi/2;
    sizeJelly = 25;

    %draw initial captain and crab
    captGraphics = drawCapt(xCapt,yCapt,thetaCapt,sizeCapt);
    crabGraphics = drawCrab(xCrab,yCrab,thetaCrab,sizeCrab);
    jellyGraphics = drawJelly(xJelly, yJelly, thetaJelly, sizeJelly);

%%%%%          main loop       %%%%%%%%%%

  while (1) % while not quit read keyboard and respond

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

 fflush(stdout);
 pause(0.01);

endwhile

close all
clear

endfunction

