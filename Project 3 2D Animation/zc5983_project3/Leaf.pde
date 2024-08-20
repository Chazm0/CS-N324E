class Leaf extends Tree {
  PShape leaves;
  color leafColor;
  float shakeFactor;
  
  Leaf(float x, float y, color leafColor, float shakeFactor){
    super(x, y);
    this.leafColor = leafColor;
    this.shakeFactor = shakeFactor;
    createLeaves();
  }
  
  void createLeaves() {
    leaves = createShape(GROUP);
    noStroke();
    PShape leaf1 = createShape(ELLIPSE, -50, 0, 150, 150);
    leaf1.setFill(leafColor);
    PShape leaf2 = createShape(ELLIPSE, 50, 0, 150, 150);
    leaf2.setFill(leafColor); 
    PShape leaf3 = createShape(ELLIPSE, 0, -75, 150, 150);
    leaf3.setFill(leafColor);
  
    leaves.addChild(leaf1);
    leaves.addChild(leaf2);
    leaves.addChild(leaf3);
  }
  
  void display(){
    super.display();
    pushMatrix();
    translate(treeX, treeY - 200);
    float t = 0.5 * (sin(millis() / 1000.0) + 1.0);
    float angle = lerp(shakeFactor, -shakeFactor, t);
    rotate(angle);
    scale(sqrt(1.2 + angle));
    shape(leaves);
    popMatrix();
    
    
  }
}
