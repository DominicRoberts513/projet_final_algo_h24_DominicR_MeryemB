class Technologie {
    int posX;
    int posY;
    PImage[] techImages;
    PImage[] highResTechImages; 
    int imageIndex;
    boolean spacePressed = false; // true si la touche espace est pressée
    boolean spaceWasPressed = false; // true si la touche espace était pressée
    boolean highResDisplayed = false; // true si l'image haute résolution est affichée

    Technologie(PImage[] techImages, PImage[] highResTechImages, int imageIndex) { // constructeur de la classe Technologie
        this.techImages = techImages; // images des technologies
        this.highResTechImages = highResTechImages; // high-resolution images
        this.imageIndex = imageIndex; // index de l'image de la technologie
    }
    

    void setPosition(int x, int y) { // définit la position de la technologie
        if (imageIndex != 5 && (x < width/3 || x > 2*width/3)) { // Seulement si la nouvelle position n'est pas dans le tiers du milieu
            this.posX = x; // position de la technologie
        } else if (imageIndex == 5) {
            this.posX = x;
        }
        this.posY = y; 
    }

    void move(int dx, int dy) { // déplace la technologie
        int newX = this.posX + dx;
        if (imageIndex != 5 && (newX < width/3 || newX > 2*width/3)) { // seulement si la nouvelle position n'est pas dans le tiers du milieu
            this.posX = newX; // position de la technologie
        } else if (imageIndex == 5) {
            this.posX = newX;
        }
        this.posY += dy;
    }


    void display(Joueur joueur, int posX, int posY) {
        // Calcul de la largeur et de la hauteur de l'image haute résolution
        int newWidth = highResTechImages[imageIndex].width;
        int newHeight = highResTechImages[imageIndex].height;
    
        // Calcul de la position de l'image haute résolution
        int highResPosX = width / 2 - newWidth / 2;
        int highResPosY = height / 2 - newHeight / 2;
    
        // Si la touche espace est pressée et qu'elle n'était pas pressée au frame précédent
        if (spacePressed && !spaceWasPressed) {
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
    
    boolean isCollidingWithPlayer(Joueur joueur, int collisionRadius) { // vérifie si le joueur est en collision avec la technologie
        float techCenterX = this.posX + techImages[imageIndex].width / 2; // centre de la technologie
        float techCenterY = this.posY + techImages[imageIndex].height / 2;
        return dist(techCenterX, techCenterY, joueur.x, joueur.y) <= collisionRadius; // distance entre le centre de la technologie et le joueur
    }
}