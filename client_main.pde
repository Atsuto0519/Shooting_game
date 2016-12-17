import processing.net.*;

Client client;
//ArrayList<SS> ss_comma;s

int player_HP=90;
int player_EXC=0;

void setup(){
  size(400, 400);
//  l = new ArrayList();
  client = new Client(this, "127.0.0.1", 50519);
}

void draw(){
  //fadeToBlack();
  fill(255, 0, 0);
  //for(int i = l.size()-1; i >= 0; i--){
    //Animation a = (Animation) l.get(i);
    //a.display();
    //if(a.step()){
    //  l.remove(a);}
  //}
  dump_CharacterData(Head);
}

void mouseClicked(){
  String s = make_clientStr(Head);
  if(s != null){
    println(s);
    client.write(s + '\n');
  }
  //client.write(mouseX + " " + mouseY + '\n');
}
  
void clientEvent(Client server){
  String serverStr = server.readStringUntil('\n'); 
  if(serverStr != null){
    println("client received: " + serverStr);
    split_clientserverStr(Head, serverStr);
    dump_CharacterData(Head);
  }
}

void split_clientserverStr(CharacterData head, String someStr){
  String[] ss = splitTokens(someStr, ";");
  println(ss.length);
  for(int i=0; i<ss.length; i++){
    println(ss[i]);
    exec_clientserverStr(head, ss[i]);
  }
}

String make_clientStr(CharacterData head){
  String clientStr;
  
  CharacterData p = searchIP_CharacterData(head, client.ip());
  
  clientStr = p.ip + "," + p.x + "," + p.y + "," + p.hp + "," + p.exception + ";" + '\n';
  
  return clientStr;
}