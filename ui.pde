class Ui {
    // position
    int moveKeyX;
    int moveKeyY;
    int txtSz = 30;

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
        // barre d'espacement
        if (joueur.isTechClose == true || distanceToCD < 100 || (technologies[5].highResPosY > -100 && isWalkmanDone && isCdPlayerDone && isPagerDone && isPhoneDone && isRadioDone)) {
            if (spaceKeyPressed == true) {
                image(spaceKey[1], width/2 - 150, moveKeyY);
            }
            if (spaceKeyPressed == false) {
                image(spaceKey[0], width/2 - 150, moveKeyY);
            }
        }

        // texte
        for (Technologie tech : technologies) {
            if (tech.highResDisplayed && tech != technologies[5]) {
                textSize(txtSz);
                fill(blanc);
                textAlign(CENTER);
                text(interactionSourisUi, width/2, height/8);
            }
        }
    }

    void menuDisplay() {
        
        if (isGameOn != true) {
            // menu arriere plan
            image(menuBg[0], 0, 0);

            // bouton joué
            fill(blanc);
            rect((width/6 * 3) - (width/6)/2, height/5 * 2 ,width/6 , height/6);

            if (mouseX > (width/6 * 3) - (width/6)/2 && mouseX < ((width/6 * 3) - (width/6)/2) + (width/6)) {
                if (mouseY > height/5 * 2 && mouseY < (height/5 * 2) + (height/6)) {
                    println("survole");
                    if (mousePressed) {
                        println("click");
                    } 
                }
            }
        

            // bouton quitté
        }
    }
}