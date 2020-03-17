PVector project(PVector a, PVector b) {
  // project vector a onto vector b
  float len = (a.x*b.x+a.y*b.y) / b.magSq();
  return new PVector(b.x*len, b.y*len);
}

float distanceFromPtToLine(PVector point, PVector ptOnLine, PVector dir) {
    PVector tmp = new PVector(point.x-ptOnLine.x, point.y-ptOnLine.y);
    PVector proj = project(tmp, dir);
    tmp.sub(proj);
    return tmp.mag();
}

boolean legalPath(Edge e, PVector circle, float r, float thres) {
  if (distanceFromPtToLine(circle, e.src.asPoint(), e.asVec()) < r+thres) {
    PVector v1 = new PVector(e.src.x-circle.x, e.src.y-circle.y);
    PVector v2 = new PVector(e.des.x-circle.x, e.des.y-circle.y);
    PVector di = e.asVec();
    return di.dot(v1) / di.dot(v2) > 0;
  }
  return true;
}
