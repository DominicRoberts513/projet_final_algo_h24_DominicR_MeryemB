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

// mouvement
boolean upKeyPressed = false;
boolean downKeyPressed = false;
boolean leftKeyPressed = false;
boolean rightKeyPressed = false;

// défilement
boolean pTop = false;
boolean pBot = false;

// objet
Joueur joueur; // déclare l'objet joueur

// plantes //
// quantité
int planteQte = 5;
int planteOffset = 100;
int offsetValue;

// position
int planteX; // déclare une variable pour la position en x de la plante
int planteY; // déclare une variable pour la position en y de la plante

// images
PImage[] plantesImage = new PImage[7]; // déclare une variable pour y storer une image
PImage[] cdPlayerImages; //idem
PImage[] pagerImages;
PImage[] phoneImages;
PImage[] radioImages;
PImage[] walkmanImages;
PImage[] tvsImages;



// objet
Plante[] plantes = new Plante[planteQte]; // déclare un tableau d'objet pour les plantes
Technologie[] technologies = new Technologie[6]; // déclare un tableau d'objet pour les technologies

// son
SoundFile backgroundSon01;

// // fonctions // //
// set up //
void setup() {
    // général
    size(1000, 800); // donne la grosseur à la fenêtre

    // jardin
    jardinLenght = height * 2; // calcul la valeur pour la longueur du jardin
    jardinY = height - jardinLenght; // calcul la valeur y du jardin

    // joueur
    // // position
    pX = width/2; // donne une valeur initial à la variable pX
    pY = height/4 * 3; // donne une valeur initial à la variable pY

    // // objet
    joueur = new Joueur(pX, pY, pS); // cré un instence de l'objet joueur

    // plantes
    // // images
    for (int i = 1; i <= plantesImage.length; i++) {
        plantesImage[i - 1] = loadImage ( "img/plantes/plante-0" + i + ".png" ); // charge les images dans le tableau d'images
        plantesImage[i - 1].resize(50, 75);
    }

    // // objets
    plantes = new Plante[planteQte]; // crée une quantité d'objet plante

    for (int i = 0; i < planteQte; i++) { // appel les constructors
        int planteIndex = int(random(7));
        offsetValue = int(random(planteOffset * -1, planteOffset));
        plantes[i] = new Plante(planteIndex, offsetValue);
    }
    
    // music
    // // musique de fond
    backgroundSon01 = new SoundFile(this, "sons/main_bs_02.wav"); // charge le son dans la variable
    backgroundSon01.play(); // fait jouer le son
    backgroundSon01.loop(); // fait rejouer le son une fois que ce oson a terminer de jouer

    //technologies
    //images
    //Mettre les images dans des tableaux afin de choisir les images selon l'interaction
    cdPlayerImages = new PImage[5]; 
    for (int i = 0; i < cdPlayerImages.length; i++) {
        cdPlayerImages[i] = loadImage("img/technologies/cdplayer/cdplayer-" + (i+1) + ".png"); 
        cdPlayerImages[i].resize(100, 100);
    }

    technologies[0] = new Technologie(cdPlayerImages, 0); // crée un objet technologie

    pagerImages = new PImage[6]; 
    for (int i = 0; i < pagerImages.length; i++) {
        pagerImages[i] = loadImage("img/technologies/pager/pager-" + (i+1) + ".png"); 
        pagerImages[i].resize(100, 100);
    }

    technologies[1] = new Technologie(pagerImages, 0);

    phoneImages = new PImage[13]; 
    for (int i = 0; i < phoneImages.length; i++) {
        phoneImages[i] = loadImage("img/technologies/phone/phone-" + (i+1) + ".png"); 
        phoneImages[i].resize(100, 100);
    }

    technologies[2] = new Technologie(phoneImages, 0);

    radioImages = new PImage[8]; 
    for (int i = 0; i < radioImages.length; i++) {
        radioImages[i] = loadImage("img/technologies/radio/radio-" + (i+1) + ".png");
        radioImages[i].resize(100, 100);
    }
    
    technologies[3] = new Technologie(radioImages, 0);

    walkmanImages = new PImage[2]; 
    for (int i = 0; i < walkmanImages.length; i++) {
        walkmanImages[i] = loadImage("img/technologies/walkman/walkman-" + (i+1) + ".png");
        walkmanImages[i].resize(100, 100); 
    }

    technologies[4] = new Technologie(walkmanImages, 0); 

    tvsImages = new PImage[12]; 
    for (int i = 0; i < tvsImages.length; i++) {
        tvsImages[i] = loadImage("img/technologies/tvs/tvs-" + (i+1) + ".png"); 
        tvsImages[i].resize(100, 100);
    }

    technologies[5] = new Technologie(tvsImages, 0);

    for (int i = 0; i < technologies.length; i++) {  //TEST : affiche les technologies
        technologies[i].setPosition(50 + i * 100, 50);
    }
}

// draw // 
void draw() {
    // général
    background(noir); // donne une couleur à l'arrière plan

    // joueur
    joueur.display(); // appel la méthode display de l'objet joueur
    
    // plantes
    displayGarden();

    for (Technologie tech : technologies) {
        tech.display(); // appel la méthode display de l'objet technologie
    }
}

void displayGarden() {
    scrolling();

    // // bande de droite
    for (int y = jardinY; y < jardinLenght; y += height/jardinYSubDiv) { // boucle en y
        for ( int x = 0; x < width/3; x += (width/3)/jardinXSubDiv) { // boucle en x
            for (int i = 0; i < planteQte; i++) { // fait apparaitre plusieurs objet en mm temps
                plantes[i].updatePosition(x, y);
                plantes[i].display(); // appel la methode display des objets plantes
            }
        }
    }

    // // bande de gauche
    for (int y = jardinY; y < jardinLenght; y += height/jardinYSubDiv) { // boucle en y
        for ( int x = width/3 * 2; x < width; x += (width/3)/jardinXSubDiv) { // boucle en x
            for (int i = 0; i < planteQte; i++) { // fait apparaitre plusieurs objet en mm temps
                plantes[i].updatePosition(x, y);
                plantes[i].display(); // appel la methode display des objets plantes
            }
        }
    }
}

void scrolling() {
    if (jardinY >= height) {
     // rien ne ce passe...........   
    } else {
        if (pTop == true && upKeyPressed == true) {
            jardinY = jardinY + int(pS);
        }
        if (pBot == true && downKeyPressed == true) {
            jardinY = jardinY - int(pS);
        }
    }
}
