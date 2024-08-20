class Grid extends Button {
  String state;

  Grid(int posX, int posY, int buttonH) {
    super(posX, posY, buttonH);
    state = "susceptible";
  }

  //Use rectangles as backup option in case the images doesn't work.
  @Override
  void draw() {
    if (state.equals("infectious")) {
      //fill(#FF5050);
      image(infectiousImg, posX, posY, buttonH, buttonH);
    } else if (state.equals("susceptible")) {
      //fill(#505050);
      image(susceptibleImg, posX, posY, buttonH, buttonH);
    } else if (state.equals("removed")) {
      //fill(#5050FF);
      image(removedImg, posX, posY, buttonH, buttonH);
    }
    stroke(200);
    //rect(posX, posY, buttonH, buttonH);
  }
}
