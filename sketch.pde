int cols = 200;
int rows = 200;
PImage gbmap;
Node[] nodes = new Node[cols * rows];
ArrayList<Node> spaces = new ArrayList<Node>();
ArrayList<Node> currentNodes = new ArrayList<Node>();
Node startNode;
Node endNode;
void init() {
  spaces.clear();
  currentNodes.clear();
  loop();
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float w = divisibler(width, cols);
      float h = divisibler(height, rows);
      float x = i * w + w / 2;
      float y = j * h + h / 2;
      int index = i + cols * j;
      Node node = new Node(index, x, y, w, h);
      nodes[index] = node;
      if (gbmap.get((int)x, (int)y) == 0) {
        node.obstacle = true;
      } else {
        spaces.add(node);
      }
    }
  }
  startNode = spaces.get(int(random(spaces.size())));
  startNode.distance = 0;
  endNode = spaces.get(int(random(spaces.size())));
  currentNodes.add(startNode);
}
void setup() {
  size(displayWidth, displayWidth);
  noStroke();
  gbmap = loadImage("map.png");
  gbmap.resize(width, height);
  init();
}
void draw() {
  background(221);
  ArrayList<Node> find = new ArrayList<Node>(currentNodes);
  currentNodes.clear();
  for (Node node: find) {
    node.pathFind();
  }
  image(gbmap, 0, 0);
  for (Node node: nodes) {
    fill(255);
    node.render();
  }
}
void touchEnded() {
  init();
}
float divisibler(float num, float den) {
  float result = num / den;
  while (result % 1 != 0) {
    den--;
    result = num / den;
  }
  return result;
}