class Tree{
  float treeX, treeY;
  PShape trunk;
  
  Tree(float treeX, float treeY){
    this.treeX = treeX;
    this.treeY = treeY;
    createTrunk();
  }
    
  void createTrunk() {
    trunk = createShape();
    trunk.beginShape();
    trunk.fill(#bf5700);
    trunk.noStroke();
    trunk.vertex(treeX - 50, treeY);
    trunk.vertex(treeX + 50, treeY);
    trunk.vertex(treeX + 20, treeY - 20);
    trunk.vertex(treeX + 20, treeY - 200);
    trunk.vertex(treeX - 20, treeY - 200);
    trunk.vertex(treeX - 20, treeY - 20);
    trunk.endShape(CLOSE);
  }
  
  void display(){
    shape(trunk);
  }
}
