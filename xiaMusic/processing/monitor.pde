HashMap users = new HashMap();

void setup( ) {
  size($('#touch').width(), $('#touch').height(), P2D);
  users = new HashMap();
}

void draw( ) {
  background(0);
  //iteration
  Iterator i = users.entrySet().iterator();  // Get an iterator
  ParticleSystem ps;
  while (i.hasNext()) {
    Map.Entry me = (Map.Entry)i.next();
    // print(me.getKey() + " is ");
    // println(me.getValue());
    ps = (ParticleSystem)me.getValue();
    if (ps){
      ps.addParticle();
      ps.updateMouse(ps.mseX,ps.mseY);
    }
  }
}

void initUser(String key, float x, float y) {
  ParticleSystem ps = users.get(key);
  if (!ps){
    ps = new ParticleSystem(new PVector(width/2, 50), 5);
  }
  ps.isOver = false;
  ps.updateMouse(x,y)
  users.put(key, ps);
}

void updateUser(String key, float x, float y) {
  ParticleSystem ps = users.get(key);
  if (ps){
    ps.updateMouse(x,y)
    users.put(key, ps);
  }
}

void delUser(String key, float x, float y) {
  ParticleSystem ps = users.get(key);
  if (ps) {
    ps.updateMouse(x,y)
    ps.isOver = true;
  }
  users.put(key, ps);
}
