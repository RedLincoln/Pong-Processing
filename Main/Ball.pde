class Ball {
  private int x, y;
  private int vx = 2, vy = 2;
  
  public Ball (int x, int y){
    this.x = x;
    this.y = y;
  }
  
  private void update(){
    x += vx;
    y += vy;
    if (y < offset || y > height - offset){
      vy *= -1;
    }
  }
  
  public void draw(){
    fill(255, 255, 255);
    ellipse(x, y, radius, radius);
    update();
  }
  
  public void checkCollision(int x, int y, int w, int h){
     int minY = y - h / 2 - offset;
     int minX = x - w / 2 - offset;
     int rangeY = h + 2 * offset;
     int rangeX = w + 2 * offset;
       
     if (this.x > minX && this.x < (minX + rangeX) && this.y > minY && this.y < (minY + rangeY)){
       float xPos = abs(float(this.x - minX) / float(rangeX));
       float yPos = abs(float(this.y - minY) / float(rangeY));
       System.out.println(yPos);
       if (yPos < 0.1 || yPos > 0.9){
         vy *= -1;
       }
       if ((vx > 0 && xPos <= 0.5) || (vx < 0 && xPos > 0.90)){
         vx *= -1;
       }
     }
  }
}
