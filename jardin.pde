class Jardin {

    Jardin() {
        
    }

    void display() {
        scrolling();

        for (int y = jardinY; y < jardinLength; y += jardinYSubDiv) {
            updatePlanteImageIndex();
            for (int i = 1; i <= planteQte; i++) {
                int x = (i*(width/planteQte)) - width/planteQte;
                // int y = (i*(height/planteQte)) /* + height/planteQte */;

                plantes[i - 1].display(planteImageIndex[i - 1], x, y); // appel la methode display des objets plantes
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
    
}