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
int jardinLength; // déclare une variable pour storer la longueur du jardin
int jardinY; // déclare une variable pour enregistrer la coordonée y du jardin
int jardinYSubDiv = 5; // sous division en y du jardin
int jardinXSubDiv = 7; // sous division en x du jardin
int resizer = 100; // déclare une variable pour le redimensionnement des images
int resizerHighRes = 600; // déclare une variable pour le redimensionnement des images en haute résolution
int collisionRadius = 100; // Rayon de collision

// couleurs //
color noir = color(49, 1, 11);
color rouge = color(239, 60, 92);
color jaune = color(234, 234, 40);
color vert = color(34, 216, 100);
color vert_foncee = color(68, 123, 28);
color bleu = color(42, 135, 223);
color bleu_pale = color(236, 248, 252);
color blanc = color(255, 255, 255);

// sons //
// arriere plan
SoundFile sonArriere_01;
SoundFile sonArriere_02;
SoundFile sonArriere_03;

// technologies
SoundFile sonCd;
SoundFile sonPager;
SoundFile sonPhone;
SoundFile sonRadio;
SoundFile sonWalkman;

// q sonore
SoundFile sonInteraction;
SoundFile sonVictoire;
SoundFile sonEchec;

// ui //
// images
// // move
PImage[] upKey = new PImage[2]; 
PImage[] downKey = new PImage[2];
PImage[] leftKey = new PImage[2];
PImage[] rightKey = new PImage[2];

// // interact
PImage[] spaceKey = new PImage[2];
String interactionSourisUi = "Utilisez la souris pour intéragir avec la technologie!";

// objet
Ui ui;

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

// interaction
boolean spaceKeyPressed = false;

// défilement
boolean pTop = false;
boolean pBot = false;

// objet
Joueur joueur; // déclare l'objet joueur

// plantes //
// quantité
int planteQte = 4;
int planteOffset = 25;
int[] offsetValue = new int[planteQte];
int[] planteImageIndex = new int[7];

// position
int planteX; // déclare une variable pour la position en x de la plante
int planteY; // déclare une variable pour la position en y de la plante

// images
PImage[] plantesImage = new PImage[7]; // déclare une variable pour y storer une image

// technologies //

//position des technologies
int randomXCD, randomYCD;  // Pour le CD 
int randomX, randomY;  // Pour les autres technologies

// bool
boolean isCDPickedUp = false; // Vérifie si le CD est ramassé
boolean isTechZoom = false; // vérifie si la tech est zoom

// images
PImage[] cdPlayerImages; //idem
PImage[] pagerImages;
PImage[] phoneImages;
PImage[] radioImages;
PImage[] walkmanImages;
PImage[] tvsImages;


//images des technologies en high res pour l'affichage en gros des technologies
PImage[] cdPlayerImagesHighRes;
PImage[] pagerImagesHighRes;
PImage[] phoneImagesHighRes;    
PImage[] radioImagesHighRes;
PImage[] walkmanImagesHighRes;
PImage[] tvsImagesHighRes;

// objet
Plante[] plantes = new Plante[planteQte]; // déclare un tableau d'objet pour les plantes
Technologie[] technologies = new Technologie[6]; // déclare un tableau d'objet pour les technologies
Technologie walkman;  // Déclare une variable pour l'objet Walkman
Technologie pager;    // Idem
Technologie phone;
Technologie radio;
Technologie cdPlayer;
Technologie tvs;

// // // // // // // // // // fonctions // // // // // // // // // //

// set up //
void setup() {
    // général
    size(1000, 800); // donne la grosseur à la fenêtre

    // ui
    // // move
    // // // up
    for ( int i = 1; i <= upKey.length; i++) {
        upKey[i - 1] = loadImage ( "img/ui/up_0" + i + ".png");
        upKey[i - 1].resize(100, 100);
    }

    // // // down
    for ( int i = 1; i <= downKey.length; i++) {
        downKey[i - 1] = loadImage ( "img/ui/down_0" + i + ".png");
        downKey[i -1].resize(100, 100);
    }

    // // // left
    for ( int i = 1; i <= leftKey.length; i++) {
        leftKey[i - 1] = loadImage ( "img/ui/left_0" + i + ".png");
        leftKey[i - 1].resize(100, 100);
    }

    // // // right
    for ( int i = 1; i <= rightKey.length; i++) {
        rightKey[i - 1] = loadImage ( "img/ui/right_0" + i + ".png");
        rightKey[i - 1].resize(100, 100);
    }

    // // interact
    for ( int i = 1; i <= rightKey.length; i++) {
        spaceKey[i - 1] = loadImage ( "img/ui/space_0" + i + ".png");
        spaceKey[i - 1].resize(300, 100);
    }

    // // objet
    ui = new Ui();

    // jardin
    jardinLength = height * 2; // calcul la valeur pour la longueur du jardin
    jardinY = height - jardinLength; // calcul la valeur y du jardin

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
        plantesImage[i - 1].resize(resizer, resizer);
    }

    // // objets
    plantes = new Plante[planteQte]; // crée une quantité d'objet plante

    for (int i = 0; i < planteQte; i++) { // appel les constructors et remplie les tableau de valeurs
        planteImageIndex[i] = int(random(7));
        offsetValue[i] = int(random(planteOffset * -1, planteOffset));
        plantes[i] = new Plante(offsetValue[i]);
    }
    
    // music
    // // musique de fond
    sonArriere_01 = new SoundFile(this, "sons/bs_02.wav"); // charge le son dans la variable
    sonArriere_01.play(); // fait jouer le son
    sonArriere_01.loop(); // fait rejouer le son une fois que ce oson a terminer de jouer

    // // technologies
    sonCd = new SoundFile(this, "sons/cd_01.wav");
    sonPager = new SoundFile(this, "sons/pager_01.wav");
    sonPhone = new SoundFile(this, "sons/phone_01.wav");
    sonRadio = new SoundFile(this, "sons/radio_01.wav");
    sonWalkman = new SoundFile(this, "sons/walkman_01.wav");

    // // interaction
    sonVictoire = new SoundFile(this, "sons/victoire.wav");

    //technologies
    //images
    //Mettre les images dans des tableaux afin de choisir les images selon l'interaction
    cdPlayerImages = new PImage[5]; // Crée un tableau d'images pour le cdPlayer
    cdPlayerImagesHighRes = new PImage[5]; // Crée un tableau d'images pour le cdPlayer en haute résolution
    for (int i = 0; i < cdPlayerImages.length; i++) {
        cdPlayerImages[i] = loadImage("img/technologies/cdplayer/cdplayer-" + (i+1) + ".png"); // Charge les images dans le tableau d'images
        cdPlayerImages[i].resize(resizer, resizer); // Redimensionne les images

        cdPlayerImagesHighRes[i] = loadImage("img/technologies/cdplayer/cdplayer-" + (i+1) + ".png");
        cdPlayerImagesHighRes[i].resize(resizerHighRes, resizerHighRes); // Redimensionne les images en haute résolution
    }

    technologies[0] = new Technologie(cdPlayerImages, cdPlayerImagesHighRes, 0); // crée un objet technologie

    pagerImages = new PImage[6]; 
    pagerImagesHighRes = new PImage[6];
    for (int i = 0; i < pagerImages.length; i++) {
        pagerImages[i] = loadImage("img/technologies/pager/pager-" + (i+1) + ".png"); 
        pagerImages[i].resize(resizer, resizer);

        pagerImagesHighRes[i] = loadImage("img/technologies/pager/pager-" + (i+1) + ".png");
        pagerImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
    }

    technologies[1] = new Technologie(pagerImages, pagerImagesHighRes, 0);

    phoneImages = new PImage[13]; 
    phoneImagesHighRes = new PImage[13];
    for (int i = 0; i < phoneImages.length; i++) {
        phoneImages[i] = loadImage("img/technologies/phone/phone-" + (i+1) + ".png"); 
        phoneImages[i].resize(resizer, resizer);
        
        phoneImagesHighRes[i] = loadImage("img/technologies/phone/phone-" + (i+1) + ".png");
        phoneImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
    }

    technologies[2] = new Technologie(phoneImages, phoneImagesHighRes, 0);

    radioImages = new PImage[8]; 
    radioImagesHighRes = new PImage[8];
    for (int i = 0; i < radioImages.length; i++) {
        radioImages[i] = loadImage("img/technologies/radio/radio-" + (i+1) + ".png");
        radioImages[i].resize(resizer, resizer);

        radioImagesHighRes[i] = loadImage("img/technologies/radio/radio-" + (i+1) + ".png");
        radioImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
    }
    
    technologies[3] = new Technologie(radioImages, radioImagesHighRes, 0);

    walkmanImages = new PImage[2]; 
    walkmanImagesHighRes = new PImage[2];
    for (int i = 0; i < walkmanImages.length; i++) {
        walkmanImages[i] = loadImage("img/technologies/walkman/walkman-" + (i+1) + ".png");
        walkmanImages[i].resize(resizer, resizer);

        walkmanImagesHighRes[i] = loadImage("img/technologies/walkman/walkman-" + (i+1) + ".png");
        walkmanImagesHighRes[i].resize(resizerHighRes, resizerHighRes); 
    }

    technologies[4] = new Technologie(walkmanImages, walkmanImagesHighRes, 0); 

    tvsImages = new PImage[12]; 
    tvsImagesHighRes = new PImage[12];
    for (int i = 0; i < tvsImages.length; i++) {
        tvsImages[i] = loadImage("img/technologies/tvs/tvs-" + (i+1) + ".png"); 
        tvsImages[i].resize(resizer, resizer);

        tvsImagesHighRes[i] = loadImage("img/technologies/tvs/tvs-" + (i+1) + ".png");
        tvsImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
    }

    technologies[5] = new Technologie(tvsImages, tvsImagesHighRes, 0);

    walkman = technologies[4];  // Déclare l'objet Walkman
    pager = technologies[1];   // Idem
    phone = technologies[2];
    radio = technologies[3];
    cdPlayer = technologies[0];
    tvs = technologies[5];

    for (int i = 0; i < technologies.length - 1; i++) {  // Boucle pour les 5 premières technologies
        if (i != 5) { // Sauf pour la dernière technologie
            boolean isTooClose;

            do {
                isTooClose = false;

                // Générer une position aléatoire pour la technologie
                randomX = int(random(50, width - 50));
                randomY = int(random(jardinY, jardinY + jardinLength));

                // Calculer la distance entre la technologie et les autres technologies
                for (int j = 0; j < i; j++) {
                    float distance = dist(randomX, randomY, technologies[j].posX, technologies[j].posY);

                    if (distance < 500) {  // Si la distance est inférieure à 500 pixels
                        isTooClose = true;
                        break;
                    }
                } 
                
            } while (isTooClose); // Répéter la génération de position aléatoire jusqu'à ce que la technologie soit assez éloignée des autres

            // Mettre la position aléatoire à la technologie
            technologies[i].setPosition(randomX, randomY);
        }
    }
    
    boolean isCDTooClose; // Vérifier si le CD est trop proche des autres technologies
    do { 
        isCDTooClose = false; // Initialiser la variable à faux
    
        randomXCD = int(random(50, width - 50));
        randomYCD = int(random(jardinY, jardinY + jardinLength));
    
        // Vérifier la distance entre le CD et les autres technologies
        for (int i = 0; i < technologies.length - 1; i++) {
            float distance = dist(randomXCD, randomYCD, technologies[i].posX, technologies[i].posY);
            if (distance < 500) {  // Si la distance est inférieure à 500 pixels
                isCDTooClose = true;
                break;
            }
        }
    } while (isCDTooClose);

    // Met une position fixe pour la dernière technologie
    technologies[5].setPosition(width/2, (-jardinLength) + jardinLength/4 ); // MON IMAGE SE MET PAS A 500 EN X ET JCOMPREND PAS
      
}

// draw // 
void draw() {
    // général
    background(noir); // donne une couleur à l'arrière plan

    // jardin
    // // plantes
    displayGarden();

    // Afficher les technologies
    for (Technologie tech : technologies) {
        tech.display(joueur, tech.posX, tech.posY);
    }

    if (isCDPickedUp) {
        if (cdPlayer.techImages[4] != null) {
            image(cdPlayer.techImages[4], 0, 0); // Afficher le CD
        }
    } else {
        if (cdPlayer.techImages[4] != null) {
            image(cdPlayer.techImages[4], randomXCD, randomYCD + jardinY); // Afficher le CD
        }
    }

    // joueur
    joueur.display(); // appel la méthode display de l'objet joueur

    // ui
    ui.display();
}

// jardin //
// pour faire apparaitre le jardin
void displayGarden() {
    scrolling();

    int xOffset;
    int yOffset;

    // // bande de droite
    int indexDroit = 0;
    for (int y = jardinY; y < jardinLength; y += height/jardinYSubDiv) { // boucle en y
        for ( int x = -width/5; x < width/3; x += (width/3)/jardinXSubDiv) { // boucle en x
            for (int i = 0; i < planteQte; i++) { // fait apparaitre plusieurs objet en mm temps
                // image index
                if (indexDroit < planteQte) {
                    indexDroit++;
                } else {
                    indexDroit = 0;
                }
                
                // position
                xOffset = i * offsetValue[i];
                yOffset = i * offsetValue[i];
                plantes[i].updatePosition(x + xOffset, y + yOffset);
                
                // display
                plantes[i].display(planteImageIndex[indexDroit]); // appel la methode display des objets plantes
            }
        }
    }

    // // bande de gauche
    int indexGauche = 0;
    for (int y = jardinY; y < jardinLength; y += height/jardinYSubDiv) { // boucle en y;
        for ( int x = width/3 * 2; x < width + width/5; x += (width/3)/jardinXSubDiv) { // boucle en x
            for (int i = 0; i < planteQte; i++) { // fait apparaitre plusieurs objet en mm temps
                // image index
                if (indexGauche < planteQte) {
                    indexGauche++;
                } else {
                    indexGauche = 0;
                }
                
                // position
                xOffset = i * offsetValue[i];
                yOffset = i * offsetValue[i];
                plantes[i].updatePosition(x + xOffset, y + yOffset);
                
                // display
                plantes[i].display(planteImageIndex[indexGauche]); // appel la methode display des objets plantes
            }
        }
    }
}

// fait le défilement du jardin
void scrolling() {
    if (jardinY <= height/6 * 5) {
        
        if (pTop == true && upKeyPressed == true) { 
            jardinY = jardinY + int(pS);
            for (Technologie tech : technologies) {
                tech.move(0, int(pS)); // Bouge les technologies vers le bas
            }
        } 
    }
    if (jardinY >= height * -1.1) {
        if (pBot == true && downKeyPressed == true) {
            jardinY = jardinY - int(pS);
            for (Technologie tech : technologies) {
                tech.move(0, -int(pS)); // Bouge les technologies vers le haut
            }
        }
    }
}



void keyPressed() { 
    if (key == ' ') {  // Si la touche espace est pressée
        for (Technologie tech : technologies) { // Pour chaque technologie
            tech.spacePressed = true;  // Activer l'interaction
        }

        if (technologies[4].isCollidingWithPlayer(joueur, 1000)) { // Si le joueur est en collision avec le CD
            isCDPickedUp = true; // Ramasser le CD
        }
    }
}

void keyReleased() {
    if (key == ' ') { 
        for (Technologie tech : technologies) { 
            tech.spacePressed = false; 
        }
    }
}

void mousePressed() {
    println("Mouse pressed at: " + mouseX + ", " + mouseY);`

    if (walkman.isPointInHighResImage(mouseX, mouseY)) {
        walkman.imageIndex = 1;  // Change l'image du Walkman à la deuxième image 
        sonWalkman.play(); // Joue le son du Walkman
    }

    if (cdPlayer.isPointInHighResImage(mouseX, mouseY) && isCDPickedUp && cdPlayer.imageIndex != 3) { //Si le CD est ramassé et que l'image du Cdplayer n'est pas la 4e image et que la souris est sur l'image du Cdplayer
        cdPlayer.imageIndex += 1;  // Change l'image du Cdplayer à la prochaine image si le CD est ramassé
        if (cdPlayer.imageIndex == 1) {
            cdPlayer.techImages[4] = null; // Enlève l'image du CD
        }

        if(cdPlayer.imageIndex == 3) {
            sonCd.play(); // Joue le son du CD
        }
    }

    if (phone.isPointInHighResImage(mouseX, mouseY) && phone.imageIndex != 12) {
        phone.imageIndex += 1;  // Change l'image du Phone à la prochaine image
        if (phone.imageIndex == 12) {
            sonPhone.play(); // Joue le son du Phone
        }
    }

    if(radio.isPointInHighResImage(mouseX, mouseY) && radio.imageIndex != 7) {
        radio.imageIndex += 1;  // Change l'image de la Radio à la prochaine image
        if (radio.imageIndex == 7) {
            sonRadio.play(); // Joue le son de la Radio
        }
    }

    pager.isButtonClicked(mouseX, mouseY); // Vérifie si le bouton de la technologie Pager est cliqué
   
}
