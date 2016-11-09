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