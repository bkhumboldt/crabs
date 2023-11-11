function crabs (level)
  numCrabs = level;
  numJelly = level;

  %initialize command and map dimensions and draw map
   cmd = "null";
   [mapHeight,mapWidth] = drawMap("BGImage.png");

   KeyNames = {'w', 'a', 's', 'd'};
   KeyStatus = false(1,length(KeyNames));

   set(gcf, 'KeyPressFcn', @stl_KeyDown);
   set(gcf, 'KeyReleaseFcn', @stl_KeyUp);

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
    xCrab = rand(1,numCrabs)*mapWidth;
    yCrab = 3*mapHeight/4 + rand(1,numCrabs)*mapHeight/4;
    thetaCrab = ones(1,numCrabs)*(-pi/2);
    crabsCaught = 0;
    sizeCrab = 50;
    isCrabCaught = zeros(1,numCrabs);

    % init jellyfish values
    xJelly = rand(1,numJelly)*mapWidth;
    yJelly = rand(1,numJelly)*mapHeight;
    thetaJelly = -pi/2;
    sizeJelly = 25;
    jellySting = 2;

    %draw initial captain and crab
    captGraphics = drawCapt(xCapt,yCapt,thetaCapt,sizeCapt);
    %draw crabs
    for k=1:numCrabs
      crabGraphics(:,k) = drawCrab(xCrab(k),yCrab(k),thetaCrab(k),sizeCrab);
    endfor

    for j=1:numJelly
      jellyGraphics(:,j) = drawJelly(xJelly(j), yJelly(j), thetaJelly, sizeJelly);
    endfor
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
    for j=1:numJelly
      for i=1:length(jellyGraphics(:,j))
        delete(jellyGraphics(i,j));
      endfor

      [xJelly(j),yJelly(j),thetaJelly] = moveJelly(level, xJelly(j), yJelly(j),thetaJelly, sizeJelly, mapHeight,mapWidth);

      % draw jellyfish
      jellyGraphics(:,j) = drawJelly(xJelly(j),yJelly(j),thetaJelly,sizeJelly);

      if(getDist(xJelly(j),yJelly(j),xCapt,yCapt) <= 3*sizeCapt)
        healthCapt -= jellySting;
      endif

    endfor

    %read the keyboard.
     % cmd = kbhit(1);

     % if( cmd == "w" || cmd == "a" || cmd == "d" ) %respond to keyboard. captain has moved
     if(any(KeyStatus))

       %erase old captain
        for i=1:length(captGraphics)
          delete(captGraphics(i));
        endfor

        %move capt
        [xCapt,yCapt,thetaCapt] = moveCapt(KeyStatus,xCapt,yCapt,thetaCapt,sizeCapt, mapHeight, mapWidth);

        %draw new capt
        [captGraphics, xNet, yNet] = drawCapt(xCapt,yCapt,thetaCapt,sizeCapt);

endif

    for k=1:numCrabs
      if( !isCrabCaught(k) && getDist(xNet,yNet,xCrab(k),yCrab(k)) < 2*sizeCapt ) %crab is caught
        crabsCaught = crabsCaught + 1;
        isCrabCaught(k) = 1;
        %erase old crab
        for i=1:length(crabGraphics(:,k))
          delete(crabGraphics(i,k));
        endfor
      endif
    endfor


    if(cmd == "q" || crabsCaught >= numCrabs || healthCapt <= 0)
      break;
    endif

 fflush(stdout);
 pause(0.025);

endwhile

close all
clear

  function stl_KeyUp(hObject, eventdata, handles)
    LastKeyStatus = KeyStatus;
    key = eventdata.Character;
    KeyStatus = (~strcmp(key, KeyNames) & LastKeyStatus);
  endfunction
  function stl_KeyDown(hObject, eventdata, handles)
    LastKeyStatus = KeyStatus;
    key = eventdata.Character;
    KeyStatus = (strcmp(key, KeyNames) | LastKeyStatus);
  endfunction

endfunction

