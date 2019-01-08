// the ui overlay.

class HUD {
  Slider[] sliders = new Slider[5];
  float x;
  float y;
  float w;
  float margin = 16;
  float elem_w;
  // no height because elements are fixed height.
  
  Toggle toggle1;
  Toggle toggle2;
  Toggle toggle3;
  Toggle toggle4;
  
  Compass compass;
  
  HUD(float x_, float y_, float w_) {
    x = x_;
    y = y_;
    w = w_;
    elem_w = (w - 3 * margin) / 4;
    
    for (int i=0; i<4; i++) {  
      sliders[i] = new Slider(x + (elem_w + margin) * i, y + elem_w + margin, elem_w, w);
    }
    sliders[4] = new Slider(x, y, w, elem_w);
    sliders[4].set_orientation("horizontal");
    
    toggle1 = new Toggle(x, y + elem_w + margin * 2 + w, elem_w, 50);
    toggle2 = new Toggle(x + elem_w + margin, y + elem_w + margin * 2 + w, elem_w, 50);
    toggle3 = new Toggle(x + (elem_w + margin)*2, y + elem_w + margin * 2 + w, elem_w, 50);
    toggle4 = new Toggle(x + (elem_w + margin)*3, y + elem_w + margin * 2 + w, elem_w, 50);
    
    compass = new Compass(x, y + elem_w*2 + margin*3 + w, w, w);
  }
  
  void render() {
    for (int i=0; i<5; i++) {  
      sliders[i].render(data.fader[i]);
    }
    
    toggle1.render(data.toggle[0]);
    toggle2.render(data.toggle[1]);
    toggle3.render(data.toggle[2]);
    toggle4.render(data.toggle[3]);
    
    compass.render();
  }
}
