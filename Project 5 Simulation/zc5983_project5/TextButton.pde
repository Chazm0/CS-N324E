class TextButton extends Button{
  int buttonType;
  String text;
  
  TextButton(int posX, int posY, int buttonH, String text){
    super(posX, posY, buttonH);
    this.text = text;
  }
  
  void draw(){
    super.draw();
    fill(0);
    textAlign(CENTER, CENTER);
    text(text, posX, posY);
  }
}
