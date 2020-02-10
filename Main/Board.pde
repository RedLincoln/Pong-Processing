import java.util.List;
import java.util.ArrayList;



class Board {
  private List<Player> players = new ArrayList(); 
  private Ball ball;
  
  
  public Board(){    
    ball = new Ball(width / 2, height / 2);
  }
  
  public void addPlayer(Player player){
    players.add(player);
  }
  
  private void drawMiddle(){
    int reach = 0;
    int w = 5;
    int h = 50;
    int gap = 15;
    fill(192, 192, 192);
    while(reach < height){
      rect(width / 2, reach, w, h);
      reach += (h + gap);
    }
  }
  
  private void drawPlayers(){
    for(Player player: players){
      player.draw();
    }
  }
  
  private void checkPlayerCollision(){
    for (Player player: players){
      ball.checkCollision(player.getX(), player.getY(), player.getW(), player.getH());
    }
  }
  
  private void drawBalls(){
    ball.draw();
  }
  
  public void draw(){
    background(0, 0, 0);
    drawMiddle();
    drawPlayers();
    drawBalls();
  }
}
