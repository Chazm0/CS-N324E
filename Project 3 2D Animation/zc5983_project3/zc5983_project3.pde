Leaf t1;
Leaf t2;
Leaf t3;
FlappingBird b1;
FlappingBird b2;
FlappingBird b3;

void setup(){
  size(1000, 800);
  t1 = new Leaf(150, 700, #00A02C, -PI / 8);
  t2 = new Leaf(350, 400, #21FF00, PI / 16);
  t3 = new Leaf(800, 600, #C5F702, -PI / 10);
  b1 = new FlappingBird(300, 200, 3, 0);
  b2 = new FlappingBird(300, 300, 2, 2);
  b3 = new FlappingBird(100, 500, 2, -1);
}

void draw(){
  background(#72E561);
  fill(#1FF9FF);
  noStroke();
  int riverW = 80;
  beginShape();
  vertex(540, 0);
  bezierVertex(750, 100, 300, 550, 450, 800);
  vertex(450 + riverW, 800); 
  bezierVertex(300 + riverW, 550, 750 + riverW, 100, 540 + riverW, 0); 
  endShape(CLOSE);
  
  t1.display();
  t2.display();
  t3.display();
  
  b1.update();
  b1.display();
  b2.update();
  b2.display();
  b3.update();
  b3.display();
}

void mousePressed() {
  println(mouseX, mouseY);
}
