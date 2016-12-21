boolean w, a, s, d, t, r, f;

int x = 0;
int y = 0;
int XMAX = 1000;
int YMAX = 1000;
int Xtotal = 150;
int Ytotal = 150;

void check_anykey() {
  //押されているキーに応じて、円の中心点を更新
  if (Ytotal <= YMAX) {
    if (w) {
      y += 1;
      Ytotal +=1;
    }
  }
  if (Ytotal >= 0) {
    if (s) {
      y -= 1;
      Ytotal -=1;
    }
  }
  if (Xtotal <= XMAX) {
    if (a) {
      x += 1;
      Xtotal +=1;
    }
  }
  if (Xtotal >= 0) {
    if (d) {
      x -= 1;
      Xtotal -=1;
    }
  }
  
  ship1[0] += x;
  ship1[1] += y;
  ship3[0] += x;
  ship3[1] += y;
  boss[0] += x;
  boss[1] += y;

  if (w||s||a||d) {
    String s;
    convert_CharacterData(Head, client.ip(), searchIP_CharacterData(Head, client.ip()).x+x, searchIP_CharacterData(Head, client.ip()).y+y, myHP, myEXC);
    dump_CharacterData(Head); 
    s = make_clientStr(Head);
    println(s);
    client.write(s+'\n');
  }
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