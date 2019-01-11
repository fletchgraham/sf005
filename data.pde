// class for dealing with data.

class Data {
  float[] acc = new float[3];
  float[] faders = new float[5];
  float[] toggles = new float[4];

  float roll = -0.01, pitch = -0.01; //Roll & Pitch are the angles which rotate by the axis X and y 
  int dampening = 10;
  float[] roll_history = new float[dampening];
  float[] pitch_history = new float[dampening];
  
  int idle_timer = 0;
  
  Data() {
    acc[0] = -.01;
    acc[1] = -.01;   
    acc[2] = -.08;   

  }

  void RP_calculate() {
    double x_Buff = (double) -acc[0];
    double y_Buff = (double) acc[1];
    double z_Buff = (double) -acc[2];
    float r = (float) (Math.atan2(y_Buff, z_Buff));
    float p = (float) (Math.atan2((- x_Buff), 
      sqrt((float)(y_Buff * y_Buff + z_Buff * z_Buff))));

    // pitch and roll history:
    for (int i = 0; i < dampening -1; i++) {
      roll_history[i] = roll_history[i+1];
      pitch_history[i] = pitch_history[i+1];
    }
    roll_history[dampening-1] = r;
    pitch_history[dampening-1] = p;

    float roll_sum = 0.0;
    float pitch_sum = 0.0;
    for (int i = 0; i < dampening; i++) {
      roll_sum += roll_history[i];
      pitch_sum += pitch_history[i];
    }
    roll = roll_sum / dampening;
    pitch = pitch_sum / dampening;
  }

  void handle(OscMessage last_osc) {
    idle_timer = 0;
    last_osc.print();
    String pat = last_osc.addrPattern();
    if (pat.equals("/accxyz")) {
      for (int i = 0; i < 3; i++) {
        acc[i] = last_osc.get(i).floatValue();
      }
    } else if (pat.contains("fader")) {
      int fader_index = Integer.parseInt(pat.substring(pat.length() - 1)) - 1;
      faders[fader_index] = last_osc.get(0).floatValue();
    } else if (pat.contains("toggle")) {
      int toggle_index = Integer.parseInt(pat.substring(pat.length() - 1)) - 1;
      toggles[toggle_index] = last_osc.get(0).floatValue();
    }
  }
}
