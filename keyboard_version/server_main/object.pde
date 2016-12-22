int tama1X, tama1Y, tama2X, tama2Y;
int tama1Alive, tama2Alive;
int ship1[]={-120, 300};
int ship2[]={270, 300};
int ship3[]={700, 300};
int boss[]={0, 500};
Item item;

PImage[] ships = new PImage[4];
int myX=270, myY=300, myHP=100, myEXC=0;

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
      myHP-=10;
      convert_CharacterData(Head, server.ip(), searchIP_CharacterData(Head, Server.ip()).x, searchIP_CharacterData(Head, Server.ip()).y, myHP, myEXC);
      dump_CharacterData(Head);
      String s = make_serverStr(Head);
      server.write(s + '\n');
      myEXC = 0;
    }
    if (iy > height) {
      iy = 0;
      ix = random(width);
    }
  }
}

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

// リストの中身を画面に反映
void output_object(CharacterData head, PImage[] ships) {
  int char_num=calc_CharacterData(head);
  int shipsimage_num=ships.length;
  int counter=0, cnt;
  CharacterData p=head;
  
  image(ships[3], p.x_divergence+width/2, p.y_divergence+300, 300, 300);
  for (p=head.next; p!=null; p=p.next) {
    cnt=counter++%3;
    image(ships[cnt], p.x_divergence+width/2, p.y_divergence+300, 100, 100);
  }
}
