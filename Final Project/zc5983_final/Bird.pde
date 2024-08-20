class Bird extends FCircle {
  String birdType;
  boolean accelerated = false;

  Bird(String birdType) {
    super(30);
    this.birdType = birdType;
    this.setDensity(0.8);
    if (birdType.equals("red")) {
      this.setFill(255, 0, 0);
    } else if (birdType.equals("yellow")) {
      this.setFill(255, 255, 0);
    }
  }

  void accelerate() {
    if (birdType.equals("yellow") && !accelerated) {
      PVector vel = new PVector(this.getVelocityX(), this.getVelocityY());
      vel.mult(2); 
      this.setVelocity(vel.x, vel.y);
      accelerated = true;
    }
  }
}
