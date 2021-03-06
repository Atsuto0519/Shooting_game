import processing.net.*;

Client client;
//ArrayList<SS> ss_comma;s

void setup() {
  //  l = new ArrayList();
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
  client = new Client(this, "127.0.0.1", 50519);
  Head = new CharacterData(client.ip(), 0, 0, 0, 0);
}

void draw() {
  //dump_CharacterData(Head);
  y = 0;  
  x = 0;
  check_anykey();
  update_divergence(Head, client.ip());
  background(0);
  item.update(x, y);
  output_object(Head, ships);
}
/*
void mouseClicked() {
  String s;
  convert_CharacterData(Head, client.ip(), mouseX, mouseY, 100, 0);
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

  CharacterData p = searchIP_CharacterData(head, client.ip());

  clientStr = p.ip + "," + p.x + "," + p.y + "," + p.hp + "," + p.exception + ";" + '\n';

  return clientStr;
}