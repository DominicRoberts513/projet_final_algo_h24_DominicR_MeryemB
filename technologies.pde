class Technologie {
    int posX;
    int posY;
    PImage[] techImages; 
    int imageIndex;
    

    Technologie(PImage[] techImages, int imageIndex) { // constructeur de la classe Technologie
        this.techImages = techImages; // images des technologies
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


    void display(float zoom) { //l'affichage de la technologie est blurry, je vais regarder comment régler ça
        // Calcul de la nouvelle largeur et hauteur de l'image
        int newWidth = int(techImages[imageIndex].width * zoom);
        int newHeight = int(techImages[imageIndex].height * zoom);

        // Créé une copie de l'image redimensionnée
        PImage resizedImage = techImages[imageIndex].copy();
        resizedImage.resize(newWidth, newHeight);

        // Dessine l'image redimensionnée
        image(resizedImage, posX, posY);
    }

    boolean isCollidingWithPlayer(Joueur joueur, int collisionRadius) { // vérifie si le joueur est en collision avec la technologie
        float techCenterX = this.posX + techImages[imageIndex].width / 2; // centre de la technologie
        float techCenterY = this.posY + techImages[imageIndex].height / 2;
        return dist(techCenterX, techCenterY, joueur.x, joueur.y) <= collisionRadius; // distance entre le centre de la technologie et le joueur
    }
}