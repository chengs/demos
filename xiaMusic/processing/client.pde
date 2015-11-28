ParticleSystem ps;

void setup() {
  size($('#touch').width(), $('#touch').height(), P2D);
  ps = new ParticleSystem(new PVector(width/2, 50), 5);
  ps.isOver = true;
}

void draw() {
  // blendMode(ADD);
  background(0);
  if (ps) {
    ps.addParticle();
    // ps.updateOrigin();
    ps.updateMouse(ps.mseX,ps.mseY);
  }
}

void mousePressed(){
  ps.isOver = false;
  ps.updateMouse(mouseX, mouseY);
  sendEvent('down',{
    x:mouseX,
    y:mouseY
  })
}

void mouseDragged(){
  ps.updateMouse(mouseX, mouseY);
  sendEvent('move',{
    x:mouseX,
    y:mouseY
  })
}

void mouseReleased(){
  ps.updateMouse(mouseX, mouseY);
  ps.isOver = true;
  // ps = null;
  sendEvent('up',{
    x:mouseX,
    y:mouseY
  })
  sendEvents();
}
