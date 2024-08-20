import java.util.ArrayList;
import java.util.Collections;

ArrayList<Integer> frequencies;
ArrayList<Integer> counts;
boolean showWordCloud = true;

ArrayList<String> words;
PFont font;
color[] colors = {#FF6347, #4682B4, #32CD32};

void setup() {
  size(800, 600);
  font = createFont("Arial", 16, true);
  loadWords();
  loadFrequencies();
  noLoop();
}

void draw() {
  background(255);
  if (showWordCloud) {
    drawWordCloud();
  } else {
    drawBarChart();
  }
}

void loadWords() {
  words = new ArrayList<String>();
  String[] lines = loadStrings("data/uniquewords.txt");
  Collections.addAll(words, lines);
}

void drawWordCloud() {
  textFont(font);
  textAlign(LEFT, CENTER);

  int cols = 10; // Number of columns
  float margin = 10;
  float wordHeight = 20;
  float x = margin;
  float y = margin + wordHeight / 2;

  textSize(wordHeight);
  
  for (int i = 0; i < words.size(); i++) {
    String word = words.get(i);
    float wordWidth = textWidth(word);

    if (x + wordWidth + margin > width) {
      x = margin;
      y += wordHeight + margin;
    }

    if (y + wordHeight + margin > height) {
      break;
    }

    fill(colors[i % colors.length]);
    text(word, x, y);
    x += wordWidth + margin;
  }
}

void loadFrequencies() {
  frequencies = new ArrayList<Integer>();
  counts = new ArrayList<Integer>();
  String[] lines = loadStrings("data/wordcounts.txt");
  for (String line : lines) {
    String[] parts = line.split(": ");
    frequencies.add(int(parts[0]));
    counts.add(int(parts[1]));
  }
}

void drawBarChart() {
  int barWidth = width / frequencies.size();
  for (int i = 0; i < frequencies.size(); i++) {
    float barHeight = map(counts.get(i), 0, Collections.max(counts), 0, height);
    fill(0, 0, 255);
    rect(i * barWidth, height - barHeight, barWidth, barHeight);
  }
}

void mousePressed() {
  if (showWordCloud) {
    Collections.shuffle(words);
    redraw();
  }
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    showWordCloud = !showWordCloud;
    redraw();
  }
}
