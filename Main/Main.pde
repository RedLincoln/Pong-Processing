Board board;
int radius = 30;
int offset = radius / 2;

void setup(){
  size(1024, 600);
  board = new Board();
}

void draw(){
  board.draw();
}
