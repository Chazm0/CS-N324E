class Catapult {
  FCompound body;
  float x, y;

  Catapult(float x, float y) {
    this.x = x;
    this.y = y;
    body = new FCompound();
    
    FBox base = new FBox(10, 110);
    base.setPosition(0, 90);
    base.setStatic(true);
    base.setFill(150);
    base.setSensor(true);
    body.addBody(base);

    FBox arm1 = new FBox(10, 60);
    arm1.setPosition(-15, 10);
    arm1.setRotation(-PI / 6);
    arm1.setStatic(true);
    arm1.setFill(150);
    arm1.setSensor(true);
    body.addBody(arm1);

    FBox arm2 = new FBox(10, 60);
    arm2.setPosition(15, 10);
    arm2.setRotation(PI / 6);
    arm2.setStatic(true);
    arm2.setFill(150);
    arm2.setSensor(true);
    body.addBody(arm2);

    body.setPosition(x, y);
    body.setStatic(true);
  }

  void addToWorld(FWorld world) {
    world.add(body);
  }
  
  PVector getPosition() {
    return new PVector(x, y);
  }
}
