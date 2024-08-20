class OrbitalCamera extends Camera {
  float distance;
  float angleX, angleY;

  OrbitalCamera(PVector target, float distance) {
    super(new PVector(0, 0, distance), target);
    this.distance = distance;
    angleX = angleY = 0;
    updatePosition();
  }

  void update() {
    if (mousePressed && mouseButton == LEFT) {
      angleX += (pmouseX - mouseX) * 0.01;
      angleY += (pmouseY - mouseY) * 0.01;
    } else if (mousePressed && mouseButton == RIGHT) {
      distance += (pmouseY - mouseY) * 0.5;
    }

    updatePosition();
  }

  void updatePosition() {
    position.x = cos(angleX) * cos(angleY) * distance + target.x;
    position.y = sin(angleY) * distance + target.y;
    position.z = sin(angleX) * cos(angleY) * distance + target.z;
  }

  void apply() {
    update();
    super.apply();
  }

  void setTarget(PVector newTarget) {
    this.target = newTarget;
    updatePosition();
  }
}
