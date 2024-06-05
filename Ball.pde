class Ball extends Sprite {
  Sound hit;
  DirezionePalla dir;
  Collisions collisions; 
  PImage idleball;
  PImage idleball2;
  float speedMultiplier = 4;
  PVector speed; 

  Ball(int width, int height, Sound hit) {
    super(width, height);
    this.hit = hit;
    idleball = loadImage(BALL1);
    idleball2 = loadImage(BALL2);
    dir = new DirezionePalla(); 
    speed = new PVector(0.01, 0.5);
  }
  void bouncex() {
    speed.x = -speed.x;
  }
  void bouncey() {
    speed.y = -speed.y;
  }
  void update(Player player, Player2 player2, Collisions coll) {
    position.y += speed.y;
    if (dir != null && coll.p1 == true ) {
      float directionX = player.playerX - position.x;
      float directionY = player.playerY - position.y;
      
      float magnitude = sqrt(directionX * directionX + directionY * directionY);
      directionX /= magnitude;
      directionY /= magnitude;
      
      position.x += directionX * speedMultiplier;
      position.y += directionY * speedMultiplier;
    }
    
    if (dir != null && coll.p2 == true ) {
      float directionX = player2.playerX - position.x;
      float directionY = player2.playerY - position.y;
      
      float magnitude = sqrt(directionX * directionX + directionY * directionY);
      directionX /= magnitude;
      directionY /= magnitude;
      
      position.x += directionX * speedMultiplier;
      position.y += directionY * speedMultiplier;
    }
  }
  void draw(Collisions coll) {
    if (coll.p1 == true) {
      image(idleball, this.position.x, this.position.y, width, height);
    } else {
      image(idleball2, this.position.x, this.position.y, width, height);
    }
  }
}
