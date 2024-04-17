// // variables // //
// général //
// couleurs //
// joueur //
float pX; // déclare une variable pour la position en x du joueur
float pY; // déclare une variable pour la position en y du joueur
float pS = 10; // déclare une variable pour la vitesse de déplacement du joueur

// objets //
Joueur joueur; // déclare l'objet joueur

// // fonctions // //
// set up //
void setup() {
    // général
    size(500, 500); // donne la grosseur à la fenêtre

    // joueur
    pX = width/2; // donne une valeur initial à la variable pX
    pY = height/8 * 7; // donne une valeur initial à la variable pY

    // objets
    // // joueur
    joueur = new Joueur(pX, pY, pS); // cré un instence de l'objet joueur

}

// draw // 
void draw() {
    // général
    background(0, 0, 0); // donne une couleur à l'arrière plan

    // joueur
    joueur.display(); // appel la méthode display de l'objet joueur
}

// // objet // //
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
        if (keyPressed == true) {
            if (key == CODED) {
                if (keyCode == UP) { // fait bouger le joueur par en haut
                    if (y > 0) {
                        y = y - ySpeed;
                    } 
                }
                if (keyCode == DOWN) { // fait bouger le joueur par en bas
                    if (y < height) {
                        y = y + ySpeed;
                    }
                }
                if (keyCode == LEFT) { // fait bouger le joueur à gauche 
                    if (x > 0) {
                        x = x - xSpeed;
                    }
                }
                if (keyCode == RIGHT) { // fait bouger le joueur à droite
                    if (x < width) {
                        x = x + xSpeed;
                    }
                }
            }
        }
    }
}
