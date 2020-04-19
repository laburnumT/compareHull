ArrayList<PVector> gPoints, gHull;
PVector gP0 = null;
int gP0Index = -1;


void gSetup() {
  gCurrentIndex = 2;
  gPoints = new ArrayList<PVector>();
  int i = 0;
  for (PVector pi : points) {
    PVector p = new PVector(pi.x + width / 2, pi.y);
    gPoints.add(new PVector().set(p));
    if (gP0 == null) {
      gP0 = new PVector().set(p);
      gP0Index = i;
    } else {
      if (p.y < gP0.y) {
        gP0.set(p);
        gP0Index = i;
      } else if (p.y == gP0.y) {
        if (p.x < gP0.x) {
          gP0.set(p);
          gP0Index = i;
        }
      }
    }
    i += 1;
  }

  gSwap(gPoints, gP0Index, 0);
  gQuickSort(gPoints, 1, gPoints.size() - 1);

  gHull = new ArrayList<PVector>();
  gHull.clear();
  for (int j = 0; j < 2; j += 1) {
    gHull.add(gPoints.get(j));
  }
}





int gCurrentIndex;

void gDraw() {
  if (gCurrentIndex < gPoints.size()) {
    PVector p = gPoints.get(gCurrentIndex);
    if (gHull.size() > 1 && gCcw(gHull.get(gHull.size() - 2), gHull.get(gHull.size() - 1), p) > 0) {
      gHull.remove(gHull.size() - 1);
    }
    if (gCcw(gHull.get(gHull.size() - 2), gHull.get(gHull.size() - 1), p) <= 0) {
      gHull.add(p);

      gCurrentIndex += 1;
    }


    //if (gCurrentIndex == gPoints.size()) {
    //  noLoop();
    //}
  }

  gDrawTheThings();
}





float gAngle(PVector p1) {
  PVector p0 = gPoints.get(0);
  PVector end = new PVector(width, p0.y);
  PVector line1 = PVector.sub(end, p0);
  PVector line2 = PVector.sub(p1, p0);

  return acos(line1.dot(line2) / (line1.mag() * line2.mag()));
}













float gCcw(PVector p0, PVector p1, PVector p2) {
  return (p2.x - p1.x) * (p1.y - p0.y) - (p1.x - p0.x) * (p2.y - p1.y);
}

void gDrawTheThings() {
  stroke(255);
  strokeWeight(8);
  for (PVector p : gPoints) {
    point(p.x, p.y);
  }

  fill(255, 0, 0, 50);
  strokeWeight(2);

  beginShape();
  for (PVector h : gHull) {
    vertex(h.x, h.y);
  }
  endShape(CLOSE);

  stroke(0, 255, 0);
  strokeWeight(10);
  for (PVector h : gHull) {
    point(h.x, h.y);
  }
  //println(hull.size());
}

void gSwap(ArrayList<PVector> array, int i, int j) {
  PVector temp = new PVector().set(array.get(i));
  array.set(i, new PVector().set(array.get(j)));
  array.set(j, temp);
}

int gPartition(ArrayList<PVector> array, int left, int right, PVector pivot) {
  while (left <= right) {
    while (gAngle(array.get(left)) < gAngle(pivot)) {
      left += 1;
    }
    while (gAngle(array.get(right)) > gAngle(pivot)) {
      right -= 1;
    }
    if (left <= right) {
      gSwap(array, left, right);
      left += 1;
      right -= 1;
    }
  }
  return left;
}

int gQuickSort(ArrayList<PVector> array, int left, int right) {
  if (left >= right) {
    return 0;
  }
  PVector pivot = array.get((left + right) / 2);
  int index = gPartition(array, left, right, pivot);
  gQuickSort(array, left, index - 1);
  gQuickSort(array, index, right);
  return 0;
}
