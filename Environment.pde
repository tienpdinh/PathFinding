class Environment {
  int numSamples;
  int eWidth;
  int eHeight;
  float circleRadius;
  float thres;
  float[][] samples;
  PVector circleCoord;
  Vertex start;
  Vertex goal;
  
  public Environment(int numSamples, int eWidth, int eHeight, float circleRadius, float thres) {
    this.numSamples = numSamples;
    this.eWidth = eWidth;
    this.eHeight = eHeight;
    this.circleRadius = circleRadius;
    this.thres = thres;
    this.samples = new float[numSamples][2];
    this.circleCoord = new PVector(this.eWidth/2, this.eHeight/2);
    this.sample();
  }
  
  public void sample() {
    // rejection sampling method
    int count = 0;
    while (count < this.numSamples) {
      float tmpX = random(eWidth);
      float tmpY = random(eHeight);
      if (legalSample(tmpX, tmpY)) {
        samples[count][0] = tmpX;
        samples[count][1] = tmpY;
        count++;
      }
    }
  }
  
  public Graph buildGraph(int maxEdges, Vertex start, Vertex goal) {
    this.start = start;
    this.goal = goal;
    Graph g = new Graph();
    start.setStart();
    goal.setGoal();
    g.addVertex(start);
    g.addVertex(goal);
    // add all vertices to graph
    for (int i = 0; i < this.samples.length; i++) {
      Vertex tmpVertex = new Vertex(samples[i][0], samples[i][1]);
      g.addVertex(tmpVertex);
    }
    // now we build the edges
    for (int i = 0; i < g.vertices.size(); i++) {
      ArrayList<Edge> tmpEdges = new ArrayList<Edge>();
      for (int j = 0; j < g.vertices.size(); j++) {
        if (!g.vertices.get(i).equals(g.vertices.get(j))) {
          Edge tmpEdge = new Edge(g.vertices.get(i), g.vertices.get(j));
          if (legalEdge(tmpEdge)) {
            tmpEdges.add(tmpEdge);
          }
        }
      }
      java.util.Collections.sort(tmpEdges);
      for (int k = 0; k < maxEdges; k++) {
        if (k >= tmpEdges.size()) break;
        g.vertices.get(i).addEdge(tmpEdges.get(k));
      }
    }
    return g;
  }
  
  public boolean legalEdge(Edge e) {
    if (distanceFromPtToLine(this.circleCoord, e.src.asPoint(), e.asVec()) < this.circleRadius+this.thres) {
      PVector v1 = new PVector(e.src.x-circleCoord.x, e.src.y-circleCoord.y);
      PVector v2 = new PVector(e.des.x-circleCoord.x, e.des.y-circleCoord.y);
      PVector di = e.asVec();
      return di.dot(v1) / di.dot(v2) > 0;
    }
    return true;
  }
  
  public boolean legalSample(float x, float y) {
    return (pow(x-this.circleCoord.x, 2) + pow(y-this.circleCoord.y, 2)) > pow(circleRadius+this.thres, 2);
  }
  
  public void render() {
    background(1, 31, 75);
    noFill();
    noStroke();
    assert width >= eWidth;
    assert height >= eHeight;
    float x = (width - eWidth) / 2.;
    float y = (height - eHeight) / 2.;
    fill(179, 205, 224);
    rect(x, y, eWidth, eHeight);
    fill(0, 91, 150);
    circle(width / 2., height / 2., circleRadius*2);
    start.render(OFFSET_X, OFFSET_Y);
    goal.render(OFFSET_X, OFFSET_Y);
  }
}
