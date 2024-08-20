class FPSCamera extends Camera {
  PVector direction;
  float speed = 5;

  FPSCamera(PVector position, PVector target) {
    super(position, target);
    //Inspired by ChatGPT
    direction = PVector.sub(target, position).normalize();
  }

  void update() {
    if (mousePressed && mouseButton == LEFT) {
      float angleX = (pmouseX - mouseX) * 0.01;
      float angleY = (pmouseY - mouseY) * 0.01;

      direction = rotateY(direction, angleX);
      
      PVector rightAxis = direction.cross(new PVector(0, 1, 0)).normalize();
      direction = rotateAroundAxis(direction, rightAxis, angleY);

      target = PVector.add(position, direction);
    }

    if (keyPressed) {
      if (key == 'w' || key == 'W') {
        moveForward();
      } else if (key == 's' || key == 'S') {
        moveBackward();
      } else if (key == 'a' || key == 'A') {
        moveLeft();
      } else if (key == 'd' || key == 'D') {
        moveRight();
      }
    }
  }
  //Inspired by ChatGPT
  PVector rotateY(PVector v, float angle) {
    float cosAngle = cos(angle);
    float sinAngle = sin(angle);
    float x = v.x * cosAngle - v.z * sinAngle;
    float z = v.x * sinAngle + v.z * cosAngle;
    return new PVector(x, v.y, z);
  }

  PVector rotateAroundAxis(PVector v, PVector axis, float angle) {
    float cosAngle = cos(angle);
    float sinAngle = sin(angle);
    float dot = v.dot(axis);
    PVector cross = v.cross(axis);
    //Inspired by ChatGPT
    PVector rotated = new PVector(
      v.x * cosAngle + cross.x * sinAngle + axis.x * dot * (1 - cosAngle),
      v.y * cosAngle + cross.y * sinAngle + axis.y * dot * (1 - cosAngle),
      v.z * cosAngle + cross.z * sinAngle + axis.z * dot * (1 - cosAngle)
    );
    return rotated;
  }

  void moveForward() {
    PVector move = PVector.mult(direction, speed);
    position.add(move);
    target.add(move);
  }

  void moveBackward() {
    PVector move = PVector.mult(direction, -speed);
    position.add(move);
    target.add(move);
  }

  void moveLeft() {
    PVector left = direction.cross(new PVector(0, 1, 0)).normalize();
    PVector move = PVector.mult(left, -speed);
    position.add(move);
    target.add(move);
  }

  void moveRight() {
    PVector right = direction.cross(new PVector(0, 1, 0)).normalize();
    PVector move = PVector.mult(right, speed);
    position.add(move);
    target.add(move);
  }

  void apply() {
    update();
    camera(position.x, position.y, position.z, target.x, target.y, target.z, 0, 1, 0);
  }
}
