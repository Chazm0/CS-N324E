class Ball extends GameObject {
  PVector vel = new PVector(random(-6, 6), 6);
  float diameter;

  Ball(PVector pos, float diameter) {
    super(pos);
    this.diameter = diameter;
  }

  void update() {
    pos.add(vel);
    bounce();
    checkLoseLife();
  }

  void bounce() {
    if (pos.x > width - diameter / 2 - 200 || pos.x < diameter / 2) {
      vel.x *= -1;
    }
    if (pos.y < diameter / 2) {
      vel.y *= -1;
    }
  }
  
  void checkCollisionWithBar(Bar bar) {
    if (checkCollision(bar)) {
      vel.y *= -1; 
      float overlap = (pos.y + diameter/2) - (bar.pos.y - bar.getHeight()/2);
      pos.y -= overlap + 1;
    }
  }

  void draw() {
    if (visible) {
      ellipseMode(CENTER);
      ellipse(pos.x, pos.y, diameter, diameter);
    }
  }
  
  void checkLoseLife() {
    if (pos.y > height + diameter) { 
      lives--;
      if (lives > 0) {
        respawnBall();
      } else {
        gameEnd(); 
      }
    }
  }

  void respawnBall() {
    pos = new PVector(width/2, height + 30);
    int delayTime = millis() + 1500;  
    while (millis() < delayTime) {}
    pos = new PVector(width/2, height/2); 
    vel = new PVector(random(-6, 6), 6);
  }
  
  void gameEnd() {
    pos = new PVector(width/2, -50); 
    vel = new PVector(0, 0);
  }
  
  float getWidth() {
    return diameter;
  }
  
  float getHeight() {
    return diameter;
  }
}
