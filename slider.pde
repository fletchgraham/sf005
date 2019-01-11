// slider ui element

class Element {
  float x = 0.0;
  float y = 0.0;
  float w = 100.0;
  float h = 24.0;

  Element(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }

  PVector over() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      float x_percent = (mouseX - x)/ w;
      float y_percent = (mouseY - y)/ h;
      PVector coords_relative = new PVector(x_percent, y_percent);
      return coords_relative;
    } else {
      return null;
    }
  }
}

class Slider extends Element {
  String orientation = "vertical";

  void set_orientation(String orientation_) {
    orientation = orientation_;
  }

  Slider(float x_, float y_, float w_, float h_) {
    super(x_, y_, w_, h_);
  }

  void clicked(Data data_model, int index) {
    if (over() != null) {
      if (orientation.equals("horizontal")) {
        data_model.faders[index] = (over().x);
      } else {
        data_model.faders[index] = (1 - over().y); // inverted bc bottom is zero.
      }
      if (data_model.faders[index] < .01) {
        data_model.faders[index] = 0;
      }
    }
  }

  void render(float percent) {
    stroke(255);
    strokeWeight(2);
    noFill();
    rect(x, y, w, h, 5);
    fill(255);
    if (orientation.equals("horizontal")) {
      rect(x + (w-10) * percent, y, 10, h, 5);
    } else {
      rect(x, y + h - 10 - (h-10) * percent, w, 10, 5);
    }
  }
}

class Toggle extends Element {

  Toggle(float x_, float y_, float w_, float h_) {
    super(x_, y_, w_, h_);
  }
  
  void clicked(Data data_model, int index) {
    if (over() != null) {
      if (data_model.toggles[index] == 0.0) {
        data_model.toggles[index] = 1.0;
      } else {
        data_model.toggles[index] = 0.0;
      }
    }
  }

  void render(float value) {
    stroke(255);
    strokeWeight(2);
    noFill();
    rect(x, y, w, h, 5);
    if (value == 1.0) {
      fill(255);
      rect(x + 10, y + 10, w - 20, h - 20, 5);
    }
  }
}

class Compass extends Element {
  float ax = 0.0;
  float ay = 0.0;
  float aax = 0.0;
  float aay = 0.0;

  Compass(float x_, float y_, float w_, float h_) {
    super(x_, y_, w_, h_);
  }
  
  boolean editing = false;
  
  void pressed(Data data_model) {
    if (over() != null) {
      editing = true;
    } else {
      editing = false;
    }
    aax = data_model.acc[0];
    aay = data_model.acc[1];
    ax = mouseX;
    ay = mouseY;
  }
  
  void dragging(Data data_model) {
    if (editing) {
      float dx = mouseX - ax;
      float dy = mouseY - ay;
      data_model.acc[0] = aax + dx / 500;
      data_model.acc[1] = aay - dy / 500;
    }
  } 
    

  void render(float elem_w, float margin) {
    stroke(255);
    strokeWeight(2);
    fill(0);
    ellipseMode(CORNERS);
    ellipse(x, y, x + w, y + h);

    ortho(-width/2, width/2, -height/2, height/2);
    pushMatrix();
    translate(w/2+15, 2*elem_w+3*margin+1.5*w+14);
    rotateY(data.pitch);
    rotateX(data.roll);
    box(w/2, w/2, w/2);
    popMatrix();
    perspective();
  }
}
