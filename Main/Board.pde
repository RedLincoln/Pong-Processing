public void settings(){  
  size(1024, 640);
}


class Board {
  
  public Board(){
       
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
    
  public void draw(){
    background(0, 0, 0);
    drawMiddle();
  }
}
