class Player {
  private int x, y;
  private int w = 20;
  private int h = 100;
  private String name;
  private int score = 0;
  private int vy = 15;
  private CustomBoolean upCommand;
  private CustomBoolean downCommand;
  
  public Player(String name, int x, int y){
    this.x = x;
    this.y = y;
    this.name = name;
  }
  
  public void draw(){
    fill(255, 255, 255);
    rectMode(CENTER);
    rect(x, y, w, h);
    updateMovement();
  }
  
  private void updateMovement(){
    if (upCommand != null && upCommand.getState()){
      y = (y - h / 2 >= vy) ? y - vy : 0 + h / 2;
    }
    if (downCommand != null && downCommand.getState()){
      y = (y + h / 2<= height - vy) ? y + vy : height - h / 2;
    }
  }
  
  public void addUpCommand(CustomBoolean upCommand){
    this.upCommand = upCommand;
  }
  
  public void addDownCommand(CustomBoolean downCommand){
    this.downCommand = downCommand;
  }
  
  public void incrementScore(){
    score++;
  }
  
  public int getScore(){
    return score;
  }
  
  public int getX(){
    return x;
  }
  
  public int getY(){
    return y;
  }
  
  public int getW(){
    return w;
  }
  
  public int getH(){
    return h;  
  }
  
  public String getName(){
    return name;
  }
}
