class Button{
  int posX, posY, buttonH;
  String buttonType, text, buttonShape;
  boolean buttonClicked;
  
  Button(int posX, int posY, int buttonH, String buttonType, String text, String buttonShape){
    this.posX = posX;
    this.posY = posY;
    this.buttonH = buttonH;
    this.buttonType = buttonType;
    this.text = text;
    this.buttonShape = buttonShape;
    this.buttonClicked = false;
    checkButton();
  }
    
  void checkButton(){
    if(((posX + buttonH / 2) > width || (posY + buttonH / 2) > height) || (posX + buttonH / 2) < 0 || (posY + buttonH / 2) < 0){
      println("Range exceeds the screen size!");
    }
  }
  
  void changeColor(){
    if(buttonClicked){
      fill(#FF0000);
    } else{
      fill(#00FF00);
    }
  }
  
  boolean try_click(int X, int Y){
    if(X <= (posX + buttonH / 2) && X >= (posX - buttonH / 2) && Y <= (posY + buttonH / 2) && Y >= (posY - buttonH / 2)){
      buttonClicked = !buttonClicked;
      return buttonClicked;
    } 
    return false;
  }
  
  void draw(){
    changeColor();
    rectMode(CENTER);
    ellipseMode(CENTER);
    shapeMode(CENTER);
    if(buttonType == "SQUARE_BUTTON"){
      rect(posX, posY, buttonH, buttonH);
    } else if(buttonType == "CIRCULAR_BUTTON"){
      ellipse(posX, posY, buttonH, buttonH);
    }
    if (text != "none") {
      fill(0);
      textSize(80);
      textAlign(CENTER, CENTER);
      text(text, posX, posY + 5);
    }
    
    if (buttonShape != "none") {
      fill(0); 
      if (buttonShape == "pause") {
        rect(posX - buttonH * 0.18, posY, buttonH * 0.2, buttonH * 0.5);
        rect(posX + buttonH * 0.18, posY, buttonH * 0.2, buttonH * 0.5);
      } else if (buttonShape == "restart") {
        pushStyle();
        noFill();
        strokeWeight(7);
        arc(posX, posY, buttonH - 24, buttonH - 24, 0, 3 * PI / 2);
        popStyle();
        triangle(posX, posY - 20, posX, posY - 6, posX + 11, posY - 12);
      } else if (buttonShape == "mainMenu") {
        rect(posX - buttonH * 0.11, posY - buttonH * 0.18, buttonH * 0.4, buttonH * 0.1);
        rect(posX - buttonH * 0.11, posY, buttonH * 0.4, buttonH * 0.1);
        rect(posX - buttonH * 0.11, posY + buttonH * 0.18, buttonH * 0.4, buttonH * 0.1);
        rect(posX + buttonH * 0.25, posY - buttonH * 0.18, buttonH * 0.1, buttonH * 0.1);
        rect(posX + buttonH * 0.25, posY, buttonH * 0.1, buttonH * 0.1);
        rect(posX + buttonH * 0.25, posY + buttonH * 0.18, buttonH * 0.1, buttonH * 0.1);
      }
    }
  }
}
