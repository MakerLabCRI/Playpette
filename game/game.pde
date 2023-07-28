int X=50;
int rectH=800;
int rectY=400;
int imgX=0;
int imgY=360;
PImage imga;
PImage imgb;
color color1=color(0, 0, 255);
int speed=1;
int vertex=0;
boolean gameover = false;
boolean gamestart = false;
boolean gamewin = false;
boolean gamereset = false;
int keyPressedCount = 0;
PImage[] otherImgs;
int[] otherX;
int[] otherY;
int[] otherWidth;
int[] otherHeight;
boolean blink = true;
int blinkInterval = 50;
int score = 0;
int starttime = 0;
float gametime ;
int originalMouseY = 0;


void setup() {
  size(1200, 680);
  imageMode(CENTER);
  imga = loadImage("boat.png");
  imgb = loadImage("flag.png");
  otherImgs = new PImage[6];
  otherX = new int[otherImgs.length];
  otherY = new int[otherImgs.length];
  otherWidth = new int[otherImgs.length];
  otherHeight = new int[otherImgs.length];
  originalMouseY = mouseY;
  otherImgs[0] = loadImage("shark.png");
  otherX[0] = 200;
  otherY[0] = 550;
  otherWidth[0] = 100;
  otherHeight[0] = 80;

  otherImgs[1] = loadImage("shark.png");
  otherX[1] = 550;
  otherY[1] = 400;
  otherWidth[1] = 100;
  otherHeight[1] = 80;

  otherImgs[2] = loadImage("plane.png");
  otherX[2] = 300;
  otherY[2] = 300;
  otherWidth[2] = 100;
  otherHeight[2] = 100;

  otherImgs[3] = loadImage("plane.png");
  otherX[3] = 800;
  otherY[3] = 250;
  otherWidth[3] = 100;
  otherHeight[3] = 100;

  otherImgs[4] = loadImage("shark.png");
  otherX[4] = 900;
  otherY[4] = 500;
  otherWidth[4] = 100;
  otherHeight[4] = 80;

  otherImgs[5] = loadImage("lightning.png");
  otherX[5] = 800;
  otherY[5] = 85;
  otherWidth[5] = 30;
  otherHeight[5] = 170;
}

void draw() {
  background(51);
  fill(color1);
  rect(0, rectY, 2000, rectH);
  image(imgb, 1120, 350, 200, 200);
  image(imga, imgX, imgY, 80, 80);

  if (gamestart) {
    if (starttime==0)
      starttime = millis();
    imgX = imgX+speed;
    float currenttime = millis();
    gametime = (currenttime - starttime)/100;
    textSize(40);
    fill(255, 255, 255);
    text("Time:" + gametime, 0, 50);
    score = int(map(gametime, 0, 600, 0, 10000));
    textSize(40);
    fill(255, 255, 255);
    text("Score:" + score, 300, 50);
    if (imgX == 1100 && imgY >= 300 && imgY <= 400) {
      gamewin = true;
    }
  }


  for (int i = 0; i < otherImgs.length; i++) {
    if (!(i == 5 && blink)) {
      image(otherImgs[i], otherX[i], otherY[i], otherWidth[i], otherHeight[i]);
    }
    float distance = dist(imgX, imgY, otherX[i], otherY[i]);


    if (gamestart && ((distance < 80)||(imgX>1200 ))) {
      gameover = true;
    }
    if (gamewin) {
      PImage gameoverImg = loadImage("win.png");
      image(gameoverImg, 600, 300, 500, 500);
      gamestart= false;
      textSize(40);
      fill(255, 255, 255);
      text("Time:" + gametime, 0, 50);
      textSize(40);
      fill(255, 255, 255);
      text("Score:" + score, 300, 50);
    }

    if (gameover) {
      PImage gamewinImg = loadImage("lose.png");
      image(gamewinImg, 600, 300, 300, 200);

      gamestart =false;
      textSize(40);
      fill(255, 255, 255);
      text("Time:" + gametime, 0, 50);

      textSize(40);
      fill(255, 255, 255);
      text("Score:" + score, 300, 50);
    }
    if (frameCount % blinkInterval == 0) {
      blink = !blink;
    }
    if (gamereset) {
      imgX = 0;
      imgY = 360;
      rectH=800;
      rectY=400;
      gameover = false;
      gamewin = false;
      gamestart =false;
      starttime  = 0;
      score = 0;
    }
  }
}
void keyPressed()
{

  if (keyCode == RIGHT) {
    keyPressedCount++;
    if (keyPressedCount % 2 == 1) {
      gamestart = true;
      gamereset =  false;
    } else {
      gamereset= true ;
    }
  }
}

void mouseMoved() {
  if (gamestart) {
    imgY = mouseY;// - (originalMouseY - 600);
      rectY= imgY+35;
  } else
  {
    originalMouseY = mouseY;
  }
}
