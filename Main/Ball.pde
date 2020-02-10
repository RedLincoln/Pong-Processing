class Ball {
  private int radius = 30;
  private int x, y;
  
  
  public Ball (int x, int y){
    this.x = x;
    this.y = y;
  }
  
  public void draw(){
    fill(255, 255, 255);
    ellipse(x, y, radius, radius);
  }
}
