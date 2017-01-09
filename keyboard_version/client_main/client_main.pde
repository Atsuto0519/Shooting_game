import processing.net.*;

Client client;
//ArrayList<SS> ss_comma;s

int frame = 0;
int rate = 120;

int flag = 0;  
void setup() {
  //  l = new ArrayList();
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
  background_space = loadImage("background_space.jpg");
  tama1Alive = 0;
  tama2Alive = 0;
  item = new Item(160, 0, 10);
  client = new Client(this, "127.0.0.1", 50519);
  Head = new CharacterData("localhost", 0, 0, 0, 0);
  myIP = client.ip();
}

void draw() {
  if (flag == 0) {
    println();
    println(myIP);
    dump_CharacterData(Head);
    if (Head.next!=null)
      update_divergence(Head, myIP);

    myEXC=0; 
    if (r) {
      stroke(255, 255, 255);
      strokeWeight(2);
      line(width/2, ship2[1], width/2, 0);
      myEXC=3;
    }

    if (frame%6==0) {
      check_anykey();
    }

    if (frame%2==0) {
      CharacterData tmp = searchIP_CharacterData(Head, myIP);
      if (tmp != null)
        image(background_space, width/2+tmp.x/4, height/2-500/4+tmp.y/4, 1920, 1440);
      output_object(Head, ships);
      if (searchIP_CharacterData(Head, myIP) != null)
        myHP = searchIP_CharacterData(Head, myIP).hp;
      item.update(x, y);
    }

    disp_hud(Head, myIP); 

    frame++;
    frame%=rate;
  } else if (flag == 1) {
    background(0);
  }
}
/*
void mouseClicked() {
 String s;
 convert_CharacterData(Head, myIP, mouseX, mouseY, 100, 0);
 dump_CharacterData(Head); 
 s = make_clientStr(Head);
 if (s != null) {
 println(s);
 client.write(s + '\n');
 }
 //client.write(mouseX + " " + mouseY + '\n');
 }*/

void clientEvent(Client server) {
  String serverStr = client.readStringUntil('\n'); 
  if (serverStr != null) {
    println("client received: " + serverStr);
    split_clientserverStr(Head, serverStr);
    dump_CharacterData(Head);
    old_server=Head.next;
  }
}

void split_clientserverStr(CharacterData head, String someStr) {
  String[] ss = splitTokens(someStr, ";");
  if (ss.length>1) {
    for (int i=0; i<ss.length; i++) {
      println(ss[i]);
      exec_clientserverStr(head, ss[i]);
    }
  }
}

String make_clientStr(CharacterData head) {
  String clientStr;

  CharacterData p = searchIP_CharacterData(head, myIP);

  clientStr = p.ip + "," + p.x + "," + p.y + "," + p.hp + "," + p.exception + ";" + '\n';

  return clientStr;
}