int tama1X, tama1Y, tama2X, tama2Y;
int tama1Alive, tama2Alive;
int ship1[]={-120, 300};
int ship2[]={270, 300};
int ship3[]={700, 300};
int boss[]={230, -200};
//Item item;

PImage[] ships = new PImage[4];
int myX=270, myY=300, myHP=100, myEXC=0;
/*
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
    if (dist(ix, iy, ship2[0]+50, ship2[1]+50) < 60) {
      iy = 0;
      ix = random(width);
      ;
    }
    if (iy > height) {
      iy = 0;
      ix = random(width);
      myHP-=10;
    }
  }
}*/
/*
void input_object(CharacterData head, int boss[], int ship1[], int ship2[], int ship3[]) {
  // character ga sannninn ijo no toki
  int char_num=calc_CharacterData(head);
  if (calc_CharacterData(head)>3) {
    head.x=boss[0]; 
    head.y=boss[1];  
    head.next.x=ship1[0]; 
    head.next.y=ship1[1];
    head.next.next.x=ship2[0]; 
    head.next.next.y=ship2[1];
    head.next.next.next.x=ship3[0];
    head.next.next.next.y=ship3[1];
  }
}
*/
// リストの中身を画面に反映
void output_object(CharacterData head, PImage[] ships) {
  int char_num=calc_CharacterData(head);
  int shipsimage_num=ships.length;
  int counter=3;
  CharacterData p=head;

  image(ships[3], myX+p.x_divergence, myY+p.y_divergence, 200, 200);
  for (p=head.next; p!=null; p=p.next) {
    image(ships[counter++%3], Xtotal, Ytotal, 100, 100);
  }
}