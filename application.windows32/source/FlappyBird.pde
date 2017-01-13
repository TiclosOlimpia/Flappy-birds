int rad = 20; // raza cercului
int scor=0;        
float pozX, pozY;    // pozitia initiala a cercului  
boolean aInceputJoc=false, aripa=false;
int framestart=0;  
PFont f;
float vitezaY = 8.5;  // viteza initiala pe y
int directieY = 1;  // 1 coborare; -1 urcare
int startFrUrcare=0; 
int timp;
int durataFrUrcare=15;
Obstacol o1, o2, o3;

void gameOver() {
  int timp=(int)((frameCount-framestart)/frameRate);
  aInceputJoc=false;
  directieY=1;
  while (pozY<height-rad-4) {
    pozY = pozY + ( 0.0001 * directieY );
  }
  noLoop();

  rectMode(CENTER); 
  fill(150, 34, 34);
  rect(width/2, height/2, 300, 200);
  f = createFont("Georgia", 36);
  textFont(f); 
  textAlign(CENTER);

  JSONObject scorMax;

  scorMax = loadJSONObject("data/scor.json");//citire din fisier

  int scorRecord = scorMax.getInt("scor");
  int timpRecord = scorMax.getInt("timp");
  if (scor>scorRecord) {
    scorMax = new JSONObject();
    scorMax.setInt("scor", scor);
    scorMax.setInt("timp", timp);
    saveJSONObject(scorMax, "data/scor.json");//scriere in fisier
  }
  scrie(scor, timp, scorRecord, timpRecord);
}

void setup() {
  
  scor=0;
  size(558, 686);
  o1 = new Obstacol(width, height/2);
  o2 = new Obstacol(width + 93 * 3, height/2);
  o3 = new Obstacol(width + 93 * 6, height/2);
  noStroke();
  frameRate(30);
  ellipseMode(RADIUS);
  // setez pozitie cerc
  pozX = width/6;         
  pozY = height/2;
  loop();
}

void draw() {
  
  PImage img;
  PFont f;
  img = loadImage("background1.png");
  background(img);
  if (aInceputJoc==true) {

    o1.move();
    o1.display();

    o2.move();
    o2.display();

    o3.move();
    o3.display();
    f = createFont("Georgia", 48);
    textFont(f);
    textAlign(CENTER);
    drawType(width * 0.5, scor);

    if (      
      o1.coliziune(pozX, pozY, rad) ||
      o2.coliziune(pozX, pozY, rad) ||
      o3.coliziune(pozX, pozY, rad)
      ) {    
      gameOver();
    } else

      if (  o1.trecereObstacol(pozX) ||
        o2.trecereObstacol(pozX) ||
        o3.trecereObstacol(pozX)
        ) {
        scor++;
      }

//frameCount este frame-ul curent
    if (frameCount>=startFrUrcare+durataFrUrcare) {
      directieY=1;
    }
    if (directieY==-1) {
      vitezaY=vitezaY-0.5 ;
    }
    if (directieY==1) {
      if (vitezaY<9.5) {
        vitezaY=vitezaY+1;
      }
    }

    pozY = pozY + ( vitezaY * directieY );

    // test margine jos->GameOver
    if (pozY > height-rad) {
      gameOver();
    }

    // test margine sus->cadere
    if (pozY<rad) {
      directieY=1;
    }
  } 
  //daca jocul nu a inceput inca
  else
  {
    scriestart();
    vitezaY=2;
    pozY = pozY + ( vitezaY * directieY );
    vitezaY--;
    if (frameCount%5==0)
    {
      vitezaY=2;
      directieY=-directieY;
    }
  }
  deseneazaPasare();
}
void drawType(float x, int a) {
  fill (255);
  text(a, x, height/4);
}
void scriestart() {
  fill (50, 80, 20, 255);
  f = createFont("Georgia", 24);
  textFont(f); 
  text("PRESS SPACE TO", width/4, height/2-80);
  text("START THE GAME", width/4, height/2-50);
}
void scrie(int scor, int timp, int scorRecord, int timpRecord) {
  fill (235, 140, 0, 255);
  f = createFont("Georgia", 48);
  textFont(f); 
  text("GAME OVER", width/2, height/2-110);
  fill (255);
  f = createFont("Times new Roman", 30);
  textFont(f); 
  text("SCOR:", width/2-100, height/2-60);
  text(scor, width/2, height/2-60);
  text("TIMP:", width/2-105, height/2-10);
  text(timp, width/2, height/2-10);
  text("sec", width/2+90, height/2-10);
  text("SCOR RECORD:", width/2-35, height/2+40);
  text(scorRecord, width/2+100, height/2+40);
  text("TIMP RECORD:", width/2-40, height/2+80);
  text(timpRecord, width/2+100, height/2+80);
}
void keyPressed() {
  aInceputJoc=true;
  directieY=-1;
  startFrUrcare=frameCount;
  vitezaY=7.5;
}
void deseneazaPasare() {

  stroke(0, 0, 0);
  strokeWeight(1.8);
  fill(245, 50, 20);
  ellipse(pozX, pozY, rad, rad);

  fill(255, 255, 255);
  ellipse(pozX+rad/5, pozY-rad/2, rad/3, rad/4);
  fill(0, 0, 0);
  ellipse(pozX+rad/5+2, pozY-rad/2-1, rad/6, rad/9);

  fill(255, 255, 255);
  ellipse(pozX+rad/2+2, pozY-3*rad/4, rad/4, rad/5);
  fill(0, 0, 0);
  ellipse(pozX+rad/2+4, pozY-3*rad/4-1, rad/10, rad/10);

  fill(245, 50, 20);
  quad(pozX-rad, pozY-rad/5, pozX-rad, pozY+rad/5, pozX-4*rad/3, pozY+rad/3, pozX-4*rad/3, pozY-rad/3 );

  fill(450, 220, 100);
  triangle(pozX+3*rad/4, pozY+2, pozX+rad-2, pozY-rad/4, pozX+5*rad/4+1, pozY+2);

  fill(250, 820, 100);
  quad(pozX+3*rad/4, pozY+2, pozX+5*rad/4-3, pozY+2, pozX+5*rad/4, pozY+rad/4, pozX+rad-2, pozY+rad/4+2 );
  if (aripa)
  {
    fill(200);
    quad(pozX-3*rad/4, pozY, pozX-rad/2, pozY+rad/4, pozX, pozY+rad/7, pozX-rad/3-2, pozY-rad/6 );
  } else
  {
    fill(200);
    quad(pozX-3*rad/4, pozY+rad/4, pozX-rad/3-2, pozY+2*rad/4-2, pozX, pozY+rad/7, pozX-rad/3-2, pozY );
  }
  if (frameCount%7==0) {
    aripa=!aripa;
  }
}
void mouseClicked() {

  setup();
  framestart=frameCount;
  aInceputJoc=false;
}