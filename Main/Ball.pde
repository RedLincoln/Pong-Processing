class Ball {
  private int radius = 30;
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
}
