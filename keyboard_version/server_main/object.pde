PImage ship1Img;
PImage ship2Img;
PImage ship3Img;
PImage bossImg;

class Item {
  float ix, iy, ir;
  Item(float x, float y, float r) {
    ix = x;
    iy = y;
    ir = r;
  }
  void update(int x, int y) {
    iy += 5;
    ix += x;
    iy += y;
    fill(255, 0, 0);
    ellipse(ix, iy, ir, ir);
    if (dist(ix, iy, ship2X+50, ship2Y+50) < 60) {
      iy = 0;
      ix = random(width);
    }
    if (iy > height) {
      iy = 0;
      ix = random(width);
    }
  }
}

// リストの中身を画面に反映
void output_object(CharacterData head, PImage bossImg, PImage ship1Img, PImage ship2Img, PImage ship3Img){
  int counter=0;
  
  
}

