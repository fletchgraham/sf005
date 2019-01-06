// class for dealing with data.

class Data {
  float phoneX = 0.0;
  float phoneY = 0.0;
  float phoneZ = 0.0;
  float fader1 = 0.0;
  float fader2 = 0.0;
  float fader3 = 0.0;
  float fader4 = 0.0;
  float fader5 = 0.0;
  float toggle1 = 0.0;
  float toggle2 = 0.0;
  float toggle3 = 0.0;
  float toggle4 = 0.0;
  
  void handle(OscMessage last_osc) {
    last_osc.print();
    String pat = last_osc.addrPattern();
    if (pat.equals("/accxyz")) {
      phoneX = last_osc.get(0).floatValue();
      phoneY = last_osc.get(1).floatValue();
      phoneZ = last_osc.get(2).floatValue();
    } else if (pat.contains("fader1")) {
      fader1 = last_osc.get(0).floatValue();
    } else if (pat.contains("fader2")) {
      fader2 = last_osc.get(0).floatValue();
    } else if (pat.contains("fader3")) {
      fader3 = last_osc.get(0).floatValue();
    } else if (pat.contains("fader4")) {
      fader4 = last_osc.get(0).floatValue();
    } else if (pat.contains("fader5")) {
      fader5 = last_osc.get(0).floatValue();
    } else if (pat.contains("toggle1")) {
      toggle1 = last_osc.get(0).floatValue();
    } else if (pat.contains("toggle2")) {
      toggle2 = last_osc.get(0).floatValue();
    } else if (pat.contains("toggle3")) {
      toggle3 = last_osc.get(0).floatValue();
    } else if (pat.contains("toggle4")) {
      toggle4 = last_osc.get(0).floatValue();
    }
  }
}
