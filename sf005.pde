import oscP5.*;
import netP5.*;

PShape mans; // the 3d model of mans.
Friend friend; // the way to draw mans in an interesting way.
Data data; // data manager.

OscP5 oscP5;
NetAddress myRemoteLocation;

HUD hud; // UI overlay thing

float time;
  
public void setup() {
  //fullScreen(P3D); // turn this off for debug probs.
  time = 0;
  frameRate(24);
  size(1920,1080,P3D);
  pixelDensity(displayDensity());
  data = new Data(); // where all the data is kept and updated.
  mans = loadShape("perturbed_man_sf.obj"); // load obj into mans.
  friend = new Friend(mans); // load mans into friend renderer.
  
  hud = new HUD(16, 16, 256); // position and width of the hud.
  
  // osc stuff:
  oscP5 = new OscP5(this,8000);
  myRemoteLocation = new NetAddress("127.0.0.1",8000);
}

void oscEvent(OscMessage theOscMessage) {
  data.handle(theOscMessage);
  return; 
}

public void draw() {
  // calculate roll and pitch:
  data.RP_calculate();
  
  // check for continuous user input happening:
  if (mousePressed == true) {
    hud.pressed(data);
  }
  
  pushMatrix(); // add default coords to stack.
  background(0); // black background.
  translate(width/2, height/2 + height/13, 600); // bring mans to center stage.
  rotateY(data.pitch); // around the up and down axis.
  rotateX(PI + data.roll);
  
  // render in different styles:
  friend.render1();
  friend.render2();
  friend.render3();
  friend.render4();
  
  popMatrix(); // back to normal coordinates.
  hud.render(); // draw UI elements:
  time += data.faders[4];
}

void mousePressed() {
  // click event as distinct from pressed:
  hud.clicked(data);
}
