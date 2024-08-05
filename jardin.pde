class Jardin {
    Jardin() {
        layoutMatrix();
    }

    void display() {
        scrolling();

        // boucles
        for (int k = 0; k < jardinXSubDiv; k++) {
            for (int j = 0; j < jardinYSubDiv; j++) {

                // masking pour les pan de montagnes et le chemin
                if (jardinPosYMatrix[k][j] + jardinY >= jardinY) {
                    if (jardinPosXMatrix[k][j] <= width/3 || jardinPosXMatrix[k][j] >= (width/3)*2) {
                        // affichage des plants
                        plantes.updateSize(jardinImgMatrix[k][j], jardinPerspSize[k][j]);
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
        |$éléments du tableau$|
            - position en x
            - position en y
            - index de l'image
            - surplus de grosseur pour la perspective
        
        **
        */
        int x = ((width/jardinXSubDiv)/2) * -1;
        int y = jardinY;
        int imageIndex;
        int scaleFactor = 0;

        // tableau //
        for (int k = 0; k < jardinXSubDiv; k++) {
            for (int j = 0; j < jardinYSubDiv; j++) {

                // // x
                if (x >= width - (width/jardinXSubDiv)/2) {
                    x = ((width/jardinXSubDiv)/2) * -1;
                }

                jardinPosXMatrix[k][j] = x;

                x += (width/jardinXSubDiv) + int(random(planteOffsetX * -1, planteOffsetX));
                
                // println("rangé " + k + " : " + jardinPosXMatrix[k][j] + " (" + k + ", " + j + ")");

                // // y
                if (y > jardinLength) {
                    y = jardinY;
                }

                jardinPosYMatrix[k][j] = y;

                if (j == int(jardinYSubDiv/3) || j == int((jardinYSubDiv/3)*2)) {
                    y = (k * (jardinLength/jardinYSubDiv)) + int(random(planteOffsetY * -1, planteOffsetY)) + 100;
                } else {
                    y = (k * (jardinLength/jardinYSubDiv)) + int(random(planteOffsetY * -1, planteOffsetY));
                }               

                // println("rangé " + k + " : " + jardinPosYMatrix[k][j] + " (" + k + ", " + j + ")");

                // // image index
                imageIndex = int(random(7));

                jardinImgMatrix[k][j] = imageIndex; 

                
                
                /*
                ** 
                // // placer du plus loin au plus proche ig?
                jardinPosYMatrix[i][j] = sort(jardinPosYMatrix[i][j]);
                **
                */

                // // grosseur 
                scaleFactor = j * 10;
                jardinPerspSize[k][j] = 0;

            }
        }
    }

    int jardinTranslation(int y) {
        y = int(cos(PI/3) * jardinLength);
        return y;
    }
}