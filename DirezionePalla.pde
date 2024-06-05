class DirezionePalla {
  Ball ball;
  Player player;
  boolean right;
  
  void dirp(Player player, Ball ball) {
    if (player.position.x > ball.position.x) {
      right = true;
    } else if (player.position.x < ball.position.x) {
      right = false;
    }
  }
}
