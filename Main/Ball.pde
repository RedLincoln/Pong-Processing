import java.util.Random;

class Ball {
  private int x, y;
  private int[] direction = { -1, 1};
  private Random random = new Random();
  private int vx, vy;
  private boolean dead = false;
  
  
  public Ball (int x, int y){
    this.x = x;
    this.y = y;
    initSpeed();
  }
  
  private void initSpeed(){
    vx = 2 * direction[random.nextInt(2)];
    vy = 2 * direction[random.nextInt(2)];
  }
  
  private void update(){
    x += vx;
    y += vy;
    if (x < 0 || x > width){
      dead = true;
    }else if (y < offset || y > height - offset){
      vy *= -1;
    }
  }
  
  public boolean isDead(){
    return dead;
  }
  
  public void draw(){
    fill(255, 255, 255);
    ellipse(x, y, radius, radius);
    update();
  }
  
  public void checkCollision(int x, int y, int w, int h){
     int minY = y - h / 2 - offset;
     int minX = x - w / 2 - offset + vx;
     int rangeY = h + 2 * offset;
     int rangeX = w + 2 * offset + abs(vx);
       
     if (this.x > minX && this.x < (minX + rangeX) && this.y > minY && this.y < (minY + rangeY)){
       float xPos = abs(float(this.x - minX) / float(rangeX));
       float yPos = abs(float(this.y - minY) / float(rangeY));
       if ((vy > 0 && yPos < 0.1) || (vy < 0 && yPos > 0.9)){
         vy *= -1;
       }
       if ((vx > 0 && xPos <= 0.5) || (vx < 0 && xPos > 0.90)){
         vx *= -1;
         if (abs(vx) < maxSpeed)
           vx += (vx > 0) ? 1 : -1;
       }
       pong.play();
     }
     
  }
  
  public int getX(){
    return x;
  }
}
