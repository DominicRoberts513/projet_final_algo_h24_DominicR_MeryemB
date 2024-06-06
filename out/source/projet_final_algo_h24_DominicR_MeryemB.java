/* autogenerated by Processing revision 1293 on 2024-06-06 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import processing.sound.*;
import processing.video.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class projet_final_algo_h24_DominicR_MeryemB extends PApplet {

/*
**
** Travail_02
** par : Dominic & Meryem
** Présenté à Sofian Audry
** 
*/

// // librairie // //
// sound //



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
int noir = color(49, 1, 11);
int rouge = color(239, 60, 92);
int jaune = color(234, 234, 40);
int vert = color(34, 216, 100);
int vert_foncee = color(68, 123, 28);
int bleu = color(37, 89, 161);
int bleu_pale = color(236, 248, 252);
int blanc = color(255, 255, 255);

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
SoundFile sonVictoire;
SoundFile sonClicInteraction;
boolean isSonVictoire = false;

//son de la fin du jeu
SoundFile sonTV1;
SoundFile sonTV2;
SoundFile sonTV3;

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

// // menu
PImage menuBg[] = new PImage[2];
PImage playBtn[] = new PImage[2];
PImage quitBtn[] = new PImage[2]; 

// // bool
boolean isGameOn = true; // pour détecter si le jeu est en mode menu ou jeu

// objet
Ui ui;

// joueur //
// position
float pX; // déclare une variable pour la position en x du joueur
float pY; // déclare une variable pour la position en y du joueur
float pS = 10; // déclare une variable pour la vitesse de déplacement du joueur

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

//variables pour les technologies
int tvsLastChange = 0; // Dernier changement d'image
int tvsChangeInterval = 1000; // Intervalle de temps pour changer l'image
boolean isCdPlayerDone = false; // Vérifie si le CdPlayer est terminé
boolean isPagerDone = false; // Vérifie si le Pager est terminé
boolean isPhoneDone = false; // Vérifie si le Phone est terminé
boolean isRadioDone = false; // Vérifie si la Radio est terminée
boolean isWalkmanDone = false; // Vérifie si le Walkman est terminé


// bool
boolean isCDPickedUp = false; // Vérifie si le CD est ramassé
boolean isTechZoom = false; // vérifie si la tech est zoom
float distanceToCD; // Distance entre le joueur et le CD

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

//vidéo de fin
Movie theEnd;
boolean isVideoStarted = false;

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
public void setup() {
    // général
    /* size commented out by preprocessor */; // donne la grosseur à la fenêtre
    sonClicInteraction = new SoundFile(this, "sons/clic_interaction.wav");

    // menu image
    for ( int i = 1; i <= menuBg.length; i++) {
        menuBg[i - 1] = loadImage( "img/ui/menu_0" + i + ".png");
    }

    // ui
    // // objet
    ui = new Ui();

    if (isGameOn == true) {
        // ui
        // // move
        // // // up
        for ( int i = 1; i <= upKey.length; i++) {
            upKey[i - 1] = loadImage ( "img/ui/up_0" + i + ".png");
            upKey[i - 1].resize(resizer, resizer);
        }

        // // // down
        for ( int i = 1; i <= downKey.length; i++) {
            downKey[i - 1] = loadImage ( "img/ui/down_0" + i + ".png");
            downKey[i - 1].resize(resizer, resizer);
        }

        // // // left
        for ( int i = 1; i <= leftKey.length; i++) {
            leftKey[i - 1] = loadImage ( "img/ui/left_0" + i + ".png");
            leftKey[i - 1].resize(resizer, resizer);
        }

        // // // right
        for ( int i = 1; i <= rightKey.length; i++) {
            rightKey[i - 1] = loadImage ( "img/ui/right_0" + i + ".png");
            rightKey[i - 1].resize(resizer, resizer);
        }

        // // interact
        for ( int i = 1; i <= rightKey.length; i++) {
            spaceKey[i - 1] = loadImage ( "img/ui/space_0" + i + ".png");
            spaceKey[i - 1].resize(resizer * 3, resizer);
        }

        // ui
        

        // jardin
        jardinLength = height * 2; // calcul la valeur pour la longueur du jardin
        jardinY = height - jardinLength; // calcul la valeur y du jardin

        // joueur
        // // position
        pX = width/2; // donne une valeur initial à la variable pX
        pY = height/4 * 3; // donne une valeur initial à la variable pY

        // // objet
        joueur = new Joueur(pX, pY, pS); // crée un instence de l'objet joueur

        // plantes
        // // images
        for (int i = 1; i <= plantesImage.length; i++) {
            plantesImage[i - 1] = loadImage ( "img/plantes/plante-0" + i + ".png" ); // charge les images dans le tableau d'images
            plantesImage[i - 1].resize(resizer, resizer);
        }

        // // objets
        plantes = new Plante[planteQte]; // crée une quantité d'objet plante

        for (int i = 0; i < planteQte; i++) { // appel les constructors et remplie les tableau de valeurs
            planteImageIndex[i] = PApplet.parseInt(random(7));
            offsetValue[i] = PApplet.parseInt(random(planteOffset * -1, planteOffset));
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
        sonTV1 = new SoundFile(this, "sons/tv_fin_01.wav");
        sonTV2 = new SoundFile(this, "sons/tv_fin_02.wav");
        sonTV3 = new SoundFile(this, "sons/tv_fin_03.wav");

        // // interaction
        sonVictoire = new SoundFile(this, "sons/bs_fin.wav");
        
        
        //fin
        theEnd = new Movie(this, "algo_t2_credits.mp4"); 

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
                    randomX = PApplet.parseInt(random(50, width - 50));
                    randomY = PApplet.parseInt(random(jardinY, jardinY + jardinLength));

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
        
            if (random(1) < 0.5f) { // 50% de chance de choisir le tiers gauche de l'écran
                randomXCD = PApplet.parseInt(random(100, width / 3 - 100));
            } else { // 50% de chance de choisir le tiers droit de l'écran
                randomXCD = PApplet.parseInt(random(2 * width / 3 + 50, width - 100));
            }

            randomYCD = PApplet.parseInt(random(jardinY, jardinY + jardinLength));
        
            // Vérifier la distance entre le CD et les autres technologies
            for (int i = 0; i < technologies.length - 1; i++) {
                float distance = dist(randomXCD, randomYCD, technologies[i].posX, technologies[i].posY);
                if (distance < 500) {  // Si la distance est inférieure à 500 pixels
                    isCDTooClose = true;
                    break;
                }
            }
        } while (isCDTooClose);
    }
    
    

}

// draw // 
public void draw() {

    if (isGameOn == true) {
        // général
        background(noir);

        // jardin
        // // plantes
        displayGarden();
        fill(bleu);
        rect(technologies[5].highResPosX - width, technologies[5].highResPosY, width*2, height/1.88f);

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
                image(cdPlayer.techImages[4], randomXCD, randomYCD); // Afficher le CD
            }
        }

        if(isWalkmanDone && isCdPlayerDone && isPagerDone && isPhoneDone && isRadioDone && !isSonVictoire) {
            sonArriere_01.stop();
            sonVictoire.play();
            isSonVictoire = true;
        }

        if (technologies[5].highResPosY > -100 && technologies[5].imageIndex >= 1 && isWalkmanDone && isCdPlayerDone && isPagerDone && isPhoneDone && isRadioDone) {
            //Si assez de temps est passé, changer l'image de la télévision 
                if (millis() - tvsLastChange >= tvsChangeInterval && tvs.imageIndex < 9) {
                    // Changer l'image de la télévision et réinitialiser le temps
                    tvs.imageIndex += 1;
                    tvsLastChange = millis();
                } else if(millis() - tvsLastChange >= tvsChangeInterval * 5 && tvs.imageIndex == 9) {
                    tvs.imageIndex = 10;
                    sonTV2.play();
                } 
        }
        distanceToCD = dist(joueur.x, joueur.y, randomXCD, randomYCD);
        
        // joueur
        joueur.display(); // appel la méthode display de l'objet joueur
    
        // ui
        ui.display();

    
        image(theEnd, 0, 0);
    } else {
        image(menuBg[0], 0, 0);
        if (mousePressed == true) {
            sonClicInteraction.play(); // Joue le son de l'interaction
        }
    }

    
}

// jardin //
// pour faire apparaitre le jardin
public void displayGarden() {
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
public void scrolling() {
    if (jardinY <= height/6 * 5) {
        
        if (pTop == true && upKeyPressed == true) { 
            jardinY = jardinY + PApplet.parseInt(pS);
            randomYCD += PApplet.parseInt(pS);
            for (Technologie tech : technologies) {
                tech.move(0, PApplet.parseInt(pS)); // Bouge les technologies vers le bas
            }
        } 
    }
    if (jardinY >= height * -1.1f) {
        if (pBot == true && downKeyPressed == true) {
            jardinY = jardinY - PApplet.parseInt(pS);
            randomYCD -= PApplet.parseInt(pS);
            for (Technologie tech : technologies) {
                tech.move(0, -PApplet.parseInt(pS)); // Bouge les technologies vers le haut
            }
        }
    }
}



public void keyPressed() { 
    if (key == ' ') {  // Si la touche espace est pressée
        for (Technologie tech : technologies) { // Pour chaque technologie
            tech.spacePressed = true;  // Activer l'interaction
        }

        
        if (distanceToCD < 100) { // Si le joueur est en collision avec le CD
            isCDPickedUp = true; // Ramasser le CD
        }
        
        if(technologies[5].highResPosY > -100 && isWalkmanDone && isCdPlayerDone && isPagerDone && isPhoneDone && isRadioDone) {
            sonTV1.play();
            tvs.imageIndex = 1;
            sonVictoire.stop();
        }
    }  
}

public void keyReleased() {
    if (key == ' ') { 
        for (Technologie tech : technologies) { 
            tech.spacePressed = false; 
        }
    }
}

public void mousePressed() {
    sonClicInteraction.play(); // Joue le son de l'interaction

    if (walkman.isPointInHighResImage(mouseX, mouseY)) {
        walkman.imageIndex = 1;  // Change l'image du Walkman à la deuxième image 
        sonWalkman.play(); // Joue le son du Walkman
        isWalkmanDone = true; // Le Walkman est terminé
    }

    if (cdPlayer.isPointInHighResImage(mouseX, mouseY) && isCDPickedUp && cdPlayer.imageIndex != 3) { //Si le CD est ramassé et que l'image du Cdplayer n'est pas la 4e image et que la souris est sur l'image du Cdplayer
        cdPlayer.imageIndex += 1;  // Change l'image du Cdplayer à la prochaine image si le CD est ramassé
        if (cdPlayer.imageIndex == 1) {
            cdPlayer.techImages[4] = null; // Enlève l'image du CD
        }

        if(cdPlayer.imageIndex == 3) {
            sonCd.play(); // Joue le son du CD
            isCdPlayerDone = true; // Le CdPlayer est terminé
        }
    }

    if (phone.isPointInHighResImage(mouseX, mouseY) && phone.imageIndex != 12) {
        phone.imageIndex += 1;  // Change l'image du Phone à la prochaine image
        if (phone.imageIndex == 12) {
            isPhoneDone = true; // Le Phone est terminé
            sonPhone.play(); // Joue le son du Phone
        }
    }


    pager.isButtonClicked(mouseX, mouseY); // Vérifie si le bouton de la technologie Pager est cliqué
    radio.isRadioClicked(mouseX, mouseY);
    
    //Si la souris est sur l'image de la télévision et que la souris est cliquée, faire jouer le son et la vidéo de fin
    if (tvs.isPointInHighResImage(mouseX, mouseY) && tvs.imageIndex == 10 && isWalkmanDone && isCdPlayerDone && isPagerDone && isPhoneDone && isRadioDone) {
        tvs.imageIndex = 11;
        sonTV3.play();
        theEnd.play();
    }
}

//Faire jouer la vidéo
public void movieEvent(Movie m) {
  m.read();
}
class Joueur {
    // variables
    float x; // déclare une variable correspondant à la position en x de l'objet 
    float y; // déclare une variable correspondant à la position en y de l'objet
    float xSpeed; // déclare une variable correpondant à la vitesse en x de l'objet
    float ySpeed; // déclare une variable correspondant à la vitesse en y de l'objet
    float radius = 20; // déclare une variable correspondant au rayon du joueur
    
    // interaction
    boolean isTechClose = false; // devioent true quand une tech est a moins de 200px
    float distTechJoueur;

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
    public void display() { // sert à déssiner le joueur
        // appel la méthode move
        this.move();
        
        // appel lamethode interact
        this.interact();

        // dessine le joueur
        fill(255);
        noStroke();
        circle(x, y, radius);
    }

    public void move() { //sert à faire bouger le joueur

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
                   // if (x > width/3) { //mis en commentaire pour tester les technologies
                        x = x - xSpeed;
                   // }
                    leftKeyPressed = true;
                }
                if (keyCode == RIGHT) { // fait bouger le joueur à droite
                    //if (x < width/3 * 2) { //idem
                        x = x + xSpeed;
                    //}
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

    public void interact() {
        /*
        ** si le joueur est proche dune technologie. un signal visuel et sonore? apparait
            -- jai mis un zoom mais un signal sonore serait cool 
            -- coeur
        ** calcul la disstance entre le joueur et les technologie
        ** sous une certaine distance le signal apparait
        */

        
        for( int i = 1; i <= technologies.length; i++) { // boucle sur tout les technologies
            distTechJoueur = dist(x, y, technologies[i - 1].posX, technologies[i - 1].posY); // calcul la distance entre les technologies
            if (distTechJoueur < 80) { // si le joueur est a moins de 200px
                isTechClose = true; // 
                if (keyPressed == true) {
                    if (key == ' ') {
                        spaceKeyPressed = true;
                    }
                    
                } else {
                    spaceKeyPressed = false;
                }
                //println(spaceKeyPressed);
            } else {
                isTechClose = false;
            }
            if(isTechClose == true) {
                break;
            }
        }
    }
}
class Plante {
    int posX;
    int posY;
    int offset;
    


    Plante( int offsetValue) {
        this.offset = offsetValue;
    }

    public void display(int i) {
        image(plantesImage[i], posX, posY);
    }

    public int posOffset(int a) {    
        a = a + offset;
        
        return a;
    }

    // update la position de la plante avec un offset
    public void updatePosition(int x, int y) {
        posX = posOffset(x);

        posY = posOffset(y);
    }
}
class Technologie {
    int posX;
    int posY;
    int highResPosX;
    float highResPosY;
    PImage[] techImages;
    PImage[] highResTechImages; 
    int imageIndex;
    boolean spacePressed = false; // true si la touche espace est pressée
    boolean spaceWasPressed = false; // true si la touche espace était pressée
    boolean highResDisplayed = false; // true si l'image haute résolution est affichée
    Button[] buttonsPager = { // boutons pour le pager
        new Button(335, 456, 75, 75, 1), // position x, position y, largeur, hauteur, ordre du bouton
        new Button(439, 458, 75, 75, 2),
        new Button(532, 456, 75, 75, 3),
        new Button(639, 467, 75, 75, 4)
    };
    int[] buttonOrderPager = {3, 4, 4, 2, 1, 3, 4, 2, 3, 1, 2}; // ordre des boutons pour le pager
    int currentOrderPagerIndex = 0; // index de l'ordre actuel
    Button[] buttonsRadio = { // boutons pour le pager
        new Button(467, 455, 15, 15, 0), // position x, position y, largeur, hauteur, ordre du bouton
        new Button(499, 455, 15, 15, 1),
        new Button(522, 455, 15, 15, 2),
        new Button(545, 455, 15, 15, 3),
        new Button(576, 455, 15, 15, 4),
        new Button(610, 455, 15, 15, 5),
        new Button(638, 455, 15, 15, 6)
    };

    Technologie(PImage[] techImages, PImage[] highResTechImages, int imageIndex) { // constructeur de la classe Technologie
        this.techImages = techImages; // images des technologies
        this.highResTechImages = highResTechImages; // high-resolution images
        this.imageIndex = imageIndex; // index de l'image de la technologie
    }
    

    public void setPosition(int x, int y) { // définit la position de la technologie
        if (imageIndex != 5 && (x < width/3 || x > 2*width/3)) { // Seulement si la nouvelle position n'est pas dans le tiers du milieu
            this.posX = x; // position de la technologie
        } else if (imageIndex == 5) {
            this.posX = x;
        }
        this.posY = y; 
    }

    public void move(int dx, int dy) { // déplace la technologie
        int newX = this.posX + dx;
        if (newX < width/3 || newX > 2*width/3) { // seulement si la nouvelle position n'est pas dans le tiers du milieu
            this.posX = newX; // position de la technologie
        } 
        this.posY += dy;
    }

    public void display(Joueur joueur, int posX, int posY) {
        // Calcul de la largeur et de la hauteur de l'image haute résolution
        int newWidth = highResTechImages[imageIndex].width;
        int newHeight = highResTechImages[imageIndex].height;
    
        // Calcul de la position de l'image haute résolution
        highResPosX = width / 2 - newWidth / 2;
        highResPosY = height / 2 - newHeight / 2;
    
        // If this is the fifth technology, always display the high-resolution image
        if (this == technologies[5]) {
            highResDisplayed = true;
            highResPosX = width/5;
            highResPosY = this.posY + (-jardinLength) + jardinLength/12.5f;
        }
    
        // Si la touche espace est pressée et qu'elle n'était pas pressée au frame précédent
        if (spacePressed && !spaceWasPressed && this != technologies[5]) {
            // Si le joueur est en collision avec la technologie actuelle et que l'image haute résolution n'est pas déjà affichée
            if (isCollidingWithPlayer(joueur, collisionRadius) || highResDisplayed) {
                // Active l'affichage de l'image haute résolution
                highResDisplayed = !highResDisplayed;
            }
        }
    
        if (highResDisplayed) {
            // Affiche l'image haute résolution au centre de l'écran
            image(highResTechImages[imageIndex], highResPosX, highResPosY, newWidth, newHeight);
        } else {
            // Si l'image haute résolution n'est pas affichée, affiche l'image normale à la position de la technologie
            image(techImages[imageIndex], posX, posY);
        }
    
        // Mis à jour de l'état de la touche espace
        spaceWasPressed = spacePressed;
    }

    public boolean isCollidingWithPlayer(Joueur joueur, int collisionRadius) { // vérifie si le joueur est en collision avec la technologie
        float techCenterX = this.posX + techImages[imageIndex].width / 2; // centre de la technologie
        float techCenterY = this.posY + techImages[imageIndex].height / 2;
        return dist(techCenterX, techCenterY, joueur.x, joueur.y) <= collisionRadius; // distance entre le centre de la technologie et le joueur
    }

    public boolean isPointInHighResImage(int x, int y) { // vérifie si la souris est dans l'image haute résolution
        if (!highResDisplayed) { // si l'image haute résolution n'est pas affichée
            return false; // retourne faux
        }

        int newWidth = highResTechImages[imageIndex].width; // largeur de l'image haute résolution
        int newHeight = highResTechImages[imageIndex].height; // hauteur de l'image haute résolution
        int highResPosX = width / 2 - newWidth / 2; // position x    de l'image haute résolution
        int highResPosY = height / 2 - newHeight / 2; // position y de l'image haute résolution

        return x >= highResPosX && x <= highResPosX + newWidth && y >= highResPosY && y <= highResPosY + newHeight; // retourne vrai si la souris est dans l'image haute résolution
    }

    public boolean isButtonClicked(int x, int y) { // vérifie si un bouton est cliqué
        if (currentOrderPagerIndex == buttonOrderPager.length) { // Si l'ordre complet a été complété
            return false; // fait rien
        }
    
        for (Button button : buttonsPager) { 
            if (button.isMouseInside(x, y)) { // si le point est à l'intérieur du bouton
                if (button.order == buttonOrderPager[currentOrderPagerIndex]) { // si l'ordre du bouton est correct
                    currentOrderPagerIndex++; // incrémente l'index de l'ordre
                    if (currentOrderPagerIndex == buttonOrderPager.length) { // Si l'ordre complet a été complété
                        imageIndex = 5; // Change à l'image de la technologie finale
                        isPagerDone = true; // Le pager est terminé
                        sonPager.play(); // Joue le son du pager
                    } else {
                        imageIndex = button.order; // Change à l'image du boutton cliqué
                    }
                } else {
                    currentOrderPagerIndex = 0; // Reset l'ordre
                    imageIndex = 0; // Reset l'image
                }
                return true;
            }
        }
        return false;
    }
    
    public boolean isRadioClicked(int x, int y) { // vérifie si un bouton est cliqué
        for (Button button : buttonsRadio) { 
            if (button.isMouseInside(x, y)) { // si le point est à l'intérieur du bouton
                if (button.order == 5) {
                    imageIndex = 7;
                    sonRadio.play();
                    isRadioDone = true;
                    return true;
                }

                imageIndex = button.order; // Change à l'image du boutton cliqué
                println(button.order);
                println(imageIndex);
                return true;
            }
        }
        return false;
    }
}

class Button { // classe pour les boutons
    int x, y, width, height, order; // position x, position y, largeur, hauteur, ordre du bouton

    Button(int x, int y, int width, int height, int order) { // constructeur de la classe Button
        this.x = x; // position x du bouton
        this.y = y; // position y du bouton
        this.width = width; // largeur du bouton
        this.height = height; // hauteur du bouton
        this.order = order; // ordre du bouton
    }

    public boolean isMouseInside(int px, int py) { // vérifie si la souris est à l'intérieur du bouton
        return px >= x - width / 2 && px <= x + width / 2 && py >= y - height / 2 && py <= y + height / 2; // retourne vrai si le point est à l'intérieur du bouton
    }
}
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

    public void display() { // sert à faire apparaitre le
        move();
        interact();
    }

    public void move() { // gere les touche de déplacement
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

    public void interact() { // gere la barre despacement pour l'interaction
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

    public void menu() {
        
    }
}


  public void settings() { size(1000, 800); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "projet_final_algo_h24_DominicR_MeryemB" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
