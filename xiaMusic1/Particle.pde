class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float r;
  float velLim; //limit speed
  // float d;
  color c;
  ArrayList <Particle> particles;

  Particle(PVector l, float _r, float vx, float vy, float ax, float ay) {
    acceleration = new PVector(ax, ay); //new PVector(0, random(-0.05, 0.05));
    velocity = new PVector(vx, vy);
    location = l.get();
    r = _r;
    particles = new ArrayList<Particle>();

    lifespan = 255.0;
    velLim = 5.0;
    c = color(0, random(130)+125, 255);
  }

  void run() {
    //update();
    display();
    velocity.add(acceleration);
    location.add(velocity);
   lifespan -= 2.0;
  }

  // Method to update location
  void update() {
    float rlim = random(width/4, width/2);
    float dist =  PVector.dist(location, new PVector(mouseX, mouseY));
    if (dist > rlim) {
      velocity.x = velocity.x * -1;
      velocity.y = velocity.y * -1;
    }
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
  }


  /*
  void bounds (float x, float y, float br) { //bound's radius
   //for (int i=0; i<particles.size(); i++) {
   //  Particle p1 = (Particle)particles.get(i);
   float dist = PVector.dist(location, new PVector(x, y));
   //float boundX1 = x + br; ;
   //float boundX2 = x - br;
   //float boundY1 = y + br;
   //float boundY2 = y - br;
   //float posX = p.location.x ;
   //float posY = p.location.y ;


   if (dist > br) {//((posX > boundX1) || (posX < boundX2)) {
   p1.velocity.x = - p1.velocity.x;
   //}
   //if ((posY > boundY1) || (posY < boundY2)) {
   p1.velocity.y = - p1.velocity.y;
   update();
   } else {
   update();
   }
   }
   }
   */
  // Method to display
  void display() {
    stroke(0, lifespan);
    strokeWeight(0);
    fill(c, lifespan);
    ellipse(location.x, location.y, r, r);
  }


  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
