function crabNinja ()

  GRAVITY = -0.0005;
  KEY_NAMES = {'w', 'a', 's', 'd', 'q', 'r'};

  KeyStatus = false(1,length(KEY_NAMES));
  isMouseDown = 0;

  clf;
  figure(1, 'KeyPressFcn', @KeyDown, ...
            'KeyReleaseFcn', @KeyUp, ...
            'WindowButtonMotionFcn', @MouseDragged, ...
            'WindowButtonDownFcn', @MouseClicked, ...
            'WindowButtonUpFcn', @MouseReleased,...
            'DeleteFcn', @EndLoop);

  score = 0;
  lives = 3;

  axis([1,1000,1,1000]);
  set(gca,'Visible', "off");
  for i=1:lives
    hearts(i) = patch([1000,950,950,1000]-(75*i),[1000,1000,950,950],'red');
  endfor
  scoreText = text(1,975,num2str(score),'FontSize', 35, 'Color', [1,0.65,0]);

  MAX_FISH = 18;

  for i=1:8
    [fishImages(i).X, fishImages(i).map] = imread(strcat("assets/fish",num2str(i),".png"));
    [cutFishImages(i).X, cutFishImages(i).map] = imread(strcat("assets/cutfish",num2str(i),".png"));
  endfor
  [crabImage.x, crabImage.map] = imread("assets/crab.png");

  for i=1:MAX_FISH
    fishes(i).frame = subplot("position", [1.1 + (0.2 * i),1.1,0.05,0.05]);
    if(i >= 3)
      if(i <= 8)
        index = i-2;
      else
        index = floor(i/2)-2;
      endif
      imshow(fishImages(index).X,fishImages(index).map);
    else
      imshow(crabImage.x, crabImage.map);
    endif
    fishes(i).velocity = [0,0];
    fishes(i).isDead = true;
    fishes(i).isCut = false;
    fishes(i).cutFrame = subplot("position", [1.1 + (0.2 * i),1.3,0.05,0.05]);
    if(i >= 3)
      if(i <= 8)
        index = i-2;
      else
        index = floor(i/2)-2;
      endif
      imshow(cutFishImages(index).X,cutFishImages(index).map);
    else
      imshow(crabImage.x, crabImage.map);
    endif

    fishes(i).currentFrame = fishes(i).frame;
  endfor
  pause(0.01);

  TARGET_FPS = 60;
  MAX_FRAME_SKIP = 5;

  FRAME_DURATION = 1/TARGET_FPS;

  isRunning = true;
  fishJumping = false;

  stageStartTime = tic;
  CurrentFrameNo = 0;
  while(isRunning)
      loops = 0;
      curTime = toc(stageStartTime);
      while(curTime >= ((CurrentFrameNo) * FRAME_DURATION) && loops < MAX_FRAME_SKIP)

        if(!fishJumping && KeyStatus(6))
          summonFish(5);
        endif

        fishJumping = false;
        for i=1:length(fishes)
          moveFish(i);
          if(!(fishes(i).isDead))
            fishJumping = true;
          endif
        endfor

        CurrentFrameNo = CurrentFrameNo + 1;
        loops = loops + 1;
      endwhile

      if(KeyStatus(5) || lives <= 0)
        break;
      endif

      pause(0.001);
  endwhile

  printf("%s", ["You got a score of ", num2str(score), "!\n"]);

  close all
  clear

  % Helper functions for better organization
  function summonFish(toSummon)
    % can be repeat numbers, but not really worried
    % because toSummon should be random anyway
    fishNums = floor((rand(1,toSummon) * 18) + 1);
    for i = fishNums
      tempPos = [(rand*0.9)-0.1, -0.4, 0.2, 0.2];
      if(tempPos(1) <= 0.3)
        xVelocity = (rand * 0.002) + 0.002;
      elseif(tempPos(1) >= 0.5)
        xVelocity = (rand * -0.002) - 0.002;
      else
        xVelocity = 0;
      endif
      fishes(i).velocity = [xVelocity,0.03 + (rand*0.005)];
      if(fishes(i).isCut)
        % set(fishes(i).frame, 'position', get(fishes(i).cutFrame, 'position'));
        fishes(i).currentFrame = fishes(i).frame;
        fishes(i).isCut = false;
      endif
      fishes(i).isDead = false;
      set(fishes(i).currentFrame, 'position', tempPos);
    endfor
  endfunction

  function moveFish(fishNum)
    if(!(fishes(fishNum).isDead))
      temp = get(fishes(fishNum).currentFrame, 'position');
      temp(1) += fishes(fishNum).velocity(1);
      temp(2) += fishes(fishNum).velocity(2);
      if(temp(2) > -0.5)
        fishes(fishNum).velocity(2) += GRAVITY;
      else
        fishes(fishNum).velocity(2) = 0;
        fishes(fishNum).isDead = true;
        if(fishNum >= 3 && !(fishes(fishNum).isCut))
          set(hearts(lives), 'FaceColor', [0.25, 0.25, 0.25]);
          lives--;
        endif
      endif

      if(isMouseDown && !(fishes(fishNum).isCut))
        mousePos = get(gcf, 'CurrentPoint');
        mousePos(1) /= get(gcf,'position')(3);
        mousePos(2) /= get(gcf, 'position')(4);
        fishPos = get(fishes(i).frame, 'position');
        minDistances = [0.085,0.065];
        if(fishNum < 3)
          minDistances = [0.06, 0.045];
        endif
        if(abs(mousePos(1) - (fishPos(1)+0.1)) < minDistances(1) && abs(mousePos(2) - (fishPos(2)+0.1)) < minDistances(2) )
          set(fishes(i).frame, 'position', [1.1 + (0.2 * fishNum),1.1,0.05,0.05]);
          set(fishes(fishNum).cutFrame, 'position', get(fishes(fishNum).frame, 'position'));
          fishes(fishNum).currentFrame = fishes(fishNum).cutFrame;
          fishes(fishNum).isCut = true;
          if(fishNum < 3)
            for i=1:lives
               set(hearts(lives), 'FaceColor', [0.25, 0.25, 0.25]);
               lives--;
            endfor
          else
            score++;
            set(scoreText, 'String', num2str(score));
          endif
        endif
      endif

      set(fishes(fishNum).currentFrame, 'position', temp);
    endif
  endfunction

  % Callback functions
  function MouseDragged(hObject, eventdata, handles)
    % Doesn't need a body just needs to be defined to update CurrentPoint
    % for some reason...
  endfunction
  function MouseClicked(hObject, eventdata, handles)
    isMouseDown = true;
  endfunction
  function MouseReleased(hObject, eventdata, handles)
    isMouseDown = false;
  endfunction

  function KeyUp(hObject, eventdata, handles)
    LastKeyStatus = KeyStatus;
    key = eventdata.Character;
    KeyStatus = (~strcmp(key, KEY_NAMES) & LastKeyStatus);
  endfunction
  function KeyDown(hObject, eventdata, handles)
    LastKeyStatus = KeyStatus;
    key = eventdata.Character;
    KeyStatus = (strcmp(key, KEY_NAMES) | LastKeyStatus);
  endfunction

  function EndLoop(hObject, eventdata, handles)
    isRunning = false;
  endfunction

endfunction

