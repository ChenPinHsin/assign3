/* please implement your assign1 code in this file. */
final int GAME_START = 0;
final int GAME_PLAYING = 1;
final int GAME_LOSE = 2;
final int ENEMY_STATE = 0;
final int ENEMY_STATE2 = 1;
final int ENEMY_STATE3 = 2;

int bgX, hpL, i, j;
float hpMax, hpNow;
int treasureX, treasureY;
int enemyX, enemyY, enemySpacing=62 ;
int gameState, enemyState;
float fighterX, fighterY;
float speed =6;
float enemySpeed =3;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

PImage fighter;
PImage enemy;
PImage treasure;
PImage bg1, bg2;
PImage hpBar;
PImage start1, start2, end1, end2;

void setup () {
  size(640, 480);
  bgX = 0;
  hpNow = 19.5;
  hpMax = 195;

  treasureX = floor(random(30, 610));
  treasureY = floor(random(30, 450));

  enemyX = 0;
  enemyY = floor(random(100, 200));

  fighterX = 550;
  fighterY = height/2-20;

  gameState = GAME_START;
  enemyState = ENEMY_STATE;

  fighter = loadImage("img/fighter.png");
  enemy = loadImage("img/enemy.png");
  treasure = loadImage("img/treasure.png");
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  hpBar = loadImage("img/hp.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
}

void draw() {

  switch(gameState) {
  case GAME_START:
    if (mouseX > width/2-120 && mouseX <width/2+120 && mouseY >height/2+150 && mouseY<height/2+180) {
      image(start1, 0, 0);
      if (mousePressed ) {
        gameState = GAME_PLAYING;
        hpL = 39;
      }
    } else {
      image(start2, 0, 0);
    }
    break;

  case GAME_PLAYING:

    //background
    background(0);
    image(bg1, bgX, 0);
    image(bg2, bgX-640, 0);
    image(bg1, bgX-1280, 0);
    bgX++;
    bgX%= 1280;

    //fighter
    image(fighter, fighterX, fighterY);
    if (upPressed) {
      if (fighterY > 0) {
        fighterY -= speed;
      }
    }
    if (downPressed) {
      if (fighterY < 430) {
        fighterY += speed;
      }
    }
    if (leftPressed) {
      if (fighterX > 0) {
        fighterX -= speed;
      }
    }
    if (rightPressed) {
      if (fighterX <590) {
        fighterX += speed;
      }
    }  

    //hpBar
    fill(255, 0, 0);
    rect(20, 20, hpL, 30, 7);
    image(hpBar, 10, 20);

    /*//eat treasure hp+10
     if (fighterX >= treasureX-30 && fighterX <= treasureX+30 && fighterY >= treasureY -30 && fighterY <= treasureY+30) {
     if (hpL < hpMax) {
     hpL += hpNow;
     treasureX = floor(random(10, 620));
     treasureY = floor(random(20, 460));
     } else if (hpL >= hpMax) {
     treasureX = floor(random(10, 620));
     treasureY = floor(random(20, 460));
     }
     }
     
     //attacked by enemy  hp-20
     if (fighterX >= enemyX -30 && fighterX <= enemyX +30 && fighterY >= enemyY -50 && fighterY <= enemyY +50) {
     hpL -= 2*hpNow;
     enemyX = -80;
     enemyY = floor(random(20, 460));
     } else if (hpL <= 0) {
     gameState = GAME_LOSE;
     hpL = 2*(int)hpNow;
     fighterX = 550;
     fighterY = height/2-20;
     }*/

    //treasure
    image(treasure, treasureX, treasureY);

    //enemy

    switch(enemyState) {
    case ENEMY_STATE:
      for (i=0; i<5; i++) {
        image(enemy, enemyX-i*enemySpacing, enemyY);
      }
      enemyX += enemySpeed;
      if (enemyX-i*enemySpacing > width ) {
        enemyX = 0;
        enemyY = floor(random(30, 100));
        enemyState = ENEMY_STATE2;
      }
      break;

    case ENEMY_STATE2:
      for (i=0; i<5; i++) {
        image(enemy, enemyX-i*enemySpacing, enemyY+i*enemySpacing);
      }
      enemyX += enemySpeed;
      if (enemyX-i*enemySpacing > width ) {
        enemyX = -300;
        enemyY = floor(random(30, 100));
        enemyState = ENEMY_STATE3;
      } 

      break;

    case ENEMY_STATE3:
      for (i=1; i<=5; i++) {
        for (j=1; j<=5; j++) {
          if (abs(j-3)+abs(i-3)==2) {
            image(enemy, enemyX+i*enemySpacing,enemyY+(j-1)*enemySpacing);
          }
        }
      }  
      enemyX += enemySpeed;
      if (enemyX-i*enemySpacing > width ) {
        enemyX = 0;
        enemyY = floor(random(100, 300));
        enemyState = ENEMY_STATE;
      }
      break;
    }


    break;

  case GAME_LOSE:
    if (mouseX > width/2-120 && mouseX <width/2+120 && mouseY >height/2+60 && mouseY<height/2+110) {
      image(end1, 0, 0);
      if (mousePressed ) {
        gameState = GAME_START;
      }
    } else {
      image(end2, 0, 0);
    }
  }
}

void keyPressed() {
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
    case UP:
      upPressed = true;
      break;
    case DOWN:
      downPressed = true;
      break;
    case LEFT:
      leftPressed = true;
      break;
    case RIGHT:
      rightPressed = true;
      break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
    case UP:
      upPressed = false;
      break;
    case DOWN:
      downPressed = false;
      break;
    case LEFT:
      leftPressed = false;
      break;
    case RIGHT:
      rightPressed = false;
      break;
    }
  }
}
