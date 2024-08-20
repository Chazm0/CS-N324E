class ScrollBar extends Button {
  float minValue, maxValue, value;

  ScrollBar(int posX, int posY, int buttonH, float minValue, float maxValue) { 
    super(posX, posY, buttonH);
    this.minValue = minValue;
    this.maxValue = maxValue;
    this.value = minValue; 
  }

  void update(int mouseX) {
    float halfBarWidth = buttonH * 4.5;
    this.value = map(mouseX, posX - halfBarWidth, posX + halfBarWidth, minValue, maxValue);
    this.value = constrain(this.value, minValue, maxValue);
  }

  void draw() { 
    float halfBarWidth = buttonH * 4.5;
    fill(200);
    rect(posX, posY, buttonH * 10, buttonH);
    float xPos = map(value, minValue, maxValue, posX - halfBarWidth, posX + halfBarWidth);
    fill(100);
    rect(xPos, posY, buttonH, buttonH);
  }
  
  float getValue() {
    return value;
  }
  
  void reset() {
    this.value = minValue;
  }
  
  @Override
  boolean try_click(int X, int Y) {
    float halfBarWidth = buttonH * 4.5;
    float xPos = map(value, minValue, maxValue, posX - halfBarWidth, posX + halfBarWidth);
    if (X >= (xPos - buttonH / 2) && X <= (xPos + buttonH / 2) && Y >= (posY - buttonH / 2) && Y <= (posY + buttonH / 2)) {
      buttonClicked = true;
      update(X);
      return true;
    }
    return false;
  }
}
