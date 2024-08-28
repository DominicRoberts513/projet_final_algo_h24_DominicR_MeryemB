/*
**
**  page dédié à rassembler les fonctions lousses du projet
**
*/

/*
** interaction avec les technologies
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
    mouseJustPressed = true;

    if (isGameOn != false) {
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
        
        //Si la souris est sur l'image de la télévision et que la souris est cliquée, faire jouer le son et la vidéo de fin
        if (tvs.isPointInHighResImage(mouseX, mouseY) && tvs.imageIndex == 10 && isWalkmanDone && isCdPlayerDone && isPagerDone && isPhoneDone && isRadioDone) {
            tvs.imageIndex = 11;
            sonTV3.play();
            fin();
        }

    } else {
        if (menuImgIndex == 0) {
            if (mouseX > width/2 - btnW/2 && mouseX < width/2 + btnW/2) {
                // play
                if (mouseY > height/2 - btnH/2 && mouseY < height/2 + btnH/2) {
                    menuImgIndex = 1;
                }

                // quit
                if (mouseY > ((height/3) * 2) - btnH/2 && mouseY < ((height/3) * 2) + btnH/2) {
                    exit(); // ferme l'application
                }
            }
        } else if (menuImgIndex == 1) {
            isGameOn = true;
        }
    }
}

void mouseReleased() {
  mouseJustPressed = false;
}

//fin
void fin() {
    isGameOn = false;
    menuImgIndex = 0;
    isCdPlayerDone = false;
    isPagerDone = false;
    isPhoneDone = false;
    isRadioDone = false;
    isWalkmanDone = false;
    isCDPickedUp = false;
    tvs.imageIndex = 0;
    // tout ce que tu a reset
}