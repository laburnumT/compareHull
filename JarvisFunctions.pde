ArrayList<PVector> jPoints, jHull;
PVector jLeftMost, jCurrentVertex, jNextVertex;
int jIndex;
boolean jEnd = false;

void jSetup() {
  jPoints = new ArrayList<PVector>();
  for (PVector p : points) {
    jPoints.add(new PVector().set(p));
  }

  jHull = new ArrayList<PVector>();
 
  jPrepare();
}


void jDraw() {
  for (PVector p : jPoints) {
    stroke(255);
    strokeWeight(8);
    point(p.x, p.y);
  }

  beginShape();
  fill(0, 0, 255, 50);
  strokeWeight(1);
  for (PVector h : jHull) {
    vertex(h.x, h.y);
  }
  endShape(CLOSE);
  
  stroke(0, 255, 0);
  strokeWeight(8);
  for (PVector h : jHull) {
    point(h.x, h.y);
  }


  if (jEnd) {
    noLoop();
  }


  stroke(0, 255, 0);
  strokeWeight(2);
  line(jCurrentVertex.x, jCurrentVertex.y, jNextVertex.x, jNextVertex.y);
  PVector checking = jPoints.get(jIndex);

  stroke(255);
  line(jCurrentVertex.x, jCurrentVertex.y, checking.x, checking.y);

  PVector a = PVector.sub(jNextVertex, jCurrentVertex);
  PVector b = PVector.sub(checking, jCurrentVertex);
  float angle = a.cross(b).z;

  if (angle < 0) {
    jNextVertex = checking;
  }

  jIndex += 1;

  if (jIndex == jPoints.size()) {
    jIndex = 0;
    jHull.add(jNextVertex);
    jCurrentVertex = new PVector().set(jNextVertex);
    if (jNextVertex.equals(jHull.get(0))) {

      jEnd = true;
    }
    jNextVertex = new PVector().set(jLeftMost);
  }
}

void jPrepare() {
  jHull.clear();
  jQuickSort(jPoints, 0, jPoints.size() - 1);
  jLeftMost = jPoints.get(0);
  jCurrentVertex = jLeftMost;
  jNextVertex = jPoints.get(1);
  jIndex = 2;
  jHull.add(jCurrentVertex);
}


void jSwap(ArrayList<PVector> array, int i, int j) {
  PVector temp = new PVector().set(array.get(i));
  array.set(i, new PVector().set(array.get(j)));
  array.set(j, temp);
}

int jPartition(ArrayList<PVector> array, int left, int right, PVector pivot) {
  while (left <= right) {
    while ((array.get(left).x) < (pivot.x)) {
      left += 1;
    }
    while ((array.get(right).x) > (pivot.x)) {
      right -= 1;
    }
    if (left <= right) {
      jSwap(array, left, right);
      left += 1;
      right -= 1;
    }
  }
  return left;
}

int jQuickSort(ArrayList<PVector> array, int left, int right) {
  if (left >= right) {
    return 0;
  }
  PVector pivot = array.get((left + right) / 2);
  int jIndex = jPartition(array, left, right, pivot);
  jQuickSort(array, left, jIndex - 1);
  jQuickSort(array, jIndex, right);
  return 0;
}
