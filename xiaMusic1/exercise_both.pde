ParticleSystem ps;
Flower fs;

float speed;
float angle;
float distance;


void setup() {
  // size(800, 500, P2D);
  // size(800,500,P2D);
  size(screen.width, screen.height, P2D)
  ps = new ParticleSystem(new PVector(width/2, 50), 5);
  fs = new Flower(new PVector(width/2, 50), 5);
}

void draw() {
  // blendMode(ADD);
  background(0);

  if (fs.isFlower) {
    speed = random(0.01, 1);
    angle = random(360);
    distance = 0.005;
    fs.addParticle(mouseX, mouseY, 5, random(-0.01, 0.01), random(-0.01, 0.01), distance * cos(radians(angle)), distance * sin(radians(angle)));//random(-0.01, 0.01), random(-0.01, 0.01));
    fs.run();
    fs.update();
  }
  if (ps.isStart) {
    ps.addParticle(mouseX, mouseY, 5,random(-0.05, 0.05), random(-1, 1), random(-0.02, 0.04), random(0.02));//random(-0.01, 0.01));
    ps.run();
    ps.update();
  } else {
    ps.run();
    ps.update();
    fs.run();
    fs.update();
  }
}

void mousePressed() {
  fs = new Flower(new PVector(mouseX, mouseY), 0.1);
  fs.isFlower = true;
  ps.isStart = false;
}

void mouseReleased() {
  ps.isStart = false;
  fs.isFlower = false;
  ps = new ParticleSystem(new PVector(mouseX, mouseY), 0.2);
}

void mouseMoved() {
  fs.isFlower = false;
  ps.isStart = true;
}
