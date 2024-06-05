Sound hit;
Sound[] hitSound;
Sound swingsound;
Sound point;
PImage backgroundImage;
Ball ball;
Player player1;
Player2 player2;
Collisions collisions;
UI ui;

void settings() {
    size(GAME_WIDTH, GAME_HEIGHT);
    backgroundImage = loadImage(BACKGROUND);
}

void setup() {
    swingsound = new Sound(this, SWINGSOUND);
    point = new Sound(this, POINTSO);
  
    player1 = new Player ((GAME_WIDTH - 150) / 2, 600, 200, 200);
    player2 = new Player2((GAME_WIDTH - 150) / 2, 0, 100, 100);
  
    player1.up = new Key('w');
    player1.left = new Key('a');
    player1.down = new Key('s');
    player1.right = new Key('d');
    player1.space = new Key(' ');
  
    player2.up = new Key('i');
    player2.left = new Key('j');
    player2.down = new Key('k');
    player2.right = new Key('l');

    ball = new Ball(50, 50, hit);
    ball.speed = new PVector(4, 4);
    ball.position = new PVector((GAME_WIDTH - ball.width) / 2, (GAME_HEIGHT - ball.height) / 2); 
    collisions = new Collisions(player1, player2, ball);
  
    hitSound = new Sound[3];
  
    hitSound[0] = new Sound(this, HITSOUND1);
    hitSound[1] = new Sound(this, HITSOUND2);
    hitSound[2] = new Sound(this, HITSOUND3);
  
    ui = new UI(this);
}

void update() {
    ball.update(player1, player2, collisions);
    collisions.update(hitSound, point);
}

void draw() {
    background(backgroundImage);
    if (!ui.isGameStarted()) {
        ui.displayStartMenu();
    } else {
        update();
        ball.draw(collisions);
        player1.draw(swingsound, hitSound);
        player2.draw(swingsound, hitSound);
        ui.displayPoints(player1.score, player2.score);
    }
}

void keyPressed() {
    player1.keyPressed(key);
    player2.keyPressed(key);
}

void mousePressed() {
    if (!ui.isGameStarted() && mouseX >= width / 2 - 50 && mouseX <= width / 2 + 50 && mouseY >= height / 2 - 25 && mouseY <= height / 2 + 25) {
        ui.setGameStarted(true);
    }
}

void keyReleased() {
    player1.keyReleased(key);
    player2.keyReleased(key);
}
