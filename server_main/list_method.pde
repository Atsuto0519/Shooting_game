// list's head
public CharacterData Head;

// list of character's datas
public static class CharacterData {
  String ip;
  int x, y, hp, exception;
  int length;
  CharacterData next = null;
  
  CharacterData(String IP, int px, int py, int HP, int EXC) {
    ip = IP;
    x = px;
    y = py;
    hp = HP;    
    exception = EXC;
    length = 1;
  }
  // add list
  void add(String IP, int px, int py, int HP, int EXC) {
    next = new CharacterData(IP, px, py, HP, EXC);
    next.exception = EXC;
    next.next = null;
    length++;
  }
  //remove list
  void remove_next() {
    if(next.next != null) {
      next = next.next;
      length++;
    }
    else {
      next = null;
    }
  }
}

CharacterData searchIP_CharacterData(CharacterData head, String IP) {
  CharacterData p;
  
  //println("String = " + IP);
  for(p = head; p!=null; p=p.next) {
    //println("p.ip = " + p.ip);
    if(IP.equals(p.ip)){
      break;
    }
  }
  //println("x.ip = " + x.ip);
  
  if(p==null){
    println("null");
  }
  
  return p;
}

CharacterData prev_CharacterData(CharacterData head, CharacterData x) {
  CharacterData p;
  for(p = head; p.next!=x; p=p.next);
  
  if(x == head) p=null;
  
  return p;
}

void insert_CharacterData(CharacterData prev, String IP, int px, int py, int HP, int EXC) {
  CharacterData p = searchIP_CharacterData(prev, IP);
  if(p == null){
    CharacterData NEXT = prev.next;
    CharacterData NEW = new CharacterData(IP, px, py, HP, EXC);
    
    prev.next = null;
    prev.next = NEW;
    NEW.next = NEXT;
  }
}

boolean add_CharacterData(CharacterData head, String IP, int px, int py, int HP, int EXC) {
  boolean feedback=false;
  
  CharacterData x = searchIP_CharacterData(head, IP);
  if(x == null){
    CharacterData p;
    for(p = head; p.next!=null; p=p.next);
    p.add(IP, px, py, HP, EXC);
    feedback = true;
  }
    
  return feedback;  
}

void remove_CharacterData(CharacterData head, String IP) {
  CharacterData prev = prev_CharacterData(head, searchIP_CharacterData(head, IP));
  if(prev.next != null){
    prev.next = prev.next .next;
    prev.next.length--;
  }
  else
    prev.next = null;
}

void convert_CharacterData(CharacterData head, String IP, int px, int py, int HP, int EXC){
  CharacterData p = searchIP_CharacterData(head, IP);
  if(p != null){
    p.x = px;
    p.y = py;
    p.hp = HP;
    if(EXC!=0)
      p.exception = EXC;
  }
}

void dump_CharacterData(CharacterData head) {
  CharacterData p;
  for(p = head; p!=null; p=p.next) {
    println("ip=" + p.ip + ", x=" + p.x + ", y="+ p.y + ", hp=" + p.hp + ", exc=" + p.exception);
  }
}

void exec_clientserverStr(CharacterData head, String clientStr){
  String[] ss = splitTokens(clientStr, ",");
  String IP = ss[0];
  int px = int(ss[1]);
  int py = int(ss[2]);
  int HP = int(ss[3]);
  int EXC = int(ss[4]);
  ellipse(px, py, 20, 20);
  if(!add_CharacterData(head, IP, px, py, HP, EXC))
    convert_CharacterData(head, IP, px, py, HP, EXC);
}