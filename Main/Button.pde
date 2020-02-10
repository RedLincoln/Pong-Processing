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
      fill(192, 192, 192);
    else
      fill(255, 255, 255);
    
    rectMode(CENTER);
    rect(x, y, w, h);
    fill(0, 0, 0);
    textSize(fontSize);
    textAlign(CENTER);
    text(text, x, y + 5);
  }
  
  public void mouseOver(){
    if (isMouseOver()){
      over = true;    
    }else{
      over = false;
    }
  }
  
  public boolean isMouseOver(){
    return (mouseX + offset > x - w / 2 &&
        mouseX - offset < x + w / 2 &&
        mouseY + offset > y - h / 2 &&
        mouseY - offset < y + h / 2);
  }
}
