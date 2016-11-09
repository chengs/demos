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

class Population {
  float mutationRate;           // Mutation rate
  DNA[] population;             // Array to hold the current population
  ArrayList<DNA> matingPool;    // ArrayList which we will use for our "mating pool"
  String target;                // Target phrase
  int generations;              // Number of generations
  boolean finished;             // Are we finished evolving?
  int perfectScore;

  Population(String p, float m, int num) {
    target = p;
    mutationRate = m;
    population = new DNA[num];
    for (int i = 0; i < population.length; i++) {
      population[i] = new DNA(target.length());
    }
    calcFitness();
    matingPool = new ArrayList<DNA>();
    finished = false;
    generations = 0;

    perfectScore = 1;
  }

  void calcFitness() {
    for (int i = 0; i < population.length; i++) {
      population[i].fitness(target);
    }
  }

  // Generate a mating pool
  void naturalSelection() {
    matingPool.clear();

    float maxFitness = 0;
    for (int i = 0; i < population.length; i++) {
      if (population[i].fitness > maxFitness) {
        maxFitness = population[i].fitness;
      }
    }

    for (int i = 0; i < population.length; i++) {

      float fitness = map(population[i].fitness,0,maxFitness,0,1);
      int n = int(fitness * 100);  // Arbitrary multiplier, we can also use monte carlo method
      for (int j = 0; j < n; j++) {
        matingPool.add(population[i]);
      }
    }
  }

  // Create a new generation
  void generate() {
    for (int i = 0; i < population.length; i++) {
      int a = int(random(matingPool.size()));
      int b = int(random(matingPool.size()));
      DNA partnerA = matingPool.get(a);
      DNA partnerB = matingPool.get(b);
      DNA child = partnerA.crossover(partnerB);
      child.mutate(mutationRate);
      population[i] = child;
    }
    generations++;
  }

  // Compute the current "most fit" member of the population
  String getBest() {
    float worldrecord = 0.0;
    int index = 0;
    for (int i = 0; i < population.length; i++) {
      if (population[i].fitness > worldrecord) {
        index = i;
        worldrecord = population[i].fitness;
      }
    }

    if (worldrecord == perfectScore ) finished = true;
    return population[index].getPhrase();
  }

  boolean finished() {
    return finished;
  }

  int getGenerations() {
    return generations;
  }

  // Compute average fitness for the population
  float getAverageFitness() {
    float total = 0;
    for (int i = 0; i < population.length; i++) {
      total += population[i].fitness;
    }
    return total / (population.length);
  }

  String allPhrases() {
    String everything = "";

    int displayLimit = min(population.length,50);

    for (int i = 0; i < displayLimit; i++) {
      //everything += population[i].getPhrase()+"\n";
      everything += population[i].getPhrase()+" - " +population[i].fitness + "\n";
    }
    return everything;
  }
}

class DNA {
  // The genetic sequence
  char[] genes;

  float fitness;

  // makes a random DNA
  DNA(int num) {
    genes = new char[num];
    for (int i = 0; i < genes.length; i++) {
      genes[i] = (char) random(32,128);  // Pick from range of chars
    }
  }

  String getPhrase() {
    return new String(genes);
  }

  // Fitness function
  void fitness (String target) {
     int score = 0;
     for (int i = 0; i < genes.length; i++) {
        if (genes[i] == target.charAt(i)) {
          score++;
        }
     }

     fitness = (float)score / (float)target.length();
  }

  void squaredFitness(String target) {
    int score = 0;

    for(int i = 0; i < genes.length;i++) {
      if(genes[i] == target.charAt(i)) {
        score++;
      }
    }

    fitness = ((float)score * (float) score) / ((float)target.length() * (float) target.length());

  }

  void pow2Fitness(String target) {
    int score = 0;

    for(int i = 0; i < genes.length;i++) {
      if(genes[i] == target.charAt(i)) {
        score++;
      }
    }

    fitness = pow(2,(float) score) / pow(2,(float) target.length());

  }

  DNA crossover(DNA partner) {
    // A new child
    DNA child = new DNA(genes.length);

    int midpoint = int(random(genes.length));

    // Half from one, half from the other
    for (int i = 0; i < genes.length; i++) {
      if (i > midpoint) child.genes[i] = genes[i];
      else              child.genes[i] = partner.genes[i];
    }
    return child;
  }

  // Based on a mutation probability, picks a new random character
  void mutate(float mutationRate) {
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < mutationRate) {
        genes[i] = (char) random(32,128);
      }
    }
  }
}
