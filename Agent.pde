class Agent {
  PVector pos;
  PVector vel;
  Vertex curGoal;
  Vertex finalGoal;
  public Agent(float x, float y, Vertex start, Vertex goal) {
    this.pos = new PVector(x, y);
    this.curGoal = start;
    this.finalGoal = goal;
    this.vel = new PVector(curGoal.x-x, curGoal.y-y);
    this.vel.normalize();
  }
  public Agent(Vertex v, Vertex g) {
    this.pos = v.asPoint();
    this.curGoal = v.next;
    this.finalGoal = g;
    this.vel = new PVector(curGoal.x-v.x, curGoal.y-v.y);
    this.vel.normalize();
  }
  public void update(float dt, float speed, boolean usePathSmoothing) {
    if (usePathSmoothing)
      updatePS(finalGoal);
    if (reachedCurTarget()) {
      if (curGoal == null) return;
      curGoal = curGoal.next;
      if (curGoal == null) return;
      this.vel = new PVector(curGoal.x-pos.x, curGoal.y-pos.y);
      this.vel.normalize();
    }
    PVector tmpVel = this.vel.copy().mult(speed * dt);
    pos.add(tmpVel);
  }
  public void updatePS(Vertex goal) {
    // check from the goal upto the current target
    // to see if any of them is visible for the agent
    if (curGoal == null) return;
    Vertex tmp = goal;
    while (!tmp.equals(curGoal)) {
      Edge tmpPath = new Edge(new float[]{pos.x, pos.y}, new float[]{tmp.x, tmp.y});
      if (legalPath(tmpPath, new PVector(EN_WIDTH/2, EN_HEIGHT/2), OBSTACLE_R, 10)) {
        curGoal = tmp;
        this.vel = new PVector(curGoal.x-pos.x, curGoal.y-pos.y);
        this.vel.normalize();
        break;
      }
      tmp = tmp.back;
    }
  }
  public boolean reachedCurTarget() {
    if (curGoal == null) return true;
    return abs(pos.x-curGoal.x) < 1 && abs(pos.y-curGoal.y) < 1;
  }
  public void render(float offsetX, float offsetY) {
    fill(255);
    noStroke();
    rect(pos.x+offsetX, pos.y+offsetY, 7, 7);
  }
}
