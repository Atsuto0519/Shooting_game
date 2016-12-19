import processing.net.*;

Server server;

PImage ship1Img;
PImage ship2Img;
PImage ship3Img;
PImage bossImg;
boolean w, a, s, d, t, r, f;
int tama1X, tama1Y, tama2X, tama2Y;
int tama1Alive, tama2Alive;
int ship1X = -120;
int ship1Y = 300;
int ship2X = 270;
int ship2Y = 300;
int ship3X = 700;
int ship3Y = 300;
int bossX = 230;
int bossY = -200;
int x = 0;
int y = 0;
int Xtotal = 150;
int Ytotal = 150;
int XMAX = 300;
int YMAX = 300;
int frame = 0;
int rate = 120;
Item item;

// map size
int mapX=30;
int mapY=50;

// all map's data array
int[][] all_map = new int[mapX][mapY];
//byte[] byteBuffer = new byte[10];

// data size
int dataSIZE = 5;
// to send data for clients
int[] send_data = new int[dataSIZE];


class Item {
  float ix, iy, ir;
  Item(float x, float y, float r) {
    ix = x;
    iy = y;
    ir = r;
  }
   void update(int x,int y) {
    iy += 5;
    ix += x;
    iy += y;
    fill(255, 0, 0);
    ellipse(ix, iy, ir, ir);
    if(dist(ix, iy, ship2X+50, ship2Y+50) < 60){
      iy = 0;
      ix = random(width);
    }
    if (iy > height) {
      iy = 0;
      ix = random(width);
    }
    
  }
}

void setup() 
{
  frameRate(rate);
  size(640, 480);
  background(0);
  noStroke();
  smooth();
  ship1Img = loadImage("player_1.png");
  ship2Img = loadImage("player_2.png");
  ship3Img = loadImage("player_3.png");
  bossImg = loadImage("boss.PNG");
  tama1Alive = 0;
  tama2Alive = 0;
  item = new Item(160, 0 ,10);
  
  // server starting
  server = new Server(this, 50519);
  
  // initializing all_map
  for(int i=0; i<mapX; i++) {
    for(int j=0; j<mapY; j++) {     
      all_map[i][j] = 0;      
    }
  }
  
  // initializing list
  Head = new CharacterData(Server.ip(), 0, 0, 100, 0);
  add_CharacterData(Head, "127.0.0.2", 1, 1, 99, 0);
  add_CharacterData(Head, "127.0.0.3", 2, 1, 98, 0);
  add_CharacterData(Head, "127.0.0.4", 3, 1, 97, 0);
  remove_CharacterData(Head, "10.0.0.0");
  dump_CharacterData(Head);
}

void check_anykey(){
    //押されているキーに応じて、円の中心点を更新
  if(Ytotal <= YMAX){
    if(w) {
     y += 1;
     Ytotal +=1;
    }
  }
  if(Ytotal >= 0){
    if(s) {
      y -= 1;
      Ytotal -=1;
    }
  }
  if(Xtotal <= XMAX){
    if(a) {
      x += 1;
      Xtotal +=1;
    }
  }
  if(Xtotal >= 0){
    if(d) {
      x -= 1;
      Xtotal -=1;
    }
  }
  
  if(w||s||a||d){
    String s;
    convert_CharacterData(Head, Server.ip(), ship1X, ship1Y, 100, 0);
    dump_CharacterData(Head); 
    s = make_serverStr(Head);
    println(s);
    server.write(s+'\n');    
  }
}

void draw() 
{
  Client c = server.available();
  if (c != null) {
    println("Client IP address : "+c.ip());
    String s = c.readStringUntil('\n');
    if(s != null){
      exec_clientserverStr(Head, s);
      println("server received: " + s); 
      //server.write(s + '\n');
    }
  }
  background(0);
 
  y = 0;
  x = 0;
  
  check_anykey();
  
  if(t){ 
    if(tama1Alive == 0) {
      tama1X = ship2X+50;
      tama1Y = ship2Y;
      tama1Alive = 1;
    }
  }
  if(f){
    if(tama2Alive == 0){
      tama2X = ship2X+50;
      tama2Y = ship2Y;
      tama2Alive = 1;
    }
  }
  if(r){
    stroke(255, 255, 255);
    strokeWeight(2);
    line(ship2X+50, ship2Y, ship2X+50, 0); 
  }
  
  if (tama1Alive == 1) {
    tama1X += x;
    tama1Y += y;
    fill(230, 220, 255);
    ellipse(tama1X, tama1Y, 10, 10);  
    tama1Y = tama1Y - 1;
  }
  if (tama1Y < 0) {
    tama1Alive = 0;
  }
  if (tama2Alive == 1) {
    tama2X += x;
    tama2Y += y;
    fill(230, 220, 255);
    ellipse(tama2X, tama2Y, 10, 10);  
    tama2Y = tama2Y - 5;
  }
  if (tama2Y < 0) {
    tama2Alive = 0;
  }
  ship1X += x;
  ship1Y += y;
  ship3X += x;
  ship3Y += y;
  bossX += x;
  bossY += y;
  image(ship1Img, ship1X, ship1Y, 100, 100);
  image(ship2Img, ship2X, ship2Y, 100, 100);
  image(ship3Img, ship3X, ship3Y, 100, 100);
  image(bossImg, bossX, bossY, 200, 200);
  item.update(x,y);
  
  frame++;
  frame%=rate;
}

void serverEvent(Server someServer, Client someClient) {
  println("We have a new client: " + someClient.ip());
  convert_CharacterData(Head, Server.ip(), mouseX, mouseY, 100, 0);
  dump_CharacterData(Head); 
  add_CharacterData(Head, someClient.ip(), (int)random(400), (int)random(400), 100, 0);  
  String serverStr = make_serverStr(Head);
  println(serverStr);
  server.write(serverStr);
}

String make_serverStr(CharacterData head){
  String serverStr = "";
  
  for(CharacterData p=head; p!=null; p=p.next){
    serverStr += p.ip + "," + p.x + "," + p.y + "," + p.hp + "," + p.exception + ";";
  }
  serverStr += '\n';
  return serverStr;
}

void keyPressed() {
  //使用するキーが押されたら、対応する変数をtrueに
  switch(key) {
    case 'w':
      w = true;
      break;
    case 'a':
      a = true;
      break;
    case 's':
      s = true;
      break;
    case 'd':
      d = true;
      break;
    case 't':
      t = true;
      break;
    case 'r':
      r = true;
      break;
    case 'f':
      f = true;
      break;
  }
}

void keyReleased() {
  //使用するキーが離されたら、対応する変数をfalseに
  switch(key) {
    case 'w':
      w = false;
      break;
    case 'a':
      a = false;
      break;
    case 's':
      s = false;
      break;
    case 'd':
      d = false;
      break;
    case 't':
      t = false;
     break;
    case 'r':
      r = false;
     break; 
    case 'f':
      f = false;
     break; 
  }
}