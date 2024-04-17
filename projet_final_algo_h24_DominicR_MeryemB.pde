import processing.sound.*;

// // variables // //
// général //

// couleurs //
color noir = color(49, 1, 11);
color rouge = color(239, 60, 92);
color jaune = color(234, 234, 40);
color vert = color(34, 216, 100);
color vert_foncee = color(68, 123, 28);
color bleu = color(42, 135, 223);
color bleu_pale = color(236, 248, 252);

// joueur //
// position
float pX; // déclare une variable pour la position en x du joueur
float pY; // déclare une variable pour la position en y du joueur
float pS = 5; // déclare une variable pour la vitesse de déplacement du joueur

// objet
Joueur joueur; // déclare l'objet joueur

// plantes //
// position
int planteX; // déclare une variable pour la position en x de la plante
int planteY; // déclare une variable pour la position en y de la plante

// image
PImage plante_01; // déclare une variable pour y storer une image
PImage plante_02; // déclare une variable pour y storer une image
PImage plante_03; // déclare une variable pour y storer une image

// objet
Plante[] plantes; // déclare un tableau d'objet pour les plantes

// son
SoundFile test;

// // fonctions // //
// set up //
void setup() {
    // général
    size(500, 500); // donne la grosseur à la fenêtre

    // joueur
    // // position
    pX = width/2; // donne une valeur initial à la variable pX
    pY = height/8 * 7; // donne une valeur initial à la variable pY

    // // objet
    joueur = new Joueur(pX, pY, pS); // cré un instence de l'objet joueurà

    // plantes
    // // images
    plante_01 = loadImage("img/plantes/plante_01.png"); // charge l'image plante_01 dans la variable éponyme
    plante_02 = loadImage("img/plantes/plante_02.png"); // charge l'image plante_02 dans la variable éponyme
    plante_03 = loadImage("img/plantes/plante_03.png"); // charge l'image plante_03 dans la variable éponyme

    test = new SoundFile(this, "sons/chord_progression_loop.wav");
    test.play();
    test.loop();
}

// draw // 
void draw() {
    // général
    background(0, 0, 0); // donne une couleur à l'arrière plan

    // joueur
    joueur.display(); // appel la méthode display de l'objet joueur
}
