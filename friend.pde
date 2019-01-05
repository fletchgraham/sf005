// the Friend class takes a shape and renders it in an interesting way

class Friend {
  PShape my_shape;
  ArrayList<PVector> points;

  Friend(PShape my_shape_) {
    my_shape = my_shape_;
    points = new ArrayList();
    for (int i=0; i<my_shape.getChildCount(); i++) {
      PShape child = my_shape.getChild(i);
      for (int j=0; j<child.getVertexCount(); j++) {
        PVector vert = child.getVertex(j);
        points.add(vert);
      }
    }
  }

  void update_points() {
    points.clear();
    for (int i=0; i<my_shape.getChildCount(); i++) {
      PShape child = my_shape.getChild(i);
      for (int j=0; j<child.getVertexCount(); j++) {
        PVector vert = child.getVertex(j);
        PVector transform = new PVector(0,noise(x+i)*50,0);
        vert = vert.add(transform);
        points.add(vert);
      }
    }
  }

  void render() {
    strokeWeight(2);
    my_shape.setStroke(true);
    my_shape.setStroke(color(255));
    my_shape.setStrokeWeight(1.1f);
    my_shape.setTexture(img);
    update_points();
    
    /*
    for (PVector point : points) {
      fill(255,0,0);
      ellipse(point.x, point.y, 12, 12);
    }*/

    fill(0,0,0,0);
    stroke(255);
    /*
    beginShape(TRIANGLES);
    for (int i = 0; i < my_shape.getChildCount(); i++) {
      PShape face = my_shape.getChild(i);
      int numVertices = face.getVertexCount();
      for (int j = 0; j < numVertices; j++) {
        vertex(face.getVertexX(j), face.getVertexY(j), face.getVertexZ(j));
      }
    }
    endShape();*/
    
    beginShape(POINTS);
    strokeWeight(12);
    for (PVector point : points) {
      strokeWeight(9);
      vertex(point.x, point.y, point.z);
    }
    endShape();
  }
}
