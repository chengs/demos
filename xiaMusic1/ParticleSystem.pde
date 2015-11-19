class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  boolean isStart;
  boolean isFlower;
  
  float speed;
  float angle;
  float distance;

  ParticleSystem(PVector location, float r) {
    origin = location.get();   
    particles = new ArrayList<Particle>();
    isStart = false;
  }

  void addParticle(float x, float y, float r, float vx, float vy, float ax, float ay) { //float x, float y?
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
    for (int i = particles.size()-1; i >= 0; i--) {

      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}