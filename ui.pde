class Ui {
    // position
    int moveKeyX;
    int moveKeyY;



    // constructor
    Ui() {
        this.moveKeyX = width/6 * 5;
        this.moveKeyY = height/6 * 5;
    }

    void display() {
        move();
        interact();
    }

    void move() {
        // up
        if (upKeyPressed == true) {
            image(upKey[1], moveKeyX, moveKeyY - width/12);
        } else {
            image(upKey[0], moveKeyX, moveKeyY - width/12);
        }

        // down
        if (downKeyPressed == true) {
            image(downKey[1], moveKeyX, moveKeyY);
        } else {
            image(downKey[0], moveKeyX, moveKeyY);
        }

        // left
        if (leftKeyPressed == true) {
            image(leftKey[1], moveKeyX - width/12, moveKeyY);
        } else {
            image(leftKey[0], moveKeyX - width/12, moveKeyY);
        }

        // right
        if (rightKeyPressed == true) {
            image(rightKey[1], moveKeyX + width/12, moveKeyY);
        } else {
            image(rightKey[0], moveKeyX + width/12, moveKeyY);
        }
    }

    void interact() {
        if (joueur.isTechClose == true) {
            if (spaceKeyPressed == true) {
                image(spaceKey[1], width/2 - 150, moveKeyY);
            }
            if (spaceKeyPressed == false) {
                image(spaceKey[0], width/2 - 150, moveKeyY);
            }
        }
    }
}