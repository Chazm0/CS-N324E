class Bird {
  PVector position;
  PShape birdShape;
  PShape wing;

  Bird(float startX, float startY) {
    this.position = new PVector(startX, startY);
    createBirdShape();
  }

  void createBirdShape() {
    birdShape = createShape(GROUP);

    PShape head = createShape(ELLIPSE, 35, 0, 30, 30);
    head.setFill(#17B0FF);
    birdShape.addChild(head);

    PShape eye = createShape(ELLIPSE, 40, -3, 5, 5);
    eye.setFill(#004FB4);
    birdShape.addChild(eye);

    PShape beak = createShape(TRIANGLE, 50, 0, 47, 10, 70, 10);
    beak.setFill(#004FB4);
    birdShape.addChild(beak);

    PShape body = createShape(ELLIPSE, 0, 0, 70, 30);
    body.setFill(#17B0FF);
    birdShape.addChild(body);

    wing = createShape(TRIANGLE, 10, 0, -30, 0, -80, -40);
    wing.setFill(#004FB4);
  }

  void displayBody() {
    shape(birdShape);
  }
}
