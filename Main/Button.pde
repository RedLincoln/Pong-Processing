class Button {
  int x, y, w, h, fontSize = 12;
  String text;
  boolean over = false;
  
  public Button(String text, int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
  }
  
  public void changeFontSize(int fontSize){
    this.fontSize = fontSize;
  }
  
  public void draw(){
    if (over)
      fill(50, 50, 50);
    else
      fill(0, 0, 0);
    
    rectMode(CENTER);
    strokeWeight(5);
    rect(x, y, w, h, 7);
    fill(255, 255, 255);
    textSize(fontSize);
    textAlign(CENTER);
    text(text, x, y + 10);
    strokeWeight(1);
  }
  
  public void mouseOver(){
    if (isMouseOver()){
      over = true;    
    }else{
      over = false;
    }
  }
  
  public boolean isMouseOver(){
    return (mouseX + buttonOffset > x - w / 2 &&
        mouseX - buttonOffset < x + w / 2 &&
        mouseY + buttonOffset > y - h / 2 &&
        mouseY - buttonOffset < y + h / 2);
  }
}
