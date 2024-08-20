class Camera {
  PVector position;
  PVector target;
  
  Camera(PVector position, PVector target) {
    this.position = position;
    this.target = target;
  }
  
  void apply() {
    camera(position.x, position.y, position.z, target.x, target.y, target.z, 0, 1, 0);
  }
}
