class Button{
  int posX, posY, buttonH;
  boolean buttonClicked;
  
  Button(int posX, int posY, int buttonH){
    this.posX = posX;
    this.posY = posY;
    this.buttonH = buttonH;
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
    rect(posX, posY, buttonH * 2, buttonH);
  }
}
