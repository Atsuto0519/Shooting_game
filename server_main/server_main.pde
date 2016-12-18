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
  //disp size
  size(400, 400);
  
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

void draw() 
{
  Client c = server.available();
  if (c != null) {
    println("Client IP address : "+c.ip());
    String s = c.readStringUntil('\n');
    if(s != null){
      exec_clientserverStr(Head, c.ip() + "," + s);
      println(s);
      println("server received: " + s); 
      //server.write(s + '\n');
    }
  } else {  
  }
}

void mouseClicked(){
  String s;
  convert_CharacterData(Head, Server.ip(), mouseX, mouseY, 100, 0);
  dump_CharacterData(Head); 
  s = make_serverStr(Head);
  println(s);
  server.write(s+'\n');    
}

void serverEvent(Server someServer, Client someClient) {
  println("We have a new client: " + someClient.ip());
  add_CharacterData(Head, someClient.ip(), (int)random(400), (int)random(400), 100, 0);  
  dump_CharacterData(Head);
  String serverStr = make_serverStr(Head);
  println(serverStr);
  //server.write(serverStr);
}

String make_serverStr(CharacterData head){
  String serverStr = "";
  
  for(CharacterData p=head; p!=null; p=p.next){
    serverStr += p.ip + "," + p.x + "," + p.y + "," + p.hp + "," + p.exception + ";";
  }
  serverStr += '\n';
  return serverStr;
}