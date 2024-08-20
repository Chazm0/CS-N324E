class Bar extends GameObject {
  int barLength;

  Bar(PVector pos, int barLength) {
    super(pos);
    this.barLength = barLength;
  }

  void update() {
    pos.x = constrain(mouseX, barLength / 2, width - barLength / 2 - 200);
    pos.y = 700;
  }

  void draw() {
    rectMode(CENTER);
    rect(pos.x, pos.y, barLength, 15);
  }

  float getWidth() { return barLength; }
  float getHeight() { return 20; }
}
