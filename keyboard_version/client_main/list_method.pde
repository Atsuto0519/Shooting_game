// list's head
public CharacterData Head=null;

// list of character's datas
public static class CharacterData {
  String ip;
  int x, y, hp, exception;
  int x_divergence, y_divergence;
  CharacterData next = null;

  CharacterData(String IP, int px, int py, int HP, int EXC) {
    ip = IP;
    x = px;
    y = py;
    hp = HP;    
    x_divergence=0;
    y_divergence=0;
    exception = EXC;
  }
  // add list
  void add(String IP, int px, int py, int HP, int EXC) {
    next = new CharacterData(IP, px, py, HP, EXC);
    next.next = null;
  }
  //remove list
  void remove_next() {
    if (next.next != null) {
      next = next.next;
    } else {
      next = null;
    }
  }
}

CharacterData searchIP_CharacterData(CharacterData head, String IP) {
  CharacterData p;

  //println("String = " + IP);
  for (p = head; p!=null; p=p.next) {
    //println("p.ip = " + p.ip);
    if (IP.equals(p.ip)) {
      break;
    }
  }
  //println("x.ip = " + x.ip);

  if (p==null) {
    println("null");
  }

  return p;
}

CharacterData prev_CharacterData(CharacterData head, CharacterData x) {
  CharacterData p;
  for (p = head; p.next!=x; p=p.next);

  if (x == head) p=null;

  return p;
}

void insert_CharacterData(CharacterData prev, String IP, int px, int py, int HP, int EXC) {
  CharacterData p = searchIP_CharacterData(prev, IP);
  if (p == null) {
    CharacterData NEXT = prev.next;
    CharacterData NEW = new CharacterData(IP, px, py, HP, EXC);

    prev.next = null;
    prev.next = NEW;
    NEW.next = NEXT;
  }
}

void add_CharacterData(CharacterData head, String IP, int px, int py, int HP, int EXC) { 
  CharacterData x = searchIP_CharacterData(head, IP);

  if (x == null) {
    CharacterData p;
    for (p = head; p.next!=null; p=p.next);
    p.add(IP, px, py, HP, EXC);
  }
}

void remove_CharacterData(CharacterData head, String IP) {
  CharacterData prev = prev_CharacterData(head, searchIP_CharacterData(head, IP));
  if (prev.next != null) {
    prev.next = prev.next .next;
  } else
    prev.next = null;
}

void convert_CharacterData(CharacterData head, String IP, int px, int py, int HP, int EXC) {
  CharacterData p = searchIP_CharacterData(head, IP);
  if (p != null) {
    p.x = px;
    p.y = py;
    p.hp = HP;
    if (EXC!=0)
      p.exception = EXC;
  }
}

void dump_CharacterData(CharacterData head) {
  CharacterData p;
  for (p = head; p!=null; p=p.next) {
    println("ip=" + p.ip + ", x=" + p.x + ", y="+ p.y + ", hp=" + p.hp + ", exc=" + p.exception);
    println("divergence=(" + p.x_divergence + ", " + p.y_divergence + ")");
  }
}

void exec_clientserverStr(CharacterData head, String clientStr) {
  String[] ss = splitTokens(clientStr, ",");
  if (ss.length>4) {
    String IP = ss[0];
    int px = int(ss[1]);
    int py = int(ss[2]);
    int HP = int(ss[3]);
    int EXC = int(ss[4]);
    add_CharacterData(Head, IP, px, py, HP, EXC);
    convert_CharacterData(Head, IP, px, py, HP, EXC);
  }
}

int calc_CharacterData(CharacterData head) {
  int feedback=-1;

  for (CharacterData p=head.next; p!=null; p=p.next) {
    if (feedback<1)
      feedback=0;

    feedback++;
  }

  return feedback;
}

void update_divergence(CharacterData head, String IP){
  CharacterData myData=searchIP_CharacterData(head, IP);
  
  for(CharacterData p=head.next; p!=null; p=p.next){
    p.x_divergence = myData.x-p.x;
    p.y_divergence = myData.y-p.y;
  }
}