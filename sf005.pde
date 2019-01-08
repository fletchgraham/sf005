import oscP5.*;
import netP5.*;

PShape mans; // the 3d model of mans.
Friend friend; // the way to draw mans in an interesting way.
Data data;

OscP5 oscP5;
NetAddress myRemoteLocation;

// UI initialization:
HUD hud;
  
public void setup() {
  //fullScreen(P3D); // turn this off for debug probs.
  frameRate(24);
  size(1920,1080,P3D);
  pixelDensity(displayDensity());
  data = new Data(); // where all the data is kept and updated.
  mans = loadShape("rocket.obj"); // load obj into mans.
  friend = new Friend(mans); // load mans into friend renderer.
  
  // setup UI:
  hud = new HUD(16, 16, 256);
  
  // osc stuff:
  oscP5 = new OscP5(this,8000);
  myRemoteLocation = new NetAddress("127.0.0.1",8000);
}

void oscEvent(OscMessage theOscMessage) {
  data.handle(theOscMessage);
  return; 
}

public void draw() {
  pushMatrix(); // add default coords to stack.
  background(data.faders[4] * 255); // black background.
  translate(width/2, height/2 + 100, 600); // bring mans to center stage.
  rotateY(data.acc[0]-PI/2); // around the up and down axis.
  rotateX(PI); // stand him upright.
  
  friend.render(); // draw mans as a friend.
  
  popMatrix(); // back to normal coordinates.
  
  // draw UI elements:
  hud.render();
}

void mouseClicked() {
  if (hud.toggles[0].over() != null) {
    data.toggles[0] = 1.0;
  }
}
