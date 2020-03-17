class Edge implements Comparable<Edge> {
  Vertex src;
  Vertex des;
  float edgeLen;
  public Edge(Vertex src, Vertex des) {
    this.src = src;
    this.des = des;
    this.edgeLen = this.len();
  }
  public Edge(float[] src, float[] des) {
    this.src = new Vertex(src[0], src[1]);
    this.des = new Vertex(des[0], des[1]);
    this.edgeLen = this.len();
  }
  public Edge inverse() {
    return new Edge(des, src);
  }
  public float len() {
    return sqrt(pow(src.x-des.x,2) + pow(src.y-des.y,2));
  }
  public PVector asVec() {
    return new PVector(des.x-src.x, des.y-src.y);
  }
  public void render(float offsetX, float offsetY) {
    noFill();
    stroke(100);
    strokeWeight(1);
    line(src.x+offsetX, src.y+offsetY, des.x+offsetX, des.y+offsetY);
    fill(255);
    text(String.valueOf(edgeLen), (src.x+des.x)/2+offsetX, (src.y+des.y)/2+offsetY);
  }
  public boolean equals(Edge other) {
    return (src.equals(other.src) && des.equals(other.des)) || (src.equals(other.des) && des.equals(other.src));
  }
  public int compareTo(Edge other) {
    if (this.edgeLen < other.edgeLen)
      return -1;
    else if (this.edgeLen > other.edgeLen)
      return 1;
    else return 0;
  }
}
