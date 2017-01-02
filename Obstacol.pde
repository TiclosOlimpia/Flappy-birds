class Obstacol {
  float pozX;
  float caleY;
  float vitezaX = 3;
  float directieX = -1;
  float latimeObstacol=93;
  int inaltimeCale=70;
  Obstacol(float pozXin, float caleYin) {
    pozX = pozXin;
    caleY = random(inaltimeCale + 20, height - inaltimeCale - 20);
    ;
  }
 
  void move() {
    pozX=pozX + vitezaX * directieX;
    if (pozX < -latimeObstacol) {
      pozX = width + 2 * latimeObstacol;
      caleY = random(inaltimeCale + 20, height - inaltimeCale - 20);
    }
  }

  void display() {
    stroke(10, 10, 10, 100);  
    fill(60, 245, 80);
    rectMode(CORNERS);
    rect(pozX, caleY-inaltimeCale, pozX+latimeObstacol, 0);
    rect(pozX, caleY+inaltimeCale, pozX+latimeObstacol, height);
    println("rect(", pozX, 0, pozX+latimeObstacol, height, ");");
  }
  

  boolean coleziune(float centruX, float centruY, float raza) {
    if ( centruX + raza >= pozX  && centruY + raza <= caleY-(inaltimeCale/2) &&  centruX - raza <= pozX+latimeObstacol) {
      return true;
    }
      if ( centruX + raza >= pozX  && centruY + raza >= caleY+(inaltimeCale) && centruX - raza <= pozX+latimeObstacol) {
      return true;
    }
    return false;
  }

  boolean trecereObstacol(float centruX, float centruY, float raza) {
    if (centruX + raza <= pozX+latimeObstacol) {
      return true;
    }
    return false;
 }
}