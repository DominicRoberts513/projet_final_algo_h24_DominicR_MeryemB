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
