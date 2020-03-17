class Vertex {
  ArrayList<Edge> edges;
  float x;
  float y;
  boolean isStart = false;
  boolean isGoal = false;
  boolean visited = false;
  Vertex back;
  Vertex next;
  
  public Vertex(float x, float y) {
    this.edges = new ArrayList<Edge>();
    this.x = x;
    this.y = y;
    this.back = null;
    this.next = null;
  }
  public void addEdge(Edge edge) {
    edges.add(edge);
    // since we are working with undirected graph
    // we also add this edge to the destination vertex
    edge.des.edges.add(edge.inverse());
  }
  public PVector asPoint() {
    return new PVector(this.x, this.y);
  }
  public boolean equals(Vertex other) {
    return Float.compare(this.x, other.x) == 0 && Float.compare(this.y, other.y) == 0;
  }
  public void setStart() {
    this.isStart = true;
  }
  public void setGoal() {
    this.isGoal = true;
  }
  public void reset() {
    this.visited = false;
    this.back = null;
    this.next = null;
  }
  public void render(float offsetX, float offsetY) {
    noFill();
    int size = 3;
    if (isStart) {
      fill(255, 0, 0);
      size = 7;
    }
    else if (isGoal) {
      fill(0, 255, 0);
      size = 7;
    }
    else
      fill(255, 255, 255);
    noStroke();
    rect(x+offsetX, y+offsetY, size, size);
    fill(255);
  }
}
