class Pig extends FCircle {
  boolean alive;
  PVector initialPosition;

  Pig() {
    super(50);
    this.alive = true;
    this.setFill(0, 255, 0); 
    initialPosition = new PVector();
  }
  
  int checkCollision(FBox ground, FCircle bird, FWorld world) {
    if (this.isTouchingBody(ground) || this.isTouchingBody(bird)) {
      this.alive = false;
      world.remove(this);
      return 100; 
    }
    return 0;
  }
  
  void setInitialPosition(float x, float y) {
    initialPosition.set(x, y);
    this.setPosition(x, y);
  }

  PVector getInitialPosition() {
    return initialPosition;
  }
}
