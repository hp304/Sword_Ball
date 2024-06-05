import processing.core.PApplet;
import processing.core.PFont;

public class UI {
    private PApplet parent;
    private PFont font;
    private boolean gameStarted;
    private PImage startButtonImage;

    UI(PApplet parent) {
        this.parent = parent;
        font = parent.createFont("Arial", 30);
        gameStarted = false;
        startButtonImage = parent.loadImage(STARTB);
    }

    void displayPoints(int player1Points, int player2Points) {
        parent.textFont(font);
        parent.textAlign(parent.LEFT, parent.CENTER);
        parent.fill(0);
        int lineHeight = 30;
        parent.text(player1Points, 20, parent.height / 2 - 100);
        parent.text(player2Points, 20, parent.height / 2 + 100);
    }

    void displayStartMenu() {
    int buttonWidth = 100;
    int buttonHeight = 100;
    parent.image(startButtonImage, parent.width / 2 - buttonWidth / 2, parent.height / 2 - buttonHeight / 2, buttonWidth, buttonHeight);
        parent.textFont(font);
        parent.textAlign(parent.CENTER, parent.CENTER);
        parent.fill(0);
        parent.textSize(30);
    }

    boolean isGameStarted() {
        return gameStarted;
    }

    void setGameStarted(boolean value) {
        gameStarted = value;
    }
}
