class Sprite {
  PImage texture;
  int width;
  int height;
  PVector position;
  PVector speed;
  
  Sprite( int width, int height) {
    this.width = width;
    this.height = height; 
    position = new PVector();
    speed = new PVector();
  }

  boolean collide(Sprite sprite) {
    return sprite.position.x < position.x + width &&
           sprite.position.x > position.x - sprite.width &&
           sprite.position.y < position.y + height &&
           sprite.position.y > position.y - sprite.height;
  }
 
  void draw() {
    image(texture, position.x, position.y, width, height);  
  }
}
