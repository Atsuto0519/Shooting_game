import processing.net.*;

Client client;
//ArrayList<SS> ss_comma;s

int player_HP=90;
int player_EXC=0;

void setup(){
  size(400, 400);
//  l = new ArrayList();
  client = new Client(this, "127.0.0.1", 50519);
  Head = new CharacterData(client.ip(),0,0,0,0);
}

void draw(){
  //dump_CharacterData(Head);

}

void mouseClicked(){
  String s;
  convert_CharacterData(Head, Server.ip(), mouseX, mouseY, 100, 0);
  dump_CharacterData(Head); 
  s = make_clientStr(Head);
  if(s != null){
    println(s);
    client.write(s + '\n');
  }
  //client.write(mouseX + " " + mouseY + '\n');
}
  
void clientEvent(Client server){
  String serverStr = client.readStringUntil('\n'); 
  if(serverStr != null){
    println("client received: " + serverStr);
    split_clientserverStr(Head, serverStr);
    dump_CharacterData(Head);
  }
}

void split_clientserverStr(CharacterData head, String someStr){
  String[] ss = splitTokens(someStr, ";");
  if(ss.length>1){
    for(int i=0; i<ss.length; i++){
      println(ss[i]);
      exec_clientserverStr(head, ss[i]);
    }
  }
}

String make_clientStr(CharacterData head){
  String clientStr;
  
  CharacterData p = searchIP_CharacterData(head, client.ip());
  
  clientStr = p.ip + "," + p.x + "," + p.y + "," + p.hp + "," + p.exception + ";" + '\n';
  
  return clientStr;
}