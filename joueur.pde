class Joueur {
    // variables
    float x; // déclare une variable correspondant à la position en x de l'objet 
    float y; // déclare une variable correspondant à la position en y de l'objet
    float xSpeed; // déclare une variable correpondant à la vitesse en x de l'objet
    float ySpeed; // déclare une variable correspondant à la vitesse en y de l'objet

    // constructor
    Joueur(float x, float y, float s) {
        // variables
        this.x = x; // correspond la valeur en x qu'on donne en appelant l'objet à celle de l'instence de l'objet
        this.y = y; // correspond la valeur en y qu'on donne en appelant l'objet à celle de l'instence de l'objet
        this.xSpeed = s; // donne la valeur de vitesse s qu'on donne en appelant l'objet à celle de l'instence de l'objet
        this.ySpeed = s; // donne la valeur de vitesse s qu'on donne en appelant l'objet à celle de l'instence de l'objet
    }

    // méthodes
    // // display
    void display() { // sert à déssiner le joueur
        // appel la méthode move
        this.move();
        
        // dessine le joueur
        fill(255);
        noStroke();
        circle(x, y, 20);
    }

    void move() { //sert à faire bouger le joueur

        // fait bouger le joueur
        if (keyPressed == true) {
            if (key == CODED) {
                if (keyCode == UP) { // fait bouger le joueur par en haut
                    if (y > height/5) {
                        y = y - ySpeed;
                    }
                    upKeyPressed = true;
                }
                if (keyCode == DOWN) { // fait bouger le joueur par en bas
                    if (y < height/5 * 4) {
                        y = y + ySpeed;
                    }
                    downKeyPressed = true;
                }
                if (keyCode == LEFT) { // fait bouger le joueur à gauche 
                    if (x > width/3) {
                        x = x - xSpeed;
                    }
                    leftKeyPressed = true;
                }
                if (keyCode == RIGHT) { // fait bouger le joueur à droite
                    if (x < width/3 * 2) {
                        x = x + xSpeed;
                    }
                    rightKeyPressed = true;
                }
            } 
        } else {
            upKeyPressed = false;
            downKeyPressed = false;
            leftKeyPressed = false;
            rightKeyPressed = false;
        }

        // intéragit avec le défilement
        if (y <= height/5) {
            pTop = true;
        } else {
            pTop = false;
        }

        if (y >= height/5 * 4) {
            pBot = true;
        } else {
            pBot = false;
        }
    }

    void interact() {
        /*
        ** si le joueur est proche dune technologie. un signal visuel et sonore? apparait
        ** calcul la disstance entre le joueur et les technologie
        ** sous une certaine distance le signal apparait
        */
    }
}
