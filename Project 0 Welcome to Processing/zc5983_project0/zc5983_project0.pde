PGraphics pg;
PImage img;
float[][] distances;
boolean calculated = false;
boolean showDistances = false;

void setup() {
  size(500, 500);
  pg = createGraphics(500, 500);
  distances = new float[500][500];
  createImage();
  calculateDistances();
}

void draw() {
  if (showDistances) {
    drawDistances();
  } else {
    image(pg, 0, 0);
  }
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    showDistances = !showDistances;
    redraw();
  }
}

void createImage() {
  pg.beginDraw();
  pg.background(200, 200, 0); 

  pg.noFill();
  
  pg.strokeWeight(2);
  pg.stroke(255, 0, 0);
  pg.ellipse(width/2, height/2, 400, 400);

  pg.strokeWeight(4);
  pg.stroke(0, 255, 0);
  pg.arc(width/2, height/2, 300, 300, 0, 2*PI);

  pg.strokeWeight(6);
  pg.stroke(0, 0, 255);
  pg.circle(width/2, height/2, 200);

  pg.endDraw();
  pg.loadPixels();

  img = createImage(500, 500, RGB);
  img.loadPixels();
  arrayCopy(pg.pixels, img.pixels);
  img.updatePixels();
}

//This function is inspired by ChatGPT
void calculateDistances() {
  int centerX = width / 2;
  int centerY = height / 2;

  float maxDist = dist(0, 0, centerX, centerY);

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float distance = dist(centerX, centerY, x, y);
      distances[x][y] = distance / maxDist; 
    }
  }
}

//This function is inspired by ChatGPT
void drawDistances() {
  colorMode(HSB, 100); 
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float dist = distances[x][y];
      color col = color(0, 0, dist * 100); 
      pixels[x + y * width] = col;
    }
  }
  updatePixels();
}
