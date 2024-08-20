PImage susceptibleImg, infectiousImg, removedImg;
PFont font;
int infectiousRate, recoverRate;
int cols, rows;
Grid[][] currentGrid, nextGrid;
int updateInterval = 1000;
int lastUpdateTime = 0;
int simulationSpeed = 1000 / 60;
boolean running = true;
boolean simulationStarted = false;
int day = 0;
Button[] buttons;
ScrollBar[] scrollBars;

int cellSize = 80;

void setup() {
  size(1200, 800);
  cols = height / cellSize;
  rows = height / cellSize;
  currentGrid = new Grid[cols][rows];
  nextGrid = new Grid[cols][rows];

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int x = i * cellSize;
      int y = j * cellSize;
      currentGrid[i][j] = new Grid(x, y, cellSize);
      nextGrid[i][j] = new Grid(x, y, cellSize);
    }
  }
  
  font = createFont("Arial", 25);
  textFont(font);
  
  buttons = new Button[1];
  buttons[0] = new TextButton(1000, 200, 50, "Reset");
  //buttons[1] = new TextButton(1000, 100, 50, "Start");
  
  scrollBars = new ScrollBar[2]; 
  scrollBars[0] = new ScrollBar(1000, 300, 25, 0, 100); 
  scrollBars[1] = new ScrollBar(1000, 400, 25, 0, 100); 
  
  susceptibleImg = loadImage("grey.png");
  infectiousImg = loadImage("red.png"); 
  removedImg = loadImage("blue.png");
  
  thread("simulate");
}

void draw() {
  background(255);
  drawGrid(currentGrid);
  if (simulationStarted && millis() - lastUpdateTime >= updateInterval) {
    updateGrid();
    lastUpdateTime = millis();
    day++;
  }
  
  infectiousRate = int(scrollBars[0].getValue()); 
  recoverRate = int(scrollBars[1].getValue());
  
  pushStyle();
  rectMode(CENTER);
  for (Button b : buttons) {
    b.draw();
  }
  for (ScrollBar sb : scrollBars) { 
    sb.draw();
  }
  fill(0); 
  text("Infectious Rate: " + infectiousRate, 1000, 260);
  text("Recovery Rate: " + recoverRate, 1000, 360);
  text("Day: " + day, 1000, 470);
  popStyle();
}

void mousePressed() {
  int i = mouseX / cellSize;
  int j = mouseY / cellSize;
  if (i >= 0 && i < cols && j >= 0 && j < rows) {
    currentGrid[i][j].state = "infectious";
    simulationStarted = true;
  }
  
  for (int a = 0; a < buttons.length; a++) { 
    if (buttons[a].try_click(mouseX, mouseY)) {
      if (a == 0) {
        resetGrid(); 
      } else if (a == 1) {
      }
    }
  }
  
  for (ScrollBar sb : scrollBars) {
    sb.try_click(mouseX, mouseY);
  }
}

void mouseReleased() {
  for (Button b : buttons) {
    b.buttonClicked = false; 
  }
  for (ScrollBar sb : scrollBars) {
    sb.buttonClicked = false;
  }
}

void mouseDragged() {
  for (ScrollBar sb : scrollBars) {
    if (sb.buttonClicked) {
      sb.update(mouseX);
    }
  }
}

void drawGrid(Grid[][] grid) {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].draw();
    }
  }
}

void updateGrid() {
  boolean hasInfectious = false; 

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int infectiousNeighbours = countInfectiousNeighbours(currentGrid, i, j);

      if (currentGrid[i][j].state.equals("infectious")) {
        if (random(100) < recoverRate) {
          nextGrid[i][j].state = "removed";
        } else {
          nextGrid[i][j].state = "infectious";
          hasInfectious = true;
        }
      } else if (currentGrid[i][j].state.equals("susceptible")) {
        if (infectiousNeighbours > 0 && random(100) < infectiousRate) {
          nextGrid[i][j].state = "infectious";
          hasInfectious = true; 
        } else {
          nextGrid[i][j].state = "susceptible";
        }
      } else if (currentGrid[i][j].state.equals("removed")) {
        nextGrid[i][j].state = "removed";
      }
    }
  }

  if (!hasInfectious) {
    simulationStarted = false; 
  } // Added line

  Grid[][] temp = currentGrid;
  currentGrid = nextGrid;
  nextGrid = temp;
}


int countInfectiousNeighbours(Grid[][] grid, int x, int y) {
  int infectiousCount = 0;
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (i == 0 && j == 0) continue;
      int newX = x + i;
      int newY = y + j;
      if (newX >= 0 && newX < cols && newY >= 0 && newY < rows) {
        if (grid[newX][newY].state.equals("infectious")) {
          infectiousCount++;
        }
      }
    }
  }
  return infectiousCount;
}

void resetGrid() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      currentGrid[i][j].state = "susceptible";
      nextGrid[i][j].state = "susceptible";
    }
  }
  day = 0;
  simulationStarted = false; 
}

void simulate() { 
  while (true) {
    if (running && simulationStarted) {
      long startTime = millis();
      updateGrid();
      long endTime = millis();
      int elapsedTime = int(endTime - startTime);
      int sleepTime = simulationSpeed - elapsedTime;
      if (sleepTime > 0) {
        delay(sleepTime);
      }
    }
  }
}
