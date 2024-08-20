PImage img;
PImage buffer;
int lastFilter = 0;

void settings() {
  img = loadImage("pizza_cat.jpg");
  size(img.width, img.height);
}

void setup() {
  surface.setResizable(true);
  surface.setSize(img.width, img.height);
  buffer = createImage(img.width, img.height, RGB);
  img.loadPixels();
  buffer.pixels = img.pixels.clone(); 
  buffer.updatePixels();
  lastFilter = 0; 
  
  image(img, 0, 0);
}

void keyPressed() {
  int currentFilter = key - '0'; 
  if (currentFilter == 0) { 
    resetImage();
  } else if (currentFilter != lastFilter) {
    switch (currentFilter) {
      case 1:
        applyGrayscale();
        break;
      case 2:
        applyContrast();
        break;
      case 3:
        applyGaussianBlur();
        break;
      case 4:
        applyEdgeDetection();
        break;
    }
    lastFilter = currentFilter;
  }
  updateDisplay();
}

void draw() {
  image(buffer, 0, 0);
}

void updateDisplay() {
  buffer.updatePixels();
  image(buffer, 0, 0);
}

void resetImage() {
  buffer.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    buffer.pixels[i] = img.pixels[i];
  }
  buffer.updatePixels();
  lastFilter = 0; 
}

color applyKernelTo(PImage img, PImage buffer, float[] kernel, int x, int y) {
  float sumR = 0, sumG = 0, sumB = 0;

  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      int img_x = x + i, img_y = y + j;
      int ker_x = 1 + i, ker_y = 1 + j;
      sumR += convHelper(img, kernel, img_x, img_y, ker_x, ker_y, 'r');
      sumG += convHelper(img, kernel, img_x, img_y, ker_x, ker_y, 'g');
      sumB += convHelper(img, kernel, img_x, img_y, ker_x, ker_y, 'b');
    }
  }
  color finalColor = color(constrain(sumR, 0, 255), constrain(sumG, 0, 255), constrain(sumB, 0, 255));
  buffer.pixels[img.width * y + x] = finalColor;
  return finalColor;
}

float convHelper(PImage img, float[] kernel, int img_x, int img_y, int ker_x, int ker_y, char channel) {
  int img_index = img.width * img_y + img_x;
  int ker_index = 3 * ker_y + ker_x;
  color c = img.pixels[img_index];
  float colorValue = channel == 'r' ? red(c) : channel == 'g' ? green(c) : blue(c);
  return colorValue * kernel[ker_index];
}

void applyGrayscale() {
  resetImage();
  buffer.loadPixels();
  for (int i = 0; i < buffer.pixels.length; i++) {
    color c = buffer.pixels[i];
    float avg = (red(c) + green(c) + blue(c)) / 3;
    buffer.pixels[i] = color(avg, avg, avg);
  }
}

void applyContrast() {
  resetImage();
  buffer.loadPixels();
  float threshold = 128;
  float contrastFactor = 1.5;
  for (int i = 0; i < buffer.pixels.length; i++) {
    color c = buffer.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    r = ((r - threshold) * contrastFactor) + threshold;
    g = ((g - threshold) * contrastFactor) + threshold;
    b = ((b - threshold) * contrastFactor) + threshold;
    buffer.pixels[i] = color(constrain(r, 0, 255), constrain(g, 0, 255), constrain(b, 0, 255));
  }
}

void applyGaussianBlur() {
  resetImage();
  PImage tempBuffer = buffer.get();
  tempBuffer.loadPixels();
  buffer.loadPixels();
  
  float[] blurKernel = {
    0.0625, 0.125, 0.0625,
    0.125, 0.25, 0.125,
    0.0625, 0.125, 0.0625
  };
  
  for (int y = 1; y < img.height - 1; y++) {
    for (int x = 1; x < img.width - 1; x++) {
      applyKernelTo(tempBuffer, buffer, blurKernel, x, y);  
    }
  }
}

//Some of the code are inspired by ChatGPT.
void applyEdgeDetection() {
  resetImage();
  PImage tempBuffer = buffer.get();
  tempBuffer.loadPixels();
  buffer.loadPixels();

  float[] sobelX = {-1, 0, 1, 
                    -2, 0, 2, 
                    -1, 0, 1};
                    
  float[] sobelY = {-1, -2, -1, 
                    0, 0, 0, 
                    1, 2, 1};

  for (int y = 1; y < img.height - 1; y++) {
    for (int x = 1; x < img.width - 1; x++) {
      float sumRx = 0, sumGx = 0, sumBx = 0;
      float sumRy = 0, sumGy = 0, sumBy = 0;
      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          int idx = (y + i) * img.width + (x + j);
          color col = tempBuffer.pixels[idx];
          int kx = (i + 1) * 3 + (j + 1);
          int ky = (i + 1) * 3 + (j + 1);
          sumRx += red(col) * sobelX[kx];
          sumGx += green(col) * sobelX[kx];
          sumBx += blue(col) * sobelX[kx];
          sumRy += red(col) * sobelY[ky];
          sumGy += green(col) * sobelY[ky];
          sumBy += blue(col) * sobelY[ky];
        }
      }
      float finalR = sqrt(sq(sumRx) + sq(sumRy));
      float finalG = sqrt(sq(sumGx) + sq(sumGy));
      float finalB = sqrt(sq(sumBx) + sq(sumBy));
      buffer.pixels[img.width * y + x] = color(constrain(finalR, 0, 255), constrain(finalG, 0, 255), constrain(finalB, 0, 255));
    }
  }
}
