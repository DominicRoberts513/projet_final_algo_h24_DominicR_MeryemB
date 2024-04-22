/*
**
** Travail_02
** par : Dominic & Meryem
** Présenté à Sofian Audry
** 
*/

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
// quantité
int planteQte = 5;

// position
int planteX; // déclare une variable pour la position en x de la plante
int planteY; // déclare une variable pour la position en y de la plante

// objet
Plante[] plantes = new Plante[planteQte]; // déclare un tableau d'objet pour les plantes

// son
SoundFile backgroundSon01;

// // fonctions // //
// set up //
void setup() {
    // général
    size(800, 800); // donne la grosseur à la fenêtre

    // joueur
    // // position
    pX = width/2; // donne une valeur initial à la variable pX
    pY = height/8 * 7; // donne une valeur initial à la variable pY

    // // objet
    joueur = new Joueur(pX, pY, pS); // cré un instence de l'objet joueurà

    // plantes
    // // images
    plantes = new Plante[planteQte];

    for (int i = 0; i < planteQte; i++) {
        int planteIndex = int(random(3));
        plantes[i] = new Plante(planteIndex);
    }
    
    backgroundSon01 = new SoundFile(this, "sons/chord_progression_loop.wav");
    backgroundSon01.play();
    backgroundSon01.loop();
}

// draw // 
void draw() {
    // général
    background(noir); // donne une couleur à l'arrière plan

    // joueur
    joueur.display(); // appel la méthode display de l'objet joueur
    
    // plantes
    for (int y = 0; y < height; y += height/planteQte) {
        println(y);
        for ( int x = 0; x < width; x += width/planteQte) {
            for (int i = 0; i < planteQte; i++) {
                plantes[i].display(x, y);
            }
        }
    }
    
    // for (int y = 0; y < height; y += plante_01.height) {
    // image(plante_01, 0, y); // Dessiner l'image sur le côté gauche de la fenêtre
    // }
    
    // for (int y = 0; y < height; y += plante_02.height) {
    // image(plante_02, width - plante_02.width, y); // Dessiner l'image sur le côté droit de la fenêtre
    // }
}
