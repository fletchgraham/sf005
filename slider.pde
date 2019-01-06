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
}

class Slider extends Element {
  String orientation = "vertical";
  
  void set_orientation(String orientation_) {
    orientation = orientation_;
  }
  
  Slider(float x_, float y_, float w_, float h_) {
    super(x_, y_, w_, h_);
  }
  
  void render(float percent) {
    stroke(255);
    strokeWeight(2);
    noFill();
    rect(x, y, w, h,5);
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
