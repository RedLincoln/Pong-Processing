Board board;
int offset = 10;

void setup(){
  size(1024, 640);
  board = new Board();
}

void draw(){
  board.draw();
}
