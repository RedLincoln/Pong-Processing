import java.util.List;
import java.util.ArrayList;
import java.util.Random;

class Board {
  private List<Player> players = new ArrayList(); 
  private List<Ball> balls = new ArrayList();
  private int ballAmount = 1;
  private int maxScore = 10;
  private Random random = new Random();
  
  public void addPlayer(Player player){
    players.add(player);
  }
  
  private void changeBallAmount(int ballAmount){
    this.ballAmount = ballAmount; 
  }
  
  private void changeMaxScore(int maxScore){
    this.maxScore = maxScore;
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
  
  private void checkPlayerCollision(Ball ball){
    for (Player player: players){
      ball.checkCollision(player.getX(), player.getY(), player.getW(), player.getH());
    }
  }
  
  private void checkBall(Ball ball){
    if (ball.isDead()){
      Player farest = players.get(0);
      int distance = abs(players.get(0).getX() - ball.getX()); 
      for(int i = 1; i < players.size(); i++){
        if(distance < abs(players.get(i).getX() - ball.getX())){
          farest = players.get(i);
          distance = abs(players.get(i).getX() - ball.getX());
        }
      }
      farest.incrementScore();
      balls.remove(ball);
    }
  }
   
  private void printScore(){
    textSize(30);
    for (Player player: players){
      if (player.getX() < width / 2){
        text(player.getScore(), width / 4, 40);
      }else {
        text(player.getScore(), (width / 4) * 3, 40);
      }
    }   
  }
  
  private void drawBall(Ball ball){
    ball.draw();
  }
  
  public boolean gameFinished(){
    for(Player player: players){
      if (player.getScore() >= maxScore)
        return true;
    }
    return false;
  }
  
  public String getWinner(){
    String winner = "No one";
    for (Player player: players){
      if (player.getScore() >= maxScore){
        winner = player.getName();
        break;
      }
    }
    return winner;
  }
  
  public void startGame(){
    for (Player player: players){
      player.restartScore();
    }
    initBalls();
  }
  
  private void initBalls(){
    balls.clear();
    int minX = (int)(width / 2 - width * 0.2);
    int rangeX = (int)(width * 0.4);
    int minY = (int)(height / 4);
    int rangeY = (int)(height / 2);
    for (int i = 0; i < ballAmount; i++){
        int x  = minX + (int)(random.nextFloat() * rangeX);
        int y  = minY + (int)(random.nextFloat() * rangeY);
        balls.add(new Ball(x, y));
      }
  }
  
  public void draw(){
    if (balls.size() == 0){    
      initBalls();
    }
    background(0, 0, 0);
    drawMiddle();
    drawPlayers();
    for (int i = 0; i < balls.size(); i++){
      Ball ball = balls.get(i);
      drawBall(ball);
      checkBall(ball);
      checkPlayerCollision(ball);
    }
    printScore();  
  }
}
