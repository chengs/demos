class Flower {
  ArrayList<Particle> particles;
  PVector origin;
  boolean isStart;
  boolean isFlower;

  Flower(PVector location, float r) {
    origin = location.get();   
    particles = new ArrayList<Particle>();
    isFlower = false;
  }

  void addParticle(float x, float y, float r, float vx, float vy, float ax, float ay) {
    float r0 = random(1);
    if (r0 < 0.5) { 
      particles.add(new Particle (new PVector(x, y), r, vx, vy, ax, ay));//(origin, r, mass, grav));
    } else {
      particles.add(new Confetti (new PVector(x, y), r, vx, vy, ax, ay));//(origin, r, mass, grav));
    }
  }


  void update() {
    origin = new PVector(mouseX, mouseY);
  }

  void run() {
    for (int i=0; i<particles.size(); i++) {//(int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.display();
      p.update();

      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}