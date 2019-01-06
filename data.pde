// class for dealing with data.

class Data {
  float phoneX = 0.0;
  float phoneY = 0.0;
  float phoneZ = 0.0;

  void handle(OscMessage last_osc) {
    last_osc.print();
    
    if (last_osc.addrPattern().equals("/accxyz")) {
      phoneX = last_osc.get(0).floatValue();
      phoneY = last_osc.get(1).floatValue();
      phoneZ = last_osc.get(2).floatValue();
    }
  }
}
