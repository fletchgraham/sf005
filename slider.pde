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
        data_model.faders[index] = over().x;
      } else {
        data_model.faders[index] = 1 - over().y; // inverted bc bottom is zero.
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
  
  void pressed(Data data_model) {
    aax = data_model.acc[0];
    aay = data_model.acc[1];
    ax = mouseX;
    ay = mouseY;
  }
  
  void dragging(Data data_model) {
    float dx = mouseX - ax;
    float dy = mouseY - ay;
    data_model.acc[0] = aax + dx / 100;
    data_model.acc[1] = aay + dy / 100;
  } 
    

  void render() {
    stroke(255);
    strokeWeight(2);
    noFill();
    ellipseMode(CORNERS);
    ellipse(x, y, x + w, y + h);

    ortho(-width/2, width/2, -height/2, height/2);
    pushMatrix();
    translate(w/2+14, height/2+10);
    rotateY(data.acc[0]);
    rotateX(data.acc[1]);
    rotateZ(data.acc[2]);
    box(w/2, w/2, w/2);
    popMatrix();
    perspective();
  }
}
