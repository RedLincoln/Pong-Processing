import processing.sound.*;

SoundFile pong;
SoundFile intro;
SoundFile ingame;
SoundFile finish;

PFont font;

PImage up;
PImage down;
PImage w;
PImage s;
PImage p;

enum State {
  mainMenu,
  modeMenu,
  gameOver,
  play,
  prolog,
  pause,
  options;
}

Board board;
Board viewBoard;
State state = State.mainMenu;
boolean gameStart = false;
boolean introPlay = false;
int radius = 30;
int offset = radius / 2;
int buttonOffset = 5;
int maxSpeed = 10;
int maxScore = 10;
int maxMaxScore = 15;
int minMaxScore = 5;
int crazyAmount = 25;
int maxCrazyAmount = 40;
int minCrazyAmount = 20;
float volume = 0.2;
float maxVolume = 1;
float minVolume = 0.0;
CustomBoolean p1up = new CustomBoolean();
CustomBoolean p1down = new CustomBoolean();
CustomBoolean p2up = new CustomBoolean();
CustomBoolean p2down = new CustomBoolean();
Player player1;
Player player2;
Button restartButton;
Button gameOverToMenuButton;
Button playButton;
Button optionButton;
Button exitButton;
Button classicButton;
Button crazyButton;
Button modeToMainMenuButton;
Button resumeButton;
Button pauseToMenuButton; 
Button moreSoundButton;
Button lessSoundButton;
Button moreScoreButton;
Button lessScoreButton;
Button moreBallsButton;
Button lessBallsButton;
Button optionsToMenuButton;

void setup(){
  size(1024, 600);
  setupBoard();
  setupMainMenu();
  setupModeMenu();
  setupGameOverMenu();
  setupPauseMenu();
  setupOptionsMenu();
  textAlign(CENTER);
  rectMode(CENTER);
  ingame = new SoundFile(this, "ingame.mp3");
  pong = new SoundFile(this, "pong.wav");
  intro = new SoundFile(this, "intro.wav");
  finish = new SoundFile(this, "finish.wav");
  font = createFont("bit5x3.ttf", 32);
  textFont(font);
  stroke(255, 255, 255);
  changeVolume(volume);
  loadImages();
}
 
void loadImages(){
  up = loadImage("arrow-up-icon.png");
  down = loadImage("arrow-down-icon.png");
  w = loadImage("letter-w-icon.png");
  s = loadImage("letter-s-icon.png");
  p = loadImage("letter-s-icon.png");
}


void changeVolume(float volume){
  ingame.amp(volume);
  pong.amp(volume);
  intro.amp(volume);
  finish.amp(volume);
} 
 
void setupPauseMenu(){
  resumeButton = initButton("Resume", width / 2, height / 2, 180, 40);
  pauseToMenuButton = initButton("Menu", width / 2, height / 2 + 60, 180, 40);
}

void setupOptionsMenu(){
  moreSoundButton = initButton(">", width / 2 + 85, height / 2 - 40 , 40, 40);
  lessSoundButton = initButton("<", width / 2 - 85, height / 2 - 40 , 40, 40);
  moreScoreButton = initButton(">", width / 2 + 85, height / 2 + 20 , 40, 40);
  lessScoreButton = initButton("<", width / 2 - 85, height / 2 + 20 , 40, 40);
  moreBallsButton = initButton(">", width / 2 + 85, height / 2 + 80 , 40, 40);
  lessBallsButton = initButton("<", width / 2 - 85, height / 2 + 80 , 40, 40);
  optionsToMenuButton = initButton("Menu", width / 2, height / 2 + 130, 180, 30);
  optionsToMenuButton.changeFontSize(20);
}

void setupMainMenu(){
  playButton = initButton("Play", width / 2, height / 2 - 40, 180, 40);
  optionButton = initButton( "Options", width / 2, height / 2 + 20, 180, 40);
  exitButton = initButton("Exit", width / 2, height / 2 + 80, 180, 40);
}

void setupModeMenu(){
  classicButton = initButton("Classic", width / 2, height / 2 - 40, 180, 40);
  crazyButton = initButton("Crazy", width / 2, height / 2 + 20, 180, 40);
  modeToMainMenuButton = initButton("Menu", width / 2, height / 2 + 80, 180, 40);
}

void setupGameOverMenu(){
  restartButton  = initButton("Restart", width / 2, height / 2, 180, 40);
  gameOverToMenuButton = initButton( "Menu", width / 2, height / 2 + 60, 180, 40);
}

void setupBoard(){
  board = new Board();
  board.changeBallAmount(crazyAmount);
  player1 = new Player("Player 1", (int)(width * 0.05), height / 2);
  player2 = new Player("Player 2", (int)(width * 0.95), height / 2);
  player1.addUpCommand(p1up);
  player1.addDownCommand(p1down);
  player2.addUpCommand(p2up);
  player2.addDownCommand(p2down);
  board.addPlayer(player1);
  board.addPlayer(player2);
}


Button initButton(String text, int x, int y, int w, int h){
 Button button  = new Button(text, x, y, w, h);
 button.changeFontSize(28);
 return button;
}

void draw(){
  if ((state == State.mainMenu ||
       state == State.modeMenu ||
       state == State.options) && board.gameFinished()){
      board.startGame();
  }
  if (state != State.prolog && state != State.gameOver && state != State.pause){
    board.draw();
  }
  if (state != State.play  && state != State.pause && ingame.isPlaying()){
    ingame.stop();
  }
  if (state == State.modeMenu){
    modeMenuView();
  }else if (state == State.mainMenu){
    if (!introPlay){
      introPlay = true;
      intro.play(); 
    }
    mainMenuView();
  }else if (board.gameFinished() && state == State.play){
    finish.play();
    state = State.gameOver;
  }else if (state == State.prolog){
    prologView();
  }else if (state == State.play && !ingame.isPlaying()){
    ingame.loop();    
  }else if (state == State.gameOver){
    gameOverView();
  }else if(state == State.pause){
    ingame.pause();
    pauseView();
  }else if (state == State.options){
    optionsView();
  }
  
}

void planeRect(int x, int y, int w, int h){
  fill(0, 0, 0);
  strokeWeight(8);
  rect(x, y, w, h, 7);
  strokeWeight(1);
  fill(255, 255, 255);
}

void optionsView(){
  planeRect(width / 2, height / 2, 300, 300);
  textSize(30);
  text("Options", width / 2, height / 2 - 100);
  textSize(20);
  text("Sound: " + Math.round(volume * 100) + "%", width / 2, height / 2 - 35);
  text("Score: " + maxScore, width / 2, height / 2 + 25);
  text("Balls: " + crazyAmount, width / 2, height / 2 + 85);
  moreSoundButton.draw();
  lessSoundButton.draw();
  moreScoreButton.draw();
  lessScoreButton.draw();
  moreBallsButton.draw();
  lessBallsButton.draw();
  optionsToMenuButton.draw();
}

void prologView(){
  if (!gameStart){
    gameStart = true;
    board.draw();
  }
  planeRect(width / 2, height / 2, 700, 400);
  textSize(30);
  text("Press\"Space Bar\" to start", width / 2, height / 2 - 150);
  text("Pause:", width / 2, height / 2 - 100);
  int gap = 5;
  int icc = 15;
  for (int i = width / 2 - 300; i < width / 2 + 300; i+= (icc + gap)){
    line(i, height/2 - 50, i + icc, height / 2 - 50);
  }
  text("Player 1: ", width / 2 - 250, height / 2);
  planeRect(width / 2 - 300, height / 2 + 50, 50, 50);
  planeRect(width / 2 - 300, height / 2 + 120, 50, 50);
  text("Player 2: ", width / 2 + 250, height / 2);
  planeRect(width / 2 + 275, height / 2 + 50, 50, 50);
  planeRect(width / 2 + 275, height / 2 + 120, 50, 50);
  textSize(35);
  strokeWeight(5);
  line(width / 2 + 275, height / 2 + 65, width / 2 + 275, height / 2 + 32);
  line(width / 2 + 265, height / 2 + 45, width / 2 + 275, height / 2 + 32);
  line(width / 2 + 285, height / 2 + 45, width / 2 + 275, height / 2 + 32);
  line(width / 2 + 275, height / 2 + 135, width / 2 + 275, height / 2 + 105);
  line(width / 2 + 275, height / 2 + 135, width / 2 + 265, height / 2 + 122);
  line(width / 2 + 275, height / 2 + 135, width / 2 + 285, height / 2 + 122);
  text("W", width / 2 - 297, height / 2 + 60);
  text("S", width / 2 - 297, height / 2 + 130);
}

void pauseView(){
  planeRect(width / 2, height / 2, 300, 200);
  textSize(30);
  text("Pause", width / 2, height / 2 - 60);
  resumeButton.draw();
  pauseToMenuButton.draw();
}

void modeMenuView(){
  planeRect(width / 2, height / 2, 300, 300);
  textSize(30);
  text("Select Mode", width / 2, height / 2 - 100);
  classicButton.draw();
  crazyButton.draw();
  modeToMainMenuButton.draw();
}

void mainMenuView(){
  planeRect(width / 2, height / 2, 300, 300);
  textSize(30);
  text("Pong !!!", width / 2, height / 2 - 100);
  playButton.draw();
  optionButton.draw();
  exitButton.draw();
}

void gameOverView(){
  planeRect(width / 2, height / 2, 300, 200);
  textSize(30);
  text(board.getWinner() + " Won", width / 2, height / 2 - 60);
  restartButton.draw();
  gameOverToMenuButton.draw();
}

void keyPressed(){
  if (key == 'w'){
    p1up.setState(true);
  }else if(key == 's'){
    p1down.setState(true);
  }else if(keyCode == UP){
    p2up.setState(true);
  }else if(keyCode == DOWN){
    p2down.setState(true);
  }else if(key == 'p' && state == State.play){
    state = State.pause;
  }
  if (state == State.prolog){
    if (keyCode == ' '){
      state = State.play;
      gameStart = false;
    }
  }
}

void keyReleased(){
  if (key == 'w'){
    p1up.setState(false);
  }else if(key == 's'){
    p1down.setState(false);
  }else if(keyCode == UP){
    p2up.setState(false);
  }else if(keyCode == DOWN){
    p2down.setState(false);
  }
}

void mouseMoved(){
  if (state == State.gameOver){
    restartButton.mouseOver();
    gameOverToMenuButton.mouseOver();
  }else if (state == State.mainMenu){
    playButton.mouseOver();
    optionButton.mouseOver();
    exitButton.mouseOver();
  }else if (state == State.modeMenu){
    classicButton.mouseOver();
    crazyButton.mouseOver();
    modeToMainMenuButton.mouseOver();
  }else if (state == State.pause){
    resumeButton.mouseOver();
    pauseToMenuButton.mouseOver();
  }else if (state == State.options){
    moreSoundButton.mouseOver();
    lessSoundButton.mouseOver();
    moreScoreButton.mouseOver();
    lessScoreButton.mouseOver();
    moreBallsButton.mouseOver();
    lessBallsButton.mouseOver();
    optionsToMenuButton.mouseOver();
  }
}

void mouseClicked(){
  if (state == State.gameOver){
    if (restartButton.isMouseOver()){
      state = State.play;
      board.startGame();
    }else if (gameOverToMenuButton.isMouseOver()){
      state = State.mainMenu;
    }
  }else if (state == State.mainMenu){
    if (playButton.isMouseOver()){
      state = State.modeMenu;
    }else if (optionButton.isMouseOver()){
      state = State.options;
    }else if(exitButton.isMouseOver()){
      exit();
    }   
  }else if (state == State.modeMenu){
    if (classicButton.isMouseOver()){
      state = State.prolog;
      board.changeBallAmount(1);
      board.startGame();
    }else if (crazyButton.isMouseOver()){
      state = State.prolog;
      board.changeBallAmount(crazyAmount);
      board.startGame();
    }else if (modeToMainMenuButton.isMouseOver()){
      state = State.mainMenu;
    }
  }else if (state == State.pause){
    if (resumeButton.isMouseOver()){
      state = State.play;
    }else if (pauseToMenuButton.isMouseOver()){
      state = State.mainMenu;
    }
  }else if  (state == State.options){
    if (optionsToMenuButton.isMouseOver()){
      state = State.mainMenu;
    }else if (moreSoundButton.isMouseOver()){
      volume += (volume < maxVolume) ? 0.1 : 0;
      changeVolume(volume);
    }else if (lessSoundButton.isMouseOver()){
      volume -= (volume > minVolume) ? 0.1 : 0;
      changeVolume(volume);
    }else if (moreScoreButton.isMouseOver()){
      maxScore += (maxScore < maxMaxScore) ? 1 : 0;
      board.changeMaxScore(maxScore);
    }else if (lessScoreButton.isMouseOver()){
      maxScore -= (maxScore > minMaxScore) ? 1 : 0;
      board.changeMaxScore(maxScore);
    }else if (moreBallsButton.isMouseOver()){
      crazyAmount += (crazyAmount < maxCrazyAmount) ? 1 : 0;
    }else if (lessBallsButton.isMouseOver()){
      crazyAmount -= (crazyAmount > minCrazyAmount) ? 1 : 0;
    }
  }
}
