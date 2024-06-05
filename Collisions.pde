class Collisions {
  Player player1;
  Player2 player2;
  Ball ball;
  long lastHitTimePlayer1 = 0;
  long lastHitTimePlayer2 = 0;
  
  long player1InArea = 0;
  long player2InArea = 0;
  final long hitCooldown = 1000;
  final long scoreIncreaseTime = 600;

  boolean p1 = true;
  boolean p2 = false;
  boolean ctrl1 = false;
  boolean ctrl2 = false;
  
  Collisions(Player player1, Player2 player2, Ball ball) {
    this.player1 = player1;
    this.player2 = player2;
    this.ball = ball;
  }
  
  void update(Sound[] hitSounds, Sound point) {
    if (ball.position.y < 0 || ball.position.y > GAME_HEIGHT - ball.height) {
      ball.bouncey();
    } 
    
    if (ball.position.x < 0) {
      ball.bouncex();
    }
    
    if (ball.position.x > GAME_WIDTH - ball.width) {
      ball.bouncex();
    }
    
    if (checkCollision(ball, player1) && player1.isHit == true && System.currentTimeMillis() - lastHitTimePlayer1 >= hitCooldown) {
      ball.bouncey();
      int randomIndex = floor(random(hitSounds.length));
      hitSounds[randomIndex].play();
      lastHitTimePlayer1 = System.currentTimeMillis();
      p2 = true;
      p1 = false;
    }
    
    if (checkCollision(ball, player2) && player2.isHit == true && System.currentTimeMillis() - lastHitTimePlayer2 >= hitCooldown) {
      ball.bouncey();
      int randomIndex = floor(random(hitSounds.length));
      hitSounds[randomIndex].play();
      lastHitTimePlayer2 = System.currentTimeMillis();
      p1 = true;
      p2 = false;
    }
    
    if(checkCollision(ball, player1)){
      if(ctrl1 == false){
        player1InArea = System.currentTimeMillis();
        ctrl1 = true;
      }
    }
    
    if(checkCollision(ball, player2)){
      if(ctrl2 == false){
        player2InArea = System.currentTimeMillis();
        ctrl2 = true;
      }
    }
    
    if(checkCollision(ball, player1) == false){
        player1InArea = 0;
        ctrl1 = false;
    }
    
    if(checkCollision(ball, player2) == false){
        player2InArea = 0;
        ctrl2 = false;
    }
    if (checkCollision(ball, player1) && System.currentTimeMillis() - player1InArea >= scoreIncreaseTime) {
      player1.score++;
      point.play();
      ctrl1 = false;
      resetBall();
    }
    
    if (checkCollision(ball, player2) && System.currentTimeMillis() - player2InArea >= scoreIncreaseTime) {
      player2.score++;
      point.play();
      ctrl2 = false;
      resetBall();
    }
  }
  
  boolean checkCollision(Ball ball, Player player) {
    float distanceX = Math.abs(ball.position.x + ball.width / 2 - (player.playerX + player.width / 2));
    float distanceY = Math.abs(ball.position.y + ball.height / 2 - (player.playerY + player.height / 2));

    if (distanceX < (ball.width / 2 + player.width / 2) && distanceY < (ball.height / 2 + player.height / 2)) {
      return true;
    }
    return false;
  }
  
  
  boolean checkCollision(Ball ball, Player2 player) {
    float distanceX = Math.abs(ball.position.x + ball.width / 2 - (player.playerX + player.width / 2));
    float distanceY = Math.abs(ball.position.y + ball.height / 2 - (player.playerY + player.height / 2));

    if (distanceX < (ball.width / 2 + player.width / 2) && distanceY < (ball.height / 2 + player.height / 2)) {
      return true;
    }
    return false;
  }

  void resetBall() {
    ball.position.x = (GAME_WIDTH - ball.width) / 2;
    ball.position.y = (GAME_HEIGHT - ball.height) / 2;
  }
}
