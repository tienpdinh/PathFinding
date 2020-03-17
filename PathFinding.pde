Environment e;
Graph g;
int EN_WIDTH = 600;
int EN_HEIGHT = 600;
float OFFSET_X;
float OFFSET_Y;
int NUM_SAMPLES = 100;
float OBSTACLE_R = 150;
Vertex start;
Vertex goal;
Agent agent;

void setup() {
  size(800, 800, P2D);
  e = new Environment(NUM_SAMPLES, EN_WIDTH, EN_HEIGHT, OBSTACLE_R, 10);
  start = new Vertex(1, EN_HEIGHT-10);
  goal  = new Vertex(EN_WIDTH-10, 10);
  g = e.buildGraph(6, start, goal);
  g.dijkstra(start, goal);
  OFFSET_X = (width - EN_WIDTH) / 2.;
  OFFSET_Y = (height - EN_HEIGHT) / 2.;
  
  agent = new Agent(start, goal);
}

void draw() {
  e.render();
  g.renderPath(goal, OFFSET_X, OFFSET_Y);
  //g.render(OFFSET_X, OFFSET_Y);
  agent.update(.001, 1000, false);
  agent.render(OFFSET_X, OFFSET_Y);
}
