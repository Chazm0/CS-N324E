import fisica.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

PFont angryBirdsFont;
Minim minim;
AudioPlayer player;
FWorld world;
Bird bird;
Bird[] fakeBirds;
FBox ground;
Catapult catapult;
FBox catapultArm;
Brick[] bricksL1;
Brick[] bricksL2;
Brick[] bricks;
Pig[] pigsL1;
Pig[] pigsL2;
Pig[] pigs;
Button[] buttons = new Button[5];
String scoreFile = "scores.txt";
PVector dragStart, dragEnd;
boolean isMusicPlaying = true;
boolean gameEnded = false;
boolean birdLaunched = false;
boolean dragging = false;
int numBirds;
int score = 0;
int screen = 0;
int currentLevel = 1;
int highScoreLevel1 = 0;
int highScoreLevel2 = 0;
int birdDiameter = 30;

void setup() {
  size(1600, 900);
  textAlign(CENTER);
  angryBirdsFont = createFont("angrybirds-regular.ttf", 32);
  textFont(angryBirdsFont);
  Fisica.init(this);
  loadHighScores();
  
  minim = new Minim(this);
  player = minim.loadFile("Main_Theme.mp3");
  player.loop();
  
  buttons[0] = new Button(300, height / 2, 100, "SQUARE_BUTTON", "1", "none"); 
  buttons[1] = new Button(500, height / 2, 100, "SQUARE_BUTTON", "2", "none"); 
  buttons[2] = new Button(1300, 100, 50, "CIRCULAR_BUTTON", "none", "pause"); 
  buttons[3] = new Button(1400, 100, 50, "CIRCULAR_BUTTON", "none", "restart"); 
  buttons[4] = new Button(1500, 100, 50, "CIRCULAR_BUTTON", "none", "mainMenu"); 
  
  world = new FWorld();
  world.setGravity(0, 500);
  world.setGrabbable(false);
  
  ground = new FBox(width, 20);
  ground.setStatic(true);
  ground.setFill(#8E2600);
  ground.setPosition(width / 2, height);
  world.add(ground);
  
  catapult = new Catapult(250, height - 150);
  catapult.addToWorld(world);
  
  numBirds = 3;
  Bird[] birds = new Bird[numBirds];
  birds[0] = new Bird("red");
  birds[1] = new Bird("yellow");
  birds[2] = new Bird("red");
  PVector startPos = catapult.getPosition();
  bird = birds[0];
  bird.setPosition(startPos.x, startPos.y - 6);
  bird.setStatic(true);
  for (int i = 0; i < numBirds; i++) {
    world.add(birds[i]);
  }
  
  fakeBirds = new Bird[numBirds]; //<>//
  fakeBirds[0] = new Bird("red");
  fakeBirds[1] = new Bird("red");
  fakeBirds[2] = new Bird("yellow");
  for (int i = 0; i < numBirds; i++) { //<>//
    fakeBirds[i].setPosition(50 + 35 * i, height - 25);
    fakeBirds[i].setSensor(true);
    fakeBirds[i].setStatic(true);
    world.add(fakeBirds[i]);
  }

  //PBrick 1
  bricksL1 = new Brick[10];
  for (int i = 0; i < bricksL1.length; i++) {
    bricksL1[i] = new Brick("air");
    world.add(bricksL1[i]);
  }
  bricksL2 = new Brick[8];
  for (int i = 0; i < bricksL2.length; i++) {
    bricksL2[i] = new Brick("air");
    world.add(bricksL2[i]);
  }
  Brick[] bricks = new Brick[bricksL1.length + bricksL2.length];
  System.arraycopy(bricksL1, 0, bricks, 0, bricksL1.length);
  System.arraycopy(bricksL2, 0, bricks, bricksL1.length, bricksL2.length);
  
  pigsL1 = new Pig[2];
  for (int i = 0; i < pigsL1.length; i++) {
    pigsL1[i] = new Pig();
    world.add(pigsL1[i]);
  }
  pigsL2 = new Pig[4];
  for (int i = 0; i < pigsL2.length; i++) {
    pigsL2[i] = new Pig();
    world.add(pigsL2[i]);
  }
  Pig[] pigs = new Pig[pigsL1.length + pigsL2.length];
  System.arraycopy(pigsL1, 0, pigs, 0, pigsL1.length);
  System.arraycopy(pigsL2, 0, pigs, pigsL1.length, pigsL2.length);
}

void setupLevel1() {
  //PBrick 2
  bricksL1[0].setAttributes("stone");
  bricksL1[0].setInitialPositionAndSize(510, height - 75, 20, 120);
  bricksL1[1].setAttributes("stone");
  bricksL1[1].setInitialPositionAndSize(640, height - 75, 20, 120);
  bricksL1[2].setAttributes("wood");
  bricksL1[2].setInitialPositionAndSize(575, height - 145, 150, 20);
  bricksL1[3].setAttributes("glass");
  bricksL1[3].setInitialPositionAndSize(530, height - 190, 20, 60);
  bricksL1[4].setAttributes("glass");
  bricksL1[4].setInitialPositionAndSize(620, height - 190, 20, 60);
  bricksL1[5].setAttributes("wood");
  bricksL1[5].setInitialPositionAndSize(575, height - 225, 150, 20);
  bricksL1[6].setAttributes("wood");
  bricksL1[6].setInitialPositionAndSize(540, height - 290, 20, 120);
  bricksL1[7].setAttributes("wood");
  bricksL1[7].setInitialPositionAndSize(610, height - 290, 20, 120);
  bricksL1[8].setAttributes("wood");
  bricksL1[8].setInitialPositionAndSize(575, height - 360, 150, 20);
  bricksL1[9].setAttributes("wood");
  bricksL1[9].setInitialPositionAndSize(575, height - 390, 40, 40);
  
  pigsL1[0].setInitialPosition(575, height - 250);
  pigsL1[1].setInitialPosition(575, height - 180);

}

void setupLevel2() {
  bricksL2[0].setAttributes("stone");
  bricksL2[0].setInitialPositionAndSize(500, height - 75, 20, 100);
  bricksL2[1].setAttributes("stone");
  bricksL2[1].setInitialPositionAndSize(600, height - 125, 20, 200);
  bricksL2[2].setAttributes("stone");
  bricksL2[2].setInitialPositionAndSize(750, height - 170, 20, 300);
  bricksL2[3].setAttributes("stone");
  bricksL2[3].setInitialPositionAndSize(950, height - 220, 20, 400);
  bricksL2[4].setAttributes("wood");
  bricksL2[4].setInitialPositionAndSize(500, height - 100, 100, 20);
  bricksL2[5].setAttributes("wood");
  bricksL2[5].setInitialPositionAndSize(600, height - 200, 100, 20);
  bricksL2[6].setAttributes("wood");
  bricksL2[6].setInitialPositionAndSize(750, height - 325, 100, 20);
  bricksL2[7].setAttributes("wood");
  bricksL2[7].setInitialPositionAndSize(950, height - 425, 100, 20);
  
  pigsL2[0].setInitialPosition(500, height - 125);
  pigsL2[1].setInitialPosition(600, height - 225);
  pigsL2[2].setInitialPosition(750, height - 350);
  pigsL2[3].setInitialPosition(950, height - 425);
}

void draw() {
  if (screen == 0) {
    displayMainMenu();
  } else {
    displayLevel();
  }
}

void displayMainMenu() {
  background(255);
  buttons[0].draw();
  buttons[1].draw();
  buttons[2].draw();
  
  fill(0);
  textSize(130);
  text("Angry Birds!", width / 2, height / 2 - 200);
  textSize(32);
  text(highScoreLevel1, 300, height / 2 + 75);
  text(highScoreLevel2, 500, height / 2 + 75);
}

void displayLevel() {
  background(255);
  buttons[2].draw();
  buttons[3].draw();
  buttons[4].draw();
  
  world.step();
  world.draw();

  fill(0);
  textSize(32);
  text("Score: " + score, 100, 40);
  
  if (dragging) {
    pushStyle();
    strokeWeight(5);
    PVector startPos = catapult.getPosition();
    
    //PCatapult 1
    //Limits drag range
    dragEnd = new PVector(mouseX, mouseY);
    PVector direction = PVector.sub(dragEnd, startPos);
    if (direction.mag() > 150) {
      direction.setMag(150);
      dragEnd = PVector.add(startPos, direction);
    }
    
    line(startPos.x + 20, startPos.y, dragEnd.x + 15, dragEnd.y);
    line(startPos.x - 20, startPos.y, dragEnd.x - 15, dragEnd.y);
    bird.setPosition(dragEnd.x, dragEnd.y);
    popStyle();
  }
  
  //PGoal 1
  boolean allPigsGone = true;
  for (Pig pig : pigs) {
    if (pig.alive) {
      allPigsGone = false;
      score += pig.checkCollision(ground, bird, world);
    }
  }
  
  //PGoal 2, 3
  if (allPigsGone) {
    if (!gameEnded) {
      score += numBirds * 100; 
    }
    gameWon();
    gameEnded = true;
  } else if (numBirds == 0 && !anyBirdsOnCatapult() && allMotionsStopped()) {
    gameLost();
    gameEnded = true;
  }
}

boolean allMotionsStopped() {
  if (!(abs(bird.getVelocityX()) <= 10 && abs(bird.getVelocityY()) <= 10)) {
    return false;
  }
  for (Brick brick : bricks) {
    if (!(abs(brick.getVelocityX()) <= 10 && abs(brick.getVelocityY()) <= 10)) {
      return false;
    }
  }
  for (Pig pig : pigs) {
    if (!(abs(pig.getVelocityX()) <= 10 && abs(pig.getVelocityY()) <= 10)) {
      return false;
    }
  }
  return true;
}

boolean anyBirdsOnCatapult() {
  return !birdLaunched;
}

void gameWon() {
  fill(255, 0, 0);
  textSize(60);
  text("Game Won!", width / 2, height / 2);
}

void gameLost() {
  fill(0, 255, 0);
  textSize(60);
  text("Game Lost!", width / 2, height / 2);
}

void mousePressed() {
  for (Button button : buttons) {
    if (button.try_click(mouseX, mouseY)) {
      button.buttonClicked = true;
    }
  }
  
  if (!birdLaunched && dist(mouseX, mouseY, bird.getX(), bird.getY()) < birdDiameter) {
    dragging = true;
    dragStart = new PVector(mouseX, mouseY);
  }
  
  //PBird 1
  if (birdLaunched) {
    for (int i = 0; i <= numBirds; i++) {
      if (fakeBirds[i] != null && dist(mouseX, mouseY, fakeBirds[i].getX(), fakeBirds[i].getY()) < birdDiameter / 2) {
        PVector startPos = catapult.getPosition();
        bird = new Bird(fakeBirds[i].birdType);
        bird.setPosition(startPos.x, startPos.y - 6);
        bird.setStatic(true);
        world.add(bird);
        world.remove(fakeBirds[i]);
        fakeBirds[i] = null;
        birdLaunched = false;
        break;
      }
    }
  }
}

void mouseReleased() {
  for (int i = 0; i < buttons.length; i++) {
    if (buttons[i].buttonClicked) {
      buttons[i].buttonClicked = false;
      if (i == 0) {
        if (score > highScoreLevel1) {
          highScoreLevel1 = score;
          saveStrings(scoreFile, new String[]{str(highScoreLevel1), str(highScoreLevel2)});
        }
        score = 0;
        screen = 1;
        currentLevel = 1;
        resetLevel();
        setupLevel1();
      } else if (i == 1) {
        if (score > highScoreLevel2) {
          highScoreLevel2 = score;
          saveStrings(scoreFile, new String[]{str(highScoreLevel1), str(highScoreLevel2)});
        }
        score = 0;
        screen = 2;
        currentLevel = 2;
        resetLevel();
        setupLevel2();
      } else if (i == 2) {
        if (isMusicPlaying) {
          player.pause();
        } else {
          player.play();
        }
        isMusicPlaying = !isMusicPlaying;
      } else if (i == 3) {
        resetLevel();
      } else if (i == 4) {
        if (screen == 1 && score > highScoreLevel1) {
          highScoreLevel1 = score;
        } else if (screen == 2 && score > highScoreLevel2) {
          highScoreLevel2 = score;
        }
        saveStrings(scoreFile, new String[]{str(highScoreLevel1), str(highScoreLevel2)});
        screen = 0;
        resetLevel();
      }
    }
  }
  
  //PCatapult 2
  if (dragging) {
    bird.setStatic(false);
    dragEnd = new PVector(mouseX, mouseY);

    PVector force = PVector.sub(dragStart, dragEnd).mult(10);
    bird.addImpulse(force.x, force.y);
    dragging = false;
    birdLaunched = true;
    numBirds--;
  }
}

void keyPressed() {
  if (key == ' ' && birdLaunched && bird.birdType == "yellow") {
    bird.accelerate();
  }
}

void resetLevel() {
  score = 0;
  gameEnded = false;

  world = new FWorld();
  world.setGravity(0, 500);
  world.setGrabbable(false);

  ground = new FBox(width, 20);
  ground.setStatic(true);
  ground.setFill(#8E2600);
  ground.setPosition(width / 2, height);
  world.add(ground);
  
  catapult = new Catapult(250, height - 150);
  catapult.addToWorld(world);
  
  numBirds = 3;
  for (int i = 1; i < numBirds; i++) {
    world.remove(fakeBirds[i]);
    if (fakeBirds[i] == null) {
    fakeBirds[i] = new Bird(i == 2 ? "yellow" : "red");
    fakeBirds[i].setPosition(50 + 35 * i, height - 25);
    fakeBirds[i].setSensor(true);
    fakeBirds[i].setStatic(true);
    } else {
      fakeBirds[i].setPosition(50 + 35 * i, height - 25);
      fakeBirds[i].setStatic(true);
    }
    world.add(fakeBirds[i]);
  }
  
  world.remove(bird);
  Bird[] birds = new Bird[numBirds];
  birds[0] = new Bird("red");
  birds[1] = new Bird("yellow");
  birds[2] = new Bird("red");
  PVector startPos = catapult.getPosition();
  bird = birds[0];
  bird.setPosition(startPos.x, startPos.y - 6);
  bird.setStatic(true);
  birdLaunched = false;
  world.add(bird);
  
  if (currentLevel == 1) {
    pigs = pigsL1;
    bricks = bricksL1;
  } else if (currentLevel == 2) {
    pigs = pigsL2;
    bricks = bricksL2;
  }
  
  for (int i = 0; i < pigs.length; i++) {
    world.remove(pigs[i]);
    pigs[i].alive = true;
    pigs[i].setVelocity(0, 0);
    pigs[i].setAngularVelocity(0);
    pigs[i].setRotation(0);
    pigs[i].setPosition(pigs[i].getInitialPosition().x, pigs[i].getInitialPosition().y);
    world.add(pigs[i]);
  }

  for (int i = 0; i < bricks.length; i++) {
    world.remove(bricks[i]);
    bricks[i].setVelocity(0, 0);
    bricks[i].setAngularVelocity(0);
    bricks[i].setRotation(0);
    bricks[i].setPosition(bricks[i].getInitialPosition().x, bricks[i].getInitialPosition().y);
    world.add(bricks[i]);
  }
}

void loadHighScores() {
  String[] scores = loadStrings(scoreFile);
  if (scores != null && scores.length == 2) {
    highScoreLevel1 = int(scores[0]);
    highScoreLevel2 = int(scores[1]);
  }
}
