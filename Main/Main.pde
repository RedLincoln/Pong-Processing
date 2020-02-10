import processing.sound.*;

SoundFile pong;
SoundFile intro;
SoundFile ingame;

enum State {
  mainMenu,
  modeMenu,
  gameOver,
  play,
  prolog;
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
int crazyAmount = 25;
CustomBoolean p1up = new CustomBoolean();
CustomBoolean p1down = new CustomBoolean();
CustomBoolean p2up = new CustomBoolean();
CustomBoolean p2down = new CustomBoolean();
Player player1;
Player player2;
Button restartButton;
Button gameOverToMenuButton;
Button playButton;
Button controlsButton;
Button exitButton;
Button classicButton;
Button crazyButton;
Button modeToMainMenuButton;

void setup(){
  size(1024, 600);
  setupBoard();
  setupMainMenu();
  setupModeMenu();
  setupGameOverMenu();
  textAlign(CENTER);
  rectMode(CENTER);
  ingame = new SoundFile(this, "ingame.mp3");
  ingame.amp(0.2);
  pong = new SoundFile(this, "pong.wav");
  pong.amp(0.2);
  intro = new SoundFile(this, "intro.wav");
  intro.amp(0.2);
}

void setupMainMenu(){
  playButton = initButton("Play", width / 2, height / 2 - 40, 180, 40);
  controlsButton = initButton( "Controls", width / 2, height / 2 + 20, 180, 40);
  exitButton = initButton("Exit", width / 2, height / 2 + 80, 180, 40);
}

void setupModeMenu(){
  classicButton = initButton("Classic", width / 2, height / 2 - 40, 180, 40);
  crazyButton = initButton("Crazy", width / 2, height / 2 + 20, 180, 40);
  modeToMainMenuButton = initButton("Exit", width / 2, height / 2 + 80, 180, 40);
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
 button.changeFontSize(20);
 return button;
}

void draw(){
  if (state != State.play && board.gameFinished()){
      board.startGame();
  }
  if (state != State.prolog){
    board.draw();
  }
  if (state == State.modeMenu){
    modeMenuView();
  }else if (state == State.mainMenu){
    if (!introPlay){
      introPlay = true;
      intro.play();
    }
    mainMenuView();
  }else if (board.gameFinished()){
    state = State.gameOver;
    gameOverView();
  }else if (state == State.prolog){
    prologView();
  }else if (state == State.play){
    ingame.play();
  }
}

void prologView(){
  if (!gameStart){
    gameStart = true;
    board.draw();
  }
  textSize(35);
  text("Press space to start", width / 2, height / 4);
  text(player1.getName(), width / 4, height / 2);
  text(player2.getName(), 3 * width / 4, height / 2); 
}

void modeMenuView(){
  fill(255, 255, 255);
  rect(width / 2, height / 2, 300, 300);
  fill(0, 0, 0);
  textSize(20);
  text("Select Mode", width / 2, height / 2 - 100);
  classicButton.draw();
  crazyButton.draw();
  modeToMainMenuButton.draw();
}

void mainMenuView(){
  fill(255, 255, 255);
  rect(width / 2, height / 2, 300, 300);
  fill(0, 0, 0);
  textSize(20);
  text("Pong !!!", width / 2, height / 2 - 100);
  playButton.draw();
  controlsButton.draw();
  exitButton.draw();
}

void gameOverView(){
  fill(255, 255, 255);
  rect(width / 2, height / 2, 300, 200);
  fill(0, 0, 0);
  textSize(20);
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
    controlsButton.mouseOver();
    exitButton.mouseOver();
  }else if (state == State.modeMenu){
    classicButton.mouseOver();
    crazyButton.mouseOver();
    modeToMainMenuButton.mouseOver();
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
  }
}
