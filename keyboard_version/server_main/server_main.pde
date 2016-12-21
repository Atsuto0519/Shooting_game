import processing.net.*;

Server server;

// map size
int mapX=30;
int mapY=50;

int frame = 0;
int rate = 120;

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
  imageMode(CENTER);
  ships[0] = loadImage("player_1.png");
  ships[1] = loadImage("player_2.png");
  ships[2] = loadImage("player_3.png");
  ships[3] = loadImage("boss.PNG");
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
  Head = new CharacterData(Server.ip(), boss[0], boss[1], 100, 0);/*
  add_CharacterData(Head, "127.0.0.2", ship1[0], ship1[1], 100, 0);
   add_CharacterData(Head, "127.0.0.3", ship2[0], ship2[1], 98, 0);
   add_CharacterData(Head, "127.0.0.4", ship3[0], ship3[1], 98, 0);*/
  remove_CharacterData(Head, "10.0.0.0");
  dump_CharacterData(Head);

  input_object(Head, boss, ship1, ship2, ship3);
}

void draw() 
{  
  myEXC = 0;
  if (r) {
    stroke(255, 255, 255);
    strokeWeight(2);
    line(ship2[0]+50, ship2[1], ship2[0]+50, 480);
    myEXC=3;
  }   
  check_anykey();
  update_divergence(Head, server.ip());

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

  if (t) { 
    if (tama1Alive == 0) {
      tama1X = ship2[0]+50;
      tama1Y = ship2[1];
      tama1Alive = 1;
    }
  }
  if (f) {
    if (tama2Alive == 0) {
      tama2X = ship2[0]+50;
      tama2Y = ship2[1];
      tama2Alive = 1;
    }
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

  //input_object(Head, boss, ship1, ship2, ship3);
  if (frame%2==0) {
    background(0);
    output_object(Head, ships);
    item.update(x, y);
  }

  frame++;
  frame%=rate;
}

void serverEvent(Server someServer, Client someClient) {
  println("We have a new client: " + someClient.ip());
  convert_CharacterData(Head, Server.ip(), (int)random(200)+200, 300, 100, 0);
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