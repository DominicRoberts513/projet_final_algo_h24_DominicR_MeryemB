class Jardin {
    Jardin() {
        updatePlanteImageIndex();
        layoutMatrix();
    }

    void display() {
        scrolling();

        for (int x = 0; x <= width; x += width/jardinXSubDiv) {
            for (int y = jardinY; y <= jardinLength; y += jardinLength/jardinYSubDiv) {
                
            }
        }

        for (int k = 0; k < jardinXSubDiv; k++) {
            for (int j = 0; j < jardinYSubDiv; j++) {
                for (int i = 1; i <= planteQte; i++) {
                    plantes[i - 1].display(jardinImgMatrix[i][j], jardinPosXMatrix[k][j], jardinPosYMatrix[k][j] + jardinY); // appel la methode display des objets plantes
                }
            }
        }

        // for (int x = 0; x < width; x += width/jardinXSubDiv) {
        //     for () {
        //         int y = jardinY + (i*(jardinLength/planteQte)) - jardinLength/planteQte;
        //         // int y = (i*(height/planteQte)) /* + height/planteQte */;
        //         

                
        //     }
        // }
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
    void updatePlanteImageIndex() {
        for (int i = 0; i < planteQte; i++) {
            planteImageIndex[i] = int(random(7));
        }
    }

    void layoutMatrix() {

        // éléments du tableau //
        int x = 0;
        int y = jardinY;
        int imageIndex;

        // tableau //
        for (int i = 0; i < jardinXSubDiv; i++) {
            for (int j = 0; j < jardinYSubDiv; j++) {

                // // x
                if (x > width) {
                    x = 0;
                }

                jardinPosXMatrix[i][j] = x;

                x += (width/jardinXSubDiv) + int(random(planteOffsetX * -1, planteOffsetX));
                
                // // y
                if (y > jardinLength) {
                    y = jardinY;
                }

                jardinPosYMatrix[i][j] = y;

                y += (jardinLength/jardinYSubDiv) + int(random(planteOffsetY * -1, planteOffsetY));

                // // image index
                imageIndex = int(random(7));

                jardinImgMatrix[i][j] = imageIndex; 

                // // grosseur 

            }
        }
    }
}