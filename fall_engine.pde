// Fall Game Engine 
int units = 5;
Fall[] balls = new Fall[units];
int timer = 0;
int vel = 1;
float dX;
float dY;
float rw;
float rh;
int score; 
boolean play; 
boolean start; 
boolean pause; 
boolean over; 

// Falling Object Class
class Fall {
  float r = width/9;
  float x = random(r, width-r);
  float y = random(-height);
  float f = random(3, 5);
  float c = random(256);
  
  void fall() {
    y += vel*f; 
    fill(c, 255, 255);
    ellipse(x, y, r, r);
    if (y > height) {
      x = random(r, width-r);
      y = random(-height/r);
      score -= 100;
    }
  }
}


void setup() {
  size(displayWidth, displayHeight);
  colorMode(HSB);
  background(0);
  smooth();
  noStroke();
  score = 0;
  start = true;
  pause = true; 
  for (int i = 0; i < balls.length; i++){
    balls[i] = new Fall();
  }
  rw = rh = width/9;
}

void draw() {
  background(0);

  dX = mouseX;
  dY = mouseY;
  
  if (start == true) {
    rectMode(CENTER);
    fill(255, random(25), 255);
    textAlign(CENTER);
    textSize(64);
    text("Ball Catcher Game", width/2, height/4);
    textSize(32);
    text("Catch falling balls into the box. ", width/2, height/2.8);
    textSize(25);
    text("For each captured object you receive 100 points ", width/2, height/1.5);
    text("or loose 100 if it reaches bottom. ", width/2, height/1.45);
    textSize(32);
    text("Press the screen to start a game ", width/2, height/2.2);
    text("or pause the proceeding one.", width/2, height/2);
  /*  text("To win the game you should gain 5000 points. ", width/2, height/1.4);
    text("If you loose more than 500 points, your game is over.", width/2, height/1.45);*/
  }
  
  if (play == true) {
    for (Fall b : balls) {
    b.fall();
    if (b.x > (dX - rw/2) && b.x < (dX + rw/2)) {
      if (b.y > (dY - rh/2) && b.y < (dY + rh/2)) {
        b.x = random(b.r, width-b.r);
        b.y = random(height/b.r);
        score += 100;
      }
    }
  }
  rectMode(CENTER);
  fill(255, 50, 50);
  rect(dX, dY, rw, rh);
  textSize(32);
  fill(255, 255, 255);
  text(score, width-50, 50);
 } 
 if (play == false && start == false && pause == true) {
   rectMode(CENTER);
   fill(100, random(125, 200), 255);
   textAlign(CENTER);
   textSize(64);
   text("Game Paused", width/2, height/2.5);
   textSize(32);
   text("Press the screen to continue", width/2, height/2);
 }
  // Score acceleration 
  if (score > 5000) {
    vel = 2;
  }
  if (score > 10000) {
    vel = 3;
  }
  if (score > 15000) {
    vel = 4;
  }
  if (score > 20000) {
    vel = 5;
  }
  if (score > 25000 && start == false) {
    play = false;
    pause = false; 
    rectMode(CENTER);
    fill(random(256), 255, 255);
    textAlign(CENTER);
    textSize(52);
    text("Congratulations!", width/2, height/3);
    text("You've Won!!!", width/2, height/2);
    /*textSize(25);
    text("Press the screen to start a new game.", width/2, height/1.5);
    */
  }
  if (score < -100 && start == false) {
    play = false;
    pause = false; 
    rectMode(CENTER);
    fill(255, 255, random(200, 256));
    textAlign(CENTER);
    textSize(52);
    text("Game Over", width/2, height/3);
    text("You've Lost.", width/2, height/2);
    /*textSize(25);
    text("Press the screen to start a new game.", width/2, height/1.5);
    */
  }
}

void mousePressed() {
  start = false;
  play = !play;
}