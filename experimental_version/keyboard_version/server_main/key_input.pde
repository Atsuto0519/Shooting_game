boolean w, a, s, d, t, r, f;

int x = 0;
int y = 0;
int XMAX = 1000;
int YMAX = 1000;
int Xtotal = 150;
int Ytotal = 150;

void check_anykey() {
  y = 0;  
  x = 0;
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
  if (r) {
    stroke(255, 255, 255);
    strokeWeight(2);
    line(width/2, ship2[1], width/2, 480);
  }

  if (tama1Alive == 1) {
    tama1X += x;
    tama1Y += y;
    fill(230, 220, 255);
    ellipse(tama1X, tama1Y, 10, 10);  
    tama1Y = tama1Y + 1;
  }
  if (tama1Y > 480) {
    tama1Alive = 0;
  }
  if (tama2Alive == 1) {
    tama2X += x/2;
    tama2Y += y;
    fill(230, 220, 255);
    ellipse(tama2X, tama2Y, 10, 10);  
    tama2Y = tama2Y + 5;
  }
  if (tama2Y > 480) {
    tama2Alive = 0;
  }
  if (frameCount % 10 == 0) {
      if (btamaAlive == 0) {
        btamaX = boss[0]+100;
        btamaY = boss[1]+100;
        btamaAlive = 1;
      }
    }
  if (btamaAlive == 1) {
    btamaX += x;
    btamaY += y;
    fill(255, 255, 255);
    ellipse(btamaX, btamaY, 10, 10);  
    btamaY = btamaY + 10;
  }

  if (w||s||a||d) {
    String s;
    convert_CharacterData(Head, Server.ip(), searchIP_CharacterData(Head, Server.ip()).x+x, searchIP_CharacterData(Head, Server.ip()).y+y, myHP, myEXC);
    dump_CharacterData(Head); 
    s = make_serverStr(Head);
    println(s);
    server.write(s+'\n');
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