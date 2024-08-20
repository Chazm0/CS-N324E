class Brick extends FBox {
  String brickType;
  int x, y, w, h;
  PVector initialPosition;
  
  Brick(String brickType) {
    super(0, 0);
    this.brickType = brickType;
    setAttributes(brickType);
    setInitialPositionAndSize(x, y, w, h);
  }
  
  void setAttributes(String brickType) {
    if (brickType.equals("air")) {
      this.setFill(255, 255, 255);
      this.setSensor(true);
    } else if (brickType.equals("stone")) {
      this.setFill(100, 100, 100);
      this.setDensity(3);
      this.setSensor(false);
    } else if (brickType.equals("wood")) {
      this.setFill(139, 69, 19);
      this.setDensity(1);
      this.setSensor(false);
    } else if (brickType.equals("glass")) {
      this.setFill(173, 216, 230);
      this.setDensity(0.5);
      this.setSensor(false);
    } 
  }
  
  void setInitialPositionAndSize(int x, int y, int w, int h) {
    this.initialPosition = new PVector(x, y);
    this.setPosition(x, y);
    this.setWidth(w);
    this.setHeight(h);
  }

  PVector getInitialPosition() {
    return initialPosition;
  }
}
