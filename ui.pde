class Ui {
    // position
    int moveKeyX;
    int moveKeyY;
    int txtSz = 64;

    // constructor
    Ui() { 
        this.moveKeyX = width/6 * 5;
        this.moveKeyY = height/6 * 5;
    }

    void display() { // sert à faire apparaitre le
        move();
        interact();
    }

    void move() { // gere les touche de déplacement
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

    void interact() { // gere la barre despacement pour l'interaction
        if (joueur.isTechClose == true) {
            if (spaceKeyPressed == true) {
                image(spaceKey[1], width/2 - 150, moveKeyY);
            }
            if (spaceKeyPressed == false) {
                image(spaceKey[0], width/2 - 150, moveKeyY);
            }
        }

        if (isTechZoom == true) {
            textSize(txtSz);
            fill(blanc);
            textAlign(CENTER);
            text(interactionSouris, width/2, height/8);
        }
    }
}