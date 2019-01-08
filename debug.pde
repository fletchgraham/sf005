// the ui overlay.

class HUD {
  float x;
  float y;
  float w;
  float margin = 16;
  float elem_w;
  // no height because elements are fixed height.
  
  // initialize arrays of the kinds of elements contained in the hud:
  Slider[] sliders = new Slider[5];
  Toggle[] toggles = new Toggle[4];
  Compass compass;
  
  // constructor:
  HUD(float x_, float y_, float w_) {
    x = x_;
    y = y_;
    w = w_;
    elem_w = (w - 3 * margin) / 4;
    
    // four vertical sliders:
    for (int i=0; i<4; i++) {  
      sliders[i] = new Slider(x + (elem_w + margin) * i, y + elem_w + margin, elem_w, w);
    }
    
    // top horizontal slider:
    sliders[4] = new Slider(x, y, w, elem_w);
    sliders[4].set_orientation("horizontal");
    
    // four toggles:
    for (int i=0; i<4; i++) {
      toggles[i] = new Toggle(x + (elem_w + margin)*i, y + elem_w + margin * 2 + w, elem_w, 50);
    }
  
    // accelerometer representation:
    compass = new Compass(x, y + elem_w*2 + margin*3 + w, w, w);
  }
  
  void pressed(Data data_model) {
    for (int i=0; i<5; i++) {
      sliders[i].clicked(data_model, i);
    }
  }
  
  void clicked(Data data_model) {
    for (int i=0; i<4; i++) {
      toggles[i].clicked(data_model, i);
    }
  }
  void render() {
    // render all of the elements:
    for (int i=0; i<5; i++) {  
      sliders[i].render(data.faders[i]);
    }  
    for (int i=0; i<4; i++) {  
      toggles[i].render(data.toggles[i]);
    }
    compass.render();
  }
}
