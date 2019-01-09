// the Friend class takes a shape and renders it in an interesting way.

class Friend {
  PShape my_shape;
  ArrayList<PVector> points; // list of vertices in the shape.

  Friend(PShape my_shape_) {
    my_shape = my_shape_;
    points = new ArrayList();
    update_points();
  }

  void update_points() {
    points.clear();
    for (int i=0; i<my_shape.getChildCount(); i++) {
      PShape child = my_shape.getChild(i);
      for (int j=0; j<child.getVertexCount(); j++) {
        PVector vert = child.getVertex(j);
        PVector transform = new PVector(sin((time/4 + vert.y)/4)*4, noise(time+i)*50, 0);
        vert = vert.add(transform);
        points.add(vert);
      }
    }
  }

  void render() {
    update_points();

    // wireframe:
    if (data.toggles[0] == 1.0) {
      noFill();
      stroke(255);
      strokeWeight(2);
      beginShape(TRIANGLES);
      for (int i = 0; i < my_shape.getChildCount(); i++) {
        PShape face = my_shape.getChild(i);
        int numVertices = face.getVertexCount();
        for (int j = 0; j < numVertices; j++) {
          vertex(face.getVertexX(j), face.getVertexY(j), face.getVertexZ(j));
        }
      }
      endShape();
    }
    
    // floaty points:
    beginShape(POINTS);
    for (PVector point : points) {
      strokeWeight(data.faders[0] * 10);
      vertex(point.x, point.y, point.z);
    }
    endShape();
  }
}
