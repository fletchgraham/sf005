// the Friend class takes a shape and renders it in an interesting way.

class Friend {
  PShape my_shape;
  ArrayList<PVector> points; // list of vertices in the shape.
  ArrayList<PVector> collapsed; // get rid of double verts.

  Friend(PShape my_shape_) {
    my_shape = my_shape_; // the base. what we're working with
    points = new ArrayList(); // all the points from the shape. including overlapping.
    collapsed = new ArrayList();
    update_points(); // load the points into the list.
    remove_doubles();
  }
  
  void remove_doubles() {
    collapsed.clear();
    for (PVector point : points) {
      collapsed.add(point);
    }
    for (int i = 0; i < points.size(); i++) {
      for (int j = 0; j < points.size(); j++) {
        if (i != j && 
        points.get(i).x == points.get(j).x 
        && points.get(i).y == points.get(j).y 
        && points.get(i).z == points.get(j).z) {
          
          try {
          collapsed.remove(i);
          } catch(Exception e){}
          
        }
      }
    }
  }
  
  void update_points() {
    points.clear();
    for (int i=0; i<my_shape.getChildCount(); i++) {
      PShape child = my_shape.getChild(i);
      for (int j=0; j<child.getVertexCount(); j++) {
        PVector vert = child.getVertex(j);
        points.add(vert);
      }
    }
  }
  
  void render1() {
    // wireframe:
    if (data.toggles[0] == 1.0) {
      noFill();
      stroke(255);
      strokeWeight(data.faders[0]*2);
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
  }

  void render2() {
    // floaty points:
    beginShape(POINTS);
    for (PVector point : points) {
      strokeWeight(data.faders[1] * 10);
      vertex(displace(point.x), displace(point.y), displace(point.z));
    }
    endShape();
  }
  
  void render3(){
    noFill();
    beginShape();
    for (PVector point : collapsed) {
      strokeWeight(data.faders[0]*2);
      vertex(displace(point.x), displace(point.y), displace(point.z));
    }
    endShape(CLOSE);
  }
  
  void render4(){}
  
}


float displace(float value) {
  return value + noise(value+time)*100-50;
}
