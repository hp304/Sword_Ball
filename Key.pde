class Key {
  int key;
  boolean pressed;

  Key(int key) {
    this.key = key;
    pressed = false;
  }
    
  void keyPressed(int key) {
    if (this.key == key) {
      pressed = true;  
    }
  }
  
  void keyReleased(int key) {
    if (this.key == key) {
      pressed = false;  
    }
  } 
}
