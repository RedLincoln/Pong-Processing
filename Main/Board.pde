import java.util.List;
import java.util.ArrayList;



class Board {
  private List<Player> players = new ArrayList(); 
  private Ball ball;
  
  
  public Board(){
    System.out.println(width);
    players.add(new Player("Player 1", (int)(width * 0.05), height / 2));
    players.add(new Player("Player 2", (int)(width * 0.95), height / 2));
    ball = new Ball(width / 2, height / 2);
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
