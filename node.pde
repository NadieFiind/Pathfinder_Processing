class Node {
  int i;
  float x, y, w, h;
  float distance = cols * rows;
  boolean isPath = false;
  boolean visited = false;
  boolean obstacle = false;
  Node prevNode;
  ArrayList<Node> neighbors = new ArrayList<Node>();
  Node(int _i, float _x, float _y, float _w, float _h) {
    i = _i;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  void addNeighbors() {
    int top = i - cols;
    int right = (i + 1) % cols > 0 ? i + 1 : nodes.length;
    int bottom = i + cols;
    int left = (i - 1) % cols < cols - 1 ? i - 1 : nodes.length;
    int topRight = (top + 1) % cols > 0 ? top + 1 : nodes.length;
    int bottomRight = (bottom + 1) % cols > 0 ? bottom + 1 : nodes.length;
    int bottomLeft = (bottom - 1) % cols < cols - 1 ? bottom - 1 : nodes.length;
    int topLeft = (top - 1) % cols < cols - 1 ? top - 1 : nodes.length;
    int[] indices = {top, right, bottom, left, topRight, bottomRight, bottomLeft, topLeft};
    for (int index : indices) {
      try {
        Node neighbor = nodes[index];
        if (!neighbor.visited && !neighbor.obstacle) {
          neighbors.add(neighbor);
        }
      } 
      catch (ArrayIndexOutOfBoundsException error) {
      }
    }
  }
  void path() {
    isPath = true;
    if (prevNode != null) {
      prevNode.path();
    } else {
      noLoop();
    }
  }
  void pathFind() {
    addNeighbors();
    for (Node node : neighbors) {
      float totalDistance = distance + 1;
      if (node == endNode) {
        path();
      } else if (totalDistance < node.distance) {
        node.distance = totalDistance;
        node.prevNode = this;
        currentNodes.add(node);
      }
    }
    visited = true;
    neighbors.clear();
  }
  void render() {
    if (visited && this != startNode && this != endNode) {
      fill(0, 255, 0);
      rect(x, y, w, h);
    }
    if (isPath) {
      fill(255, 0, 0);
      rect(x, y, w, h);
    }
    if (this == startNode) {
      fill(0);
      rect(x, y, w, h);
    } else if (this == endNode) {
      fill(0, 0, 255);
      rect(x, y, w, h);
    }
  }
}