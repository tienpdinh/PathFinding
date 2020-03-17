class Path implements Comparable<Path> {
  Vertex des;
  float cost;
  public Path(Vertex des, float cost) {
    this.des = des;
    this.cost = cost;
  }
  public int compareTo(Path other) {
    if (other.cost > this.cost)
      return -1;
    else if (other.cost < this.cost)
      return 1;
    else return 0;
  }
  public boolean equals(Path other) {
    return this.des.equals(other.des);
  }
}
