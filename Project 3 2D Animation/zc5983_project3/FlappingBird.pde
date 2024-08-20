class FlappingBird extends Bird {
  PVector velocity;

  FlappingBird(float startX, float startY, float velX, float velY) {
    super(startX, startY);
    this.velocity = new PVector(velX, velY);
  }

  void update() {
    position.add(velocity);
    if (position.x > width) {
      position.x = 0;
    }
    if (position.x < 0) {
      position.x = width;
    }
    if (position.y > height) {
      position.y = 0;
    }
    if (position.y < 0) {
      position.y = height;
    }
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    displayBody();
    popMatrix();

    pushMatrix();
    translate(position.x, position.y);
    rotate(sin(millis() * 0.01) * PI / 6);
    shape(wing);
    popMatrix();
  }
}
