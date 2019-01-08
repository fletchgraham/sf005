// class for dealing with data.

class Data {
  float[] acc = new float[3];
  float[] fader = new float[5];
  float[] toggle = new float[4];
  
  void handle(OscMessage last_osc) {
    last_osc.print();
    String pat = last_osc.addrPattern();
    if (pat.equals("/accxyz")) {
      for (int i = 0; i < 3; i++) {
        acc[i] = last_osc.get(i).floatValue();
      }
    } else if (pat.contains("fader")) {
      int fader_index = Integer.parseInt(pat.substring(pat.length() - 1)) - 1;
      fader[fader_index] = last_osc.get(0).floatValue();
    } else if (pat.contains("toggle")) {
      int toggle_index = Integer.parseInt(pat.substring(pat.length() - 1)) - 1;
      toggle[toggle_index] = last_osc.get(0).floatValue();
    }
  }
}
