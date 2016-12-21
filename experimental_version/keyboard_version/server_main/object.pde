int tama1X, tama1Y, tama2X, tama2Y,btamaX,btamaY;
int tama1Alive, tama2Alive,btamaAlive;
int ship1[]={-120, 300};
int ship2[]={270, 300};
int ship3[]={700, 300};
int boss[]={0, 500};
Item item;
Boss _boss;
Danmaku danmaku;

PImage[] ships = new PImage[4];
ArrayList<Danmaku> danmakuList; // 弾リスト(グローバル変数)
int myX=270, myY=300, myHP=100, myEXC=0;

class Danmaku {
  float x;          // X座標
  float y;          // Y座標
  float angle;      // 進行角度
  float speed;      // 移動速度
  float angleSpeed; // 角速度
  Danmaku (float x, float y, float angle, float speed, float angleSpeed) {
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.speed = speed;
    this.angleSpeed = angleSpeed;
  }
  void move() {
    angle = (angle + angleSpeed) % 360; // 進行角度が角速度で変化する
    x += cos(radians(angle)) * speed;   // 進行角度のx成分のスピード倍
    y += sin(radians(angle)) * speed;   // 進行角度のy成分のスピード倍
  }
  void draw() {
    if (dist(x, y, ship2[0]+50, ship2[1]+50) > 60) {
      ellipse(x, y, 10, 10); // XY座標を中心に幅と高さ10の円を描く
    }
  }
  boolean hit = false; // プレイヤーに当たったかを示すフラグ (まだ使わないけど)

  boolean needRemove() {
    // 画面からはみ出るか、プレイヤーに当たったら削除してよい。
    return x > width || y > height || hit;
  }
}

class Boss {
  int angle = 0;
 void circleShot() {
    for (float angle = 0; angle < 360; angle += 10) {
      Danmaku danmaku = new Danmaku(boss[0]+100, boss[1]+100, angle, 2, 0); // 弾速2
      danmakuList.add(danmaku);
    }
  }

  void move() {
   angle = (angle + 1) % 360;
   boss[0] += x;
   boss[1] += y;  
  }

  void draw() {
    image(ships[3], boss[0], boss[1], 200, 200);
    if (frameCount % 90 == 0) circleShot(); 
  }
}

boolean collision(float x1, float y1, float w1, float h1,
                  float x2, float y2, float w2, float h2) {
  if (x1 + w1/2 < x2 - w2/2) return false;
  if (x2 + w2/2 < x1 - w1/2) return false;
  if (y1 + h1/2 < y2 - h2/2) return false;
  if (y2 + h2/2 < y1 - h1/2) return false;
  return true;
}

void hit(){
  
   if(dist(btamaX, btamaY, ship2[0]+50, ship2[1]+50) < 60){
      btamaAlive = 0;
      myEXC=-1;
    }
    if (dist(tama1X, tama1Y, boss[0]+100, boss[1]+80)< 100) {
      if (tama1Alive == 1) {
        tama1Alive = 0;
      }
    }
  
   if (dist(tama2X, tama2Y, boss[0]+100, boss[1]+80)< 100) {
      if (tama2Alive == 1) {
        tama2Alive = 0;
      }
    }
}


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
  int counter=3, cnt;
  CharacterData p=head;

  /*
  image(ships[0], p.x_divergence+270, p.y_divergence+300, 100, 100);
   image(ships[3], p.x, p.y, 200, 200);*/
  for (p=head; p!=null; p=p.next) {
    cnt=counter++%4;
    if (cnt==3)
      image(ships[3], p.x_divergence+width/2, p.y_divergence+300, 300, 300);
    else
      image(ships[cnt], p.x_divergence+width/2, p.y_divergence+300, 100, 100);
  }
}