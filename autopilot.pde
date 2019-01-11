class AutoPilot {
  float[] acc_target = new float[3];
  int fader_index;
  float fader_target;
  int toggle_index;

  AutoPilot() {
    choose_new_fader();
    choose_new_rotation();
  }

  void choose_new_fader() {
    fader_index = int(random(5));
    fader_target = random(1);
  }

  void choose_new_rotation() {
    for (int i = 0; i < 2; i++) {
      acc_target[i] = random(-1, 1);
    }
  }

  void advance_fader() {
    // move toward the target
    float current = data.faders[fader_index];
    if (goal_reached(current, fader_target)) {
      choose_new_fader();
    } else {
      float direction = (fader_target - current) / abs(fader_target - current);
      data.faders[fader_index] += direction * .01;
    }
  }

  void advance_rotation() {
    for (int i = 0; i < 2; i++) {
      float current = data.acc[i];
      if (goal_reached(current, acc_target[i])) {
        choose_new_rotation();
      } else {
        float direction = (acc_target[i] - current) / abs(acc_target[i] - current);
        data.acc[i] += direction * .002;
      }
    }
  }

  void advance() {
    advance_fader();
    advance_rotation();
  }

  boolean goal_reached(float value, float target) {
    // check to see if a value is close enough to a target.
    float threshold = .01;
    if (value > target - threshold && value < target + threshold) {
      return true;
    } else {
      return false;
    }
  }
}
