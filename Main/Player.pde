class Player {
  private int x, y;
  private int w = 20;
  private int h = 100;
  private String name;
  private int score = 0;
  
  public Player(String name, int x, int y){
    this.x = x;
    this.y = y;
  }
  
  public void draw(){
    fill(255, 255, 255);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}
