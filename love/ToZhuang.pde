//2016.11.02 for my darling Zhuang's 28th Birthday
//Learnt from The Nature of Code - Genetic Algorithm
//Learnt from OpenProcessing - heart animation

PFont f, f2;
String target;
int popmax;
float mutationRate;
Population population;

void setup() {
  size(550, 800);
  f = createFont("Luminari", 32, true);//Herculanum
  f2 = createFont("Chalkduster", 32, true);
  target = "Happy Birthday, Zhuang!";
  //Baby, you can change the popmax and mutation rate ;D
  popmax = 200;                         
  mutationRate = 0.01;                   
  population = new Population(target, mutationRate, popmax);
}

void draw() {
  population.naturalSelection();
  population.generate();
  population.calcFitness();
  displayInfo();
  displaySwell();
  displayHeart();

  if (population.finished()) {
    println(millis()/1000.0);
    noLoop();
  }
}

void displayInfo() {
  background(#2C2C2C);
  // Say Happy birthday to my baby Zhuang!
  String answer = population.getBest();
  textFont(f);
  textAlign(CENTER);
  fill(#54E2FC);
  //stroke(20);
  textSize(70);
  text(answer, 72, 20, 400, 500);
}

void displayHeart() {
  translate(width/2, 540);
  for (float angle = -90; angle < 90; angle += 0.5) {
    for (float q = 1; q < 2; q += 0.2) {
      float a = q * 180;
      float t = angle + frameCount * 1.5+a;
      float c = map(q, 1, 2, 255, 135) ;
      float x = 14 * pow(sin(radians(t)), 3);
      float y = -12 * cos(radians(t)) + 5 * cos(radians(2 * t)) + 2 * cos(radians(3 * t)) + cos(radians(4*t));
      float s = cos(radians(angle)) * q * 7;
      fill(255, 100, c);
      noStroke();
      ellipse(x * q * 8, y * q * 8, s, s);
    }
  }
}

void displaySwell() {
  textFont(f2);
  textAlign(RIGHT);
  fill(#FCF512);
  stroke(20);
  textSize(20);
  String s1 = "From Swell";
  text(s1, 500, 730 );
  String s2 = "Nov 02 2016";
  text(s2, 500, 770);
}