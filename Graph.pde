class Graph {
  ArrayList<Vertex> vertices;
  
  public Graph() {
    this.vertices = new ArrayList<Vertex>();
  }
  
  public void addVertex(Vertex vertex) {
    this.vertices.add(vertex);
  }
  
  public void resetVertices() {
    for (int i = 0; i < this.vertices.size(); i++) {
      this.vertices.get(i).reset();
    }
  }
  
  public void dijkstra(Vertex s, Vertex g) {
    assert s.isStart;
    assert g.isGoal;
    resetVertices();
    java.util.PriorityQueue<Path> queue = new java.util.PriorityQueue<Path>();
    queue.add(new Path(s, 0));
    while (queue.size() > 0) {
      Path p = queue.poll();
      p.des.visited = true;
      if (p.des.equals(g)) break;
      for (int i = 0; i < p.des.edges.size(); i++) {
        Vertex aboutToVisit = p.des.edges.get(i).des;
        if (!aboutToVisit.visited) {
          boolean update = true; // helper variable to determine if update in the queue is needed
          // create a new path that goes from the vertex dequeued to aboutToVisit
          Path tmpPath = new Path(aboutToVisit, p.cost+p.des.edges.get(i).edgeLen);
          // check the queue to see if aboutToVisit is being present in the queue
          java.util.Iterator<Path> iter = queue.iterator();
          while (iter.hasNext()) {
            Path cur = iter.next();
            if (cur.equals(tmpPath) && cur.cost > tmpPath.cost) {
              iter.remove();
              update = true;
              break;
            } else if (cur.equals(tmpPath) && cur.cost <= tmpPath.cost) {
              update = false;
              break;
            }
          }
          if (update) {
            aboutToVisit.back = p.des;
            queue.add(tmpPath);
          }
        }
      }
    }
    // we now set up the next link to establish a linked list of path
    Vertex cur = g;
    while (cur.back != null) {
      Vertex prev = cur.back;
      prev.next = cur;
      cur = cur.back;
    }
  }
  
  public void render(float offsetX, float offsetY) {
    noFill();
    for (Vertex v : vertices) {
      v.render(offsetX, offsetY);
      for (Edge e : v.edges) {
        e.render(offsetX, offsetY);
      }
    }
  }
  
  public void renderPath(Vertex g, float offsetX, float offsetY) {
    assert g.back != null : "Could not find a path!";
    Vertex cur = g;
    strokeWeight(5);
    stroke(0, 0, 255);
    while (cur.back != null) {
      Vertex v = cur.back;
      line(cur.x+offsetX, cur.y+offsetY, v.x+offsetX, v.y+offsetY);
      cur = cur.back;
    }
  }
}
