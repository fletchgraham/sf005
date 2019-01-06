import oscP5.*;
import netP5.*;

PShape mans; // the 3d model of mans.
Friend friend; // the way to draw mans in an interesting way.
Data data;

OscP5 oscP5;
NetAddress myRemoteLocation;
  
public void setup() {
  //fullScreen(P3D); // turn this off for debug probs.
  frameRate(24);
  size(1200,900,P3D);
  pixelDensity(displayDensity());
  data = new Data(); // where all the data is kept and updated.
  mans = loadShape("rocket.obj"); // load obj into mans.
  friend = new Friend(mans); // load mans into friend renderer.
  
  
  // osc stuff:
  oscP5 = new OscP5(this,8000);
  myRemoteLocation = new NetAddress("127.0.0.1",8000);
}

void oscEvent(OscMessage theOscMessage) {
  data.handle(theOscMessage);
  return; 
}

public void draw() {
  pushMatrix();
  background(0); // black background.
  translate(width/2, height/2 + 100, 400); // bring mans to center stage.
  rotateY(data.phoneX/2-PI/2); // around the up and down axis.
  rotateX(PI); // stand him upright.
  
  friend.render(); // draw mans as a friend.
  
  popMatrix(); // back to normal coordinates.
  
  //ui placeholder:
  strokeWeight(2);
  rect(10, 10, .3 * width, height-20);
}
