import processing.net.*;

Server server;

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
  item = new Item(160, 0, 10);

  // server starting
  server = new Server(this, 50519);

  // initializing all_map
  for (int i=0; i<mapX; i++) {
    for (int j=0; j<mapY; j++) {     
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

void draw() 
{  
  Client c = server.available();
  if (c != null) {
    println("Client IP address : "+c.ip());
    String s = c.readStringUntil('\n');
    if (s != null) {
      exec_clientserverStr(Head, s);
      println("server received: " + s); 
      //server.write(s + '\n');
    }
  }

  y = 0;  
  x = 0;
  check_anykey();

  if (t) { 
    if (tama1Alive == 0) {
      tama1X = ship2X+50;
      tama1Y = ship2Y;
      tama1Alive = 1;
    }
  }
  if (f) {
    if (tama2Alive == 0) {
      tama2X = ship2X+50;
      tama2Y = ship2Y;
      tama2Alive = 1;
    }
  }
  if (r) {
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

  if (frame%2==0) {
    background(0);
    image(ship1Img, ship1X, ship1Y, 100, 100);
    image(ship2Img, ship2X, ship2Y, 100, 100);
    image(ship3Img, ship3X, mship3Y, 100, 100);
    image(bossImg, bossX, bossY, 200, 200);
    item.update(x, y);
  }

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

String make_serverStr(CharacterData head) {
  String serverStr = "";

  for (CharacterData p=head; p!=null; p=p.next) {
    serverStr += p.ip + "," + p.x + "," + p.y + "," + p.hp + "," + p.exception + ";";
  }
  serverStr += '\n';
  return serverStr;
}

