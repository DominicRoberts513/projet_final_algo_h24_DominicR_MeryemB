/*
**
**  page dédié à rassembler les fonctions lousses du projet
**
*/


/*
** jardin
*/

/* 
** début code jardin v01

// pour faire apparaitre le jardin
void displayGarden() {
    int xOffset;
    int yOffset;

    // // bande de droite
    int indexDroit = 0;
    for (int y = jardinY; y < jardinLength; y += height/jardinYSubDiv) { // boucle en y
        for (int i = 0; i < planteQte; i++) {
            plantes[i].updateSize(i, y);
        }
        for ( int x = -width/5; x < width/3; x += (width/3)/jardinXSubDiv) { // boucle en x
            for (int i = 0; i < planteQte; i++) { // fait apparaitre plusieurs objet en mm temps
                // image index
                if (indexDroit < planteQte) {
                    indexDroit++;
                } else {
                    indexDroit = 0;
                }
                
                //println("i droit : " + i);

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

** fin code jardin v01
*/



/*
** interactionavec les technologies
*/

// touche espace //
void keyPressed() { 
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

void keyReleased() {
    if (key == ' ') { 
        for (Technologie tech : technologies) { 
            tech.spacePressed = false; 
        }
    }
}

// click de souris
void mousePressed() {
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
void movieEvent(Movie m) {
  m.read();
}

