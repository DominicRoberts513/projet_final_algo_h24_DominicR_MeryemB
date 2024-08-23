class Jardin {
    Jardin() {
        layoutMatrix();
    }

    void display() {
        scrolling();
        // montagne
        for (int j = 0; j < jardinYSubDiv; j++) {
            if (j == jardinYSubDiv/3) {
                displayMtn(0, jardinLength/3 + jardinY);                    
                displayMtn(width - mtnW, jardinLength/3 + jardinY);
            } else if (j == (jardinYSubDiv/3) * 2) {
                displayMtn(0, ((jardinLength/3) * 2) + jardinY);
                displayMtn(width - mtnW, ((jardinLength/3) * 2) + jardinY);
            }
        }

        // boucles
        for (int k = 0; k < jardinXSubDiv; k++) {
            for (int j = 0; j < jardinYSubDiv; j++) {
                

                // plantes
                // // masking
                // // // limite au sommet de la montagne
                if (jardinPosYMatrix[k][j] + jardinY >= jardinY) {
                    // // // limites pour le chemin
                    if (jardinPosXMatrix[k][j] <= width/3 || jardinPosXMatrix[k][j] >= ((width/3)*2)) {
                        // // // limites pour les falaises de la montagnes
                        if (jardinPosYMatrix[k][j] + jardinY >= jardinLength/3 + jardinY && jardinPosYMatrix[k][j] + jardinY <= jardinLength/3 + mtnH + jardinY) {
                        // fait rien  
                        } else if (jardinPosYMatrix[k][j] + jardinY >= ((jardinLength/3) * 2) + jardinY && jardinPosYMatrix[k][j] + jardinY <= ((jardinLength/3) * 2) + mtnH + jardinY) {
                        // allo
                        } else {
                            // affichage des plants
                            plantes.updateSize(jardinImgMatrix[k][j], 0);
                            plantes.display(jardinImgMatrix[k][j], jardinPosXMatrix[k][j], jardinPosYMatrix[k][j] + jardinY); // appel la methode display des objets plantes

                            // jardin debug ui
                            if (jardinDebugUi == true) {
                                textSize(25);
                                fill(blanc);
                                text("(" + k + ", " + j + ", " + jardinImgMatrix[k][j] + " )", jardinPosXMatrix[k][j], jardinPosYMatrix[k][j] + jardinY);
                        
                                text("(" + jardinPosXMatrix[k][j] + ", " + jardinPosYMatrix[k][j] + " )", jardinPosXMatrix[k][j], jardinPosYMatrix[k][j] + jardinY + 25);
                            }
                        }
                        
                        
                    }
                }
            }
        }
    }

    // fait le défilement du jardin
    void scrolling() {
        if (jardinY <= height/6 * 5) {
            
            if (pTop == true && upKeyPressed == true) { 
                jardinY = jardinY + int(pS);
                randomYCD += int(pS);
                for (Technologie tech : technologies) {
                    tech.move(0, int(pS)); // Bouge les technologies vers le bas
                }
            } 
        }
        if (jardinY >= height * -1.1) {
            if (pBot == true && downKeyPressed == true) {
                jardinY = jardinY - int(pS);
                randomYCD -= int(pS);
                for (Technologie tech : technologies) {
                    tech.move(0, -int(pS)); // Bouge les technologies vers le haut
                }
            }
        }
    }
    
    // index pour les images de plantes

    void layoutMatrix() {

        /* 
        **
        |$ éléments du tableau $|
            - position en x
            - position en y
            - index de l'image       
        **
        */
        int x = ((width/jardinXSubDiv)/2) * -1;
        int y = jardinY;
        int imageIndex;

        // tableau //
        for (int k = 0; k < jardinXSubDiv; k++) {
            for (int j = 0; j < jardinYSubDiv; j++) {

                // // x
                if (x >= width - (width/jardinXSubDiv)/2) {
                    x = ((width/jardinXSubDiv)/2) * -1;
                }

                jardinPosXMatrix[k][j] = x + planteOffsetX;

                x += (width/jardinXSubDiv) + int(random(planteOffsetX * -1, planteOffsetX));
                
                // println("rangé " + k + " : " + jardinPosXMatrix[k][j] + " (" + k + ", " + j + ")");

                // // y
                if (y > jardinLength) {
                    y = jardinY;
                }

                jardinPosYMatrix[k][j] = y - planteOffsetY;

                if (j == int(jardinYSubDiv/3) || j == int((jardinYSubDiv/3)*2)) {
                    y = (k * (jardinLength/jardinYSubDiv)) + int(random(planteOffsetY * -1, planteOffsetY)) + 100;
                } else {
                    y = (k * (jardinLength/jardinYSubDiv)) + int(random(planteOffsetY * -1, planteOffsetY));
                }               

                // println("rangé " + k + " : " + jardinPosYMatrix[k][j] + " (" + k + ", " + j + ")");

                // // image index
                imageIndex = int(random(7));

                jardinImgMatrix[k][j] = imageIndex; 
            }
        }
    }

    void displayMtn(int x, int y) {
        // montagnes
        fill(jaune);
        // println("x : " + x + ", y : " + y);
        rect(x, y + (2 * planteOffsetY), mtnW, mtnH);

        // meryem! mettre l'image directement ici
    } 
}