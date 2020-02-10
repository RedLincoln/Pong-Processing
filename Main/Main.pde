import java.util.Random;

Board board;
int radius = 30;
int offset = radius / 2;
int maxSpeed = 10;
int maxScore = 10;
CustomBoolean p1up = new CustomBoolean();
CustomBoolean p1down = new CustomBoolean();
CustomBoolean p2up = new CustomBoolean();
CustomBoolean p2down = new CustomBoolean();
Player player1;
Player player2;


void setup(){
  size(1024, 600);
  board = new Board();
  player1 = new Player("Player 1", (int)(width * 0.05), height / 2);
  player2 = new Player("Player 2", (int)(width * 0.95), height / 2);
  player1.addUpCommand(p1up);
  player1.addDownCommand(p1down);
  player2.addUpCommand(p2up);
  player2.addDownCommand(p2down);
  board.addPlayer(player1);
  board.addPlayer(player2);
  textAlign(CENTER);
}

void draw(){
  if (board.gameFinished()){
    board.draw();
  }else {
    rectMode(CENTER);
    fill(255, 255, 255);
    rect(width / 2, height / 2, 300, 200);
    fill(0, 0, 0);
    textSize(20);
    text(board.getWinner(), width / 2, height / 2 - 60);
    Button button  = new Button("Restart", width / 2, height / 2, 180, 40);
    button.changeFontSize(20);
    button.draw();
    Button button2  = new Button("Menu", width / 2, height / 2 + 60, 180, 40);
    button2.changeFontSize(20);
    button2.draw();
  }
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
