class CelestialBody {
  PVector position;
  float size;
  color bodyColor;

  CelestialBody(float x, float y, float z, float size, color bodyColor) {
    this.position = new PVector(x, y, z);
    this.size = size;
    this.bodyColor = bodyColor;
  }

  void display() {
    fill(bodyColor);
    pushMatrix();
    translate(position.x, position.y, position.z);
    sphere(size);
    popMatrix();
  }
}
