abstract class GameObject {
  PVector pos;
  boolean visible = true;

  GameObject(PVector pos) {
    this.pos = pos;
  }

  abstract void draw();
  abstract float getWidth();
  abstract float getHeight();

  boolean checkCollision(GameObject other) {
    return visible && other.visible &&
         pos.x + getWidth()/2 > other.pos.x - other.getWidth()/2 &&
         pos.x - getWidth()/2 < other.pos.x + other.getWidth()/2 &&
         pos.y + getHeight()/2 > other.pos.y - other.getHeight()/2 &&
         pos.y - getHeight()/2 < other.pos.y + other.getHeight()/2;
  }
}
