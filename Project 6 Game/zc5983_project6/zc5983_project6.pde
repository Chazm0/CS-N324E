Ball ball;
Bar bar;
int numBricks;
Brick[] bricks;
Button[] buttons;
boolean isPaused = false;
int brickWidth = 49; 
int brickHeight = 15; 
int numRows = 8;
int horizontalSpacing = 5; 
int verticalSpacing = 5; 
int ballDiameter = 15;
int barLength = 60;
int score = 0;
int lives = 5; 
boolean allBricksGone = false;
boolean gameStart = false;

void setup() {
  size(800, 800);
  buttons = new Button[3];
  buttons[0] = new TextButton(700, 500, 50, "Pause");
  buttons[1] = new TextButton(700, 400, 50, "Start");
  buttons[2] = new TextButton(700, 400, 50, "Restart");
  
  PVector startPos = new PVector(random(width - 400), height / 2);
  PVector mousePos = new PVector(mouseX, mouseY);
  ball = new Ball(startPos, ballDiameter);
  bar = new Bar(mousePos, barLength);
  
  int bricksPerRow = (width - 200 - horizontalSpacing) / (brickWidth + horizontalSpacing);
  numBricks = bricksPerRow * numRows;
  
  bricks = new Brick[numBricks];
  int startX = 30;  
  int startY = 13; 

  for (int j = 0; j < numRows; j++) {
    for (int i = 0; i < bricksPerRow; i++) {
      int x = startX + i * (brickWidth + horizontalSpacing);
      int y = startY + j * (brickHeight + verticalSpacing);
      PVector brickPos = new PVector(x, y);
      bricks[j * bricksPerRow + i] = new Brick(brickPos, brickWidth, brickHeight);
    }
  }
}

void draw() {
  background(100);
  textSize(26);
  fill(200);
  rectMode(CORNER);
  rect(width - 200, 0, 200, height);
  
  fill(0);
  textAlign(CENTER);
  text("Score", width - 100, 50);
  text(score, width - 100, 80);
  text("Lives", width - 100, 150);
  text(lives, width - 100, 180);
  //For testing
  //text("Velocity", width - 100, 250); 
  //text(int(ball.vel.y), width - 100, 280); 

  pushStyle();
  rectMode(CENTER);
  if (lives > 0) {
    if (!allBricksGone && !gameStart) {
      buttons[0].draw();
      buttons[1].draw();
    } else if (gameStart){
      buttons[0].draw();
    }
    if (allBricksGone) {
      buttons[2].draw();
      gameStart = false;
      text("Congratulations!", (width - 200) / 2, height / 2);
    }
  } else {
    buttons[2].draw();
    gameStart = false;
    text("Game Over", (width - 200) / 2, height / 2);
  }
  popStyle();
  
  boolean anyBrickVisible = false;
  if (gameStart) {
    if (!isPaused) {
      if (lives > 0) {
        ball.update();
        ball.draw();
        ball.checkCollisionWithBar(bar);
      }
      for (Brick brick : bricks) {
        if (brick.visible) {
          anyBrickVisible = true;
          if (ball.checkCollision(brick)) {
            brick.visible = false; 
            ball.vel.y *= -1;
            score += 3;
            if (abs(ball.vel.x) < 20 && abs(ball.vel.y) < 20) {
              ball.vel.x *= 1.05;
              ball.vel.y *= 1.05;
            }
            ball.vel.x = constrain(ball.vel.x, -20, 20);
            ball.vel.y = constrain(ball.vel.y, -20, 20);
          }
        }
        if (!anyBrickVisible) {
          allBricksGone = true;
        }
        brick.draw();
      }
    } else {
      text("Paused", (width - 200) / 2 , height / 2);
    }
  }

  bar.update();
  bar.draw();
}

void resetGame() {
  score = 0;
  lives = 5; 
  allBricksGone = false;
  gameStart = true;
  
  ball.pos = new PVector(random(width - 400), height / 2);
  ball.vel = new PVector(4, -4);
  for (Brick brick : bricks) {
    brick.visible = true; 
  }
}

void mousePressed() {
  for (int a = 0; a < buttons.length; a++) { 
    if (buttons[a].try_click(mouseX, mouseY)) {
      if (a == 0) {
        isPaused = !isPaused;
      } else if (a == 1){
        gameStart = true;
      } else if (a == 2){
        resetGame();
      }
    }
  }
}

void mouseReleased() {
  for (Button b : buttons) {
    b.buttonClicked = false; 
  }
}
