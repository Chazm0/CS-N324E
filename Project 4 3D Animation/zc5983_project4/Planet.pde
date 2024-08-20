class Planet extends CelestialBody {
  float orbitRadius;
  float orbitSpeed;
  CelestialBody parent;
  float angle;

  Planet(float size, color bodyColor, float orbitRadius, float orbitSpeed, CelestialBody parent) {
    super(parent.position.x + orbitRadius, parent.position.y, parent.position.z, size, bodyColor);
    this.orbitRadius = orbitRadius;
    this.orbitSpeed = orbitSpeed;
    this.parent = parent;
    this.angle = 0;
  }

  void update() {
    angle += orbitSpeed;
    position.x = parent.position.x + cos(angle) * orbitRadius;
    position.z = parent.position.z + sin(angle) * orbitRadius;
  }

  void display() {
    update();
    super.display();
  }
}
