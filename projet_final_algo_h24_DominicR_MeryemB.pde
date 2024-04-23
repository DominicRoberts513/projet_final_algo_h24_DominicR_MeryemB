/*
**
** Travail_02
** par : Dominic & Meryem
** Présenté à Sofian Audry
** 
*/

// // librairie // //
// sound //
import processing.sound.*;

// // variables // //
// général //
int jardinLenght; // déclare une variable pour storer la longueur du jardin
int jardinY; // déclare une variable pour enregistrer la coordonée y du jardin
int jardinYSubDiv = 8; // sous division en y du jardin
int jardinXSubDiv = 7; // sous division en x du jardin

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

// défilement
boolean pTop = false;
boolean pBot = false;

// objet
Joueur joueur; // déclare l'objet joueur

// plantes //
// quantité
int planteQte = 5;
int planteOffset = 100;

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

    // jardin
    jardinLenght = height * 2; // calcul la valeur pour la longueur du jardin
    jardinY = height - jardinLenght; // calcul la valeur y du jardin

    // joueur
    // // position
    pX = width/2; // donne une valeur initial à la variable pX
    pY = height/4 * 3; // donne une valeur initial à la variable pY

    // // objet
    joueur = new Joueur(pX, pY, pS); // cré un instence de l'objet joueurà

    // plantes
    // // images
    plantes = new Plante[planteQte];

    for (int i = 0; i < planteQte; i++) {
        int planteIndex = int(random(3));
        plantes[i] = new Plante(planteIndex, planteOffset);
    }
    
    // music
    // // musique de fond
    backgroundSon01 = new SoundFile(this, "sons/main_bs_02.wav"); // charge le son dans la variable
    backgroundSon01.play(); // fait jouer le son
    backgroundSon01.loop(); // fait rejouer le son une fois que ce oson a terminer de jouer
}

// draw // 
void draw() {
    // général
    background(noir); // donne une couleur à l'arrière plan

    // joueur
    joueur.display(); // appel la méthode display de l'objet joueur
    
    // plantes
    // // défilement

    
    if (pTop == true) {
        if (jardinY != -height) {
            jardinY = jardinY + int(pS);
        }
    }

    if (pBot == true) {
        if (jardinY != -height) {
            jardinY = jardinY - int(pS);
        }
    }

    // // bande de droite
    for (int y = jardinY; y < jardinLenght; y += height/jardinYSubDiv) { // boucle en y
        for ( int x = 0; x < width/3; x += (width/3)/jardinXSubDiv) { // boucle en x
            for (int i = 0; i < planteQte; i++) { // fait apparaitre plusieurs objet en mm temps
                plantes[i].display(x, y); // appel la methode display des objets plantes
            }
        }
    }

    // // bande de gauche
    for (int y = jardinY; y < jardinLenght; y += height/jardinYSubDiv) { // boucle en y
        for ( int x = width/3 * 2; x < width; x += (width/3)/jardinXSubDiv) { // boucle en x
            for (int i = 0; i < planteQte; i++) { // fait apparaitre plusieurs objet en mm temps
                plantes[i].display(x, y); // appel la methode display des objets plantes
            }
        }
    }
}
