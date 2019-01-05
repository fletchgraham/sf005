import oscP5.*;
import netP5.*;

PShape mans; // the 3d model of mans.
float ry; // for ambient spin.
Friend friend; // the way to draw mans in an interesting way.

OscP5 oscP5;
NetAddress myRemoteLocation;
  
public void setup() {
  //fullScreen(P3D);
  size(800,900,P3D);
  pixelDensity(displayDensity());
  mans = loadShape("rocket.obj"); // load obj into mans.
  friend = new Friend(mans); // load mans into friend.
  
  // osc stuff:
  oscP5 = new OscP5(this,8000);
  myRemoteLocation = new NetAddress("127.0.0.1",8000);
}

// rotations for mans:
float x = 0.0;
float y = 0.0;
float z = 0.0;

void oscEvent(OscMessage theOscMessage) {
  
  x = theOscMessage.get(0).floatValue() * PI;
  y = theOscMessage.get(1).floatValue() * PI;  
  z = theOscMessage.get(2).floatValue() * PI; 
  
  return;
  
}

public void draw() {
  background(0);
  
  translate(width/2, height/2 + 100, 400); // bring mans to center stage.
  rotateY(x/2-PI/2+ry); // ambient spin.
  rotateX(PI);
  friend.render(); // draw mans as a friend.
  
  //ry += 0.005; // increase ambient rotation for next draw.
}
