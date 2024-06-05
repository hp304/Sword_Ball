import processing.sound.*;

class Player2 extends Sprite {
    PImage[] idleSprites;
    PImage[] movingSprites;
    PImage[] hitSprites;
    Sound swingsound;
    int currentFrameIndex;
    float playerX, playerY;
    boolean isHit = false;
    long lastHitTime = 0;
    long hitCooldown = 500;
    int currentFrameHit = 0;
    int hitFrames = 4;
    int frameRateHit = 20;
    int frameRateMoving = 30;
    int frameRateIdle = 10;
    int numFrames = 5;
    int idleFrames = 1;
    Key up;
    int score;
    Key down;
    Key left;
    Key right;

    Player2(int x, int y, int width, int height) {
        super(width, height);
        playerX = x;
        playerY = y;
        score = 1;
        up = new Key('w');
        down = new Key('s');
        left = new Key('a');
        right = new Key('d');

        idleSprites = new PImage[1];
        idleSprites[0] = loadImage(IDLEP2);

        hitSprites = new PImage[4];
        hitSprites[0] = loadImage(P2HIT0);
        hitSprites[1] = loadImage(P2HIT1);
        hitSprites[2] = loadImage(P2HIT2);
        hitSprites[3] = loadImage(P2HIT3);

        movingSprites = new PImage[5];
        movingSprites[0] = loadImage(RUN01);
        movingSprites[1] = loadImage(RUN11);
        movingSprites[2] = loadImage(RUN21);
        movingSprites[3] = loadImage(RUN31);
        movingSprites[4] = loadImage(RUN41);
    }

    void keyPressed(int key) {
        up.keyPressed(key);
        down.keyPressed(key);
        left.keyPressed(key);
        right.keyPressed(key);
    }

    void keyReleased(int key) {
        up.keyReleased(key);
        down.keyReleased(key);
        left.keyReleased(key);
        right.keyReleased(key);
    }

    void draw(Sound swingsound, Sound hitsound[]) {
        float speed = 5;
        float diagonalSpeed = speed / sqrt(2);

        float xMove = 0;
        float yMove = 0;

        if (up.pressed && playerY > -50 && isHit == false) {
            yMove -= speed;
            updateAnimation(frameRateMoving, numFrames);
        } else if (down.pressed && playerY < 125 && isHit == false) {
            yMove += speed;
            updateAnimation(frameRateMoving, numFrames);
        }

        if (left.pressed && playerX > -60 && isHit == false) {
            xMove -= speed;
            updateAnimation(frameRateMoving, numFrames);
        } else if (right.pressed && playerX < 380 && isHit == false) {
            xMove += speed;
            updateAnimation(frameRateMoving, numFrames);
        }

        if ((up.pressed && left.pressed && isHit == false && playerY > -50 && playerX > -60 && playerX < 380 && playerY < 125)) {
            xMove -= diagonalSpeed;
            yMove -= diagonalSpeed;
            updateAnimation(frameRateMoving, numFrames);
        } else if ((up.pressed && right.pressed && isHit == false && playerY > -50 && playerX > -60 && playerX < 380 && playerY < 125)) {
            xMove += diagonalSpeed;
            yMove -= diagonalSpeed;
            updateAnimation(frameRateMoving, numFrames);
        } else if ((down.pressed && left.pressed && isHit == false && playerY > -50 && playerX > -60 && playerX < 380 && playerY < 125)) {
            xMove -= diagonalSpeed;
            yMove += diagonalSpeed;
            updateAnimation(frameRateMoving, numFrames);
        } else if ((down.pressed && right.pressed && isHit == false && playerY > -50 && playerX > -60 && playerX < 380 && playerY < 125)) {
            xMove += diagonalSpeed;
            yMove += diagonalSpeed;
            updateAnimation(frameRateMoving, numFrames);
        }

        playerX += xMove;
        playerY += yMove;

        if (isHit) {
            updateAnimationHit(hitSprites, frameRateHit, hitFrames);
        }

        if (mousePressed && mouseButton == LEFT) {
            startHitAnimation(swingsound, hitSound);
        }

        if (!down.pressed && !up.pressed && !left.pressed && !right.pressed && isHit == false) {
            idleanimation();
        }
        if (!keyPressed && isHit == false) {
            idleanimation();
        }
        if (playerX < -59 && up.pressed == false && down.pressed == false && isHit == false) {
            idleanimation();
        }
        if (playerX > 379 && up.pressed == false && down.pressed == false && isHit == false) {
            idleanimation();
        }
        if (playerY < -49 && left.pressed == false && right.pressed == false && isHit == false) {
            idleanimation();
        }
        if (playerY > 125 && left.pressed == false && right.pressed == false && isHit == false) {
            idleanimation();
        }
        if (!keyPressed && isHit == false) {
            idleanimation();
        }
    }

    void startHitAnimation(Sound swingsound, Sound[] hitSounds) {
        boolean isInCertainSpot = (playerX > 200 && playerX < 387 && playerY > 236 && playerY < 336);

        long currentTime = millis();

        if (currentTime - lastHitTime >= hitCooldown) {
            currentFrameHit = 0;
            isHit = true;

            swingsound.play();
            if (isInCertainSpot) {
                int randomIndex = floor(random(hitSounds.length));
                hitSounds[randomIndex].play();
            }
            lastHitTime = currentTime;
        }
    }

    void updateAnimation(int frameRate, int totalFrames) {
        currentFrameIndex = frameCount % totalFrames;
        image(movingSprites[currentFrameIndex], playerX, playerY);
        frameRate(frameRate);
    }

    void updateAnimationHit(PImage[] sprites, int frameRate, int totalFrames) {
        image(sprites[currentFrameHit], playerX, playerY);

        if (frameCount % (int) (60 / frameRate) == 0) {
            currentFrameHit = (currentFrameHit + 1) % totalFrames;

            if (currentFrameHit == 0) {
                isHit = false;
            }
        }
    }

    void mousePressed() {
        if (mouseButton == LEFT) {
            currentFrameHit = 0;
            isHit = true;
        }
    }

    void idleanimation() {
        image(idleSprites[0], playerX, playerY);
    }
}
