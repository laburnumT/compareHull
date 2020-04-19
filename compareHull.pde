ArrayList<PVector> points;
PGraphics space1, space2;


void setup() {
  //size(800, 800);
  fullScreen();
  frameRate(500);

  space1 = createGraphics(width / 2, height);
  space2 = createGraphics(width / 2, height);

  points = new ArrayList<PVector>();

  for (int i = 0; i < 500; i += 1) {
    PVector temp = new PVector(random(50, width / 2 - 50), random(50, height - 50));
    points.add(temp);
  }

  gSetup();
  jSetup();
}


void draw() {
  background(0);

  gDraw();

  jDraw();
}

void mousePressed() {
  if (mouseX < width / 2) {
    points.add(new PVector(mouseX, mouseY));
  } else {
    points.add(new PVector(mouseX - width / 2, mouseY));
  }
  gSetup();
  jSetup();
  jEnd = false;
  loop();
}
