class Brick extends GameObject {
  float brickWidth;
  float brickHeight;
    
  Brick(PVector pos, float width, float height) {
    super(pos);
    this.brickWidth = width;
    this.brickHeight = height;
  }

  void draw() {
    if (visible) {
      rectMode(CENTER);
      rect(pos.x, pos.y, brickWidth, brickHeight);
    }
  }
  
  float getWidth() { 
    return brickWidth; 
  }
  
  float getHeight() { 
    return brickHeight; 
  }
}
