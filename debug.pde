// the ui overlay.

class HUD {
  float x;
  float y;
  float w;
  float margin = 16;
  float elem_w;
  // no height because elements are fixed height.
  
  Slider slider5;
  Slider slider1;
  Slider slider2;
  Slider slider3;
  Slider slider4;
  
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
    
    slider5 = new Slider(x, y, w, elem_w);
    slider5.set_orientation("horizontal");
    slider1 = new Slider(x, y + elem_w + margin, elem_w, w);
    slider2 = new Slider(x + elem_w + margin, y + elem_w + margin, elem_w, w);
    slider3 = new Slider(x + (elem_w + margin) * 2, y + elem_w + margin, elem_w, w);
    slider4 = new Slider(x + (elem_w + margin) * 3, y + elem_w + margin, elem_w, w);
    
    toggle1 = new Toggle(x, y + elem_w + margin * 2 + w, elem_w, 50);
    toggle2 = new Toggle(x + elem_w + margin, y + elem_w + margin * 2 + w, elem_w, 50);
    toggle3 = new Toggle(x + (elem_w + margin)*2, y + elem_w + margin * 2 + w, elem_w, 50);
    toggle4 = new Toggle(x + (elem_w + margin)*3, y + elem_w + margin * 2 + w, elem_w, 50);
    
    compass = new Compass(x, y + elem_w*2 + margin*3 + w, w, w);
  }
  
  void render() {
    slider5.render(data.fader[4]);
    slider1.render(data.fader[0]);
    slider2.render(data.fader[1]);
    slider3.render(data.fader[2]);
    slider4.render(data.fader[3]);
    
    toggle1.render(data.toggle[0]);
    toggle2.render(data.toggle[1]);
    toggle3.render(data.toggle[2]);
    toggle4.render(data.toggle[3]);
    
    compass.render();
  }
}
