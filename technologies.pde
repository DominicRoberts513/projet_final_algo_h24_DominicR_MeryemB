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
        if (imageIndex != 5) { // Sans la 6ème technologie
            if (x < width/3 || x > 2*width/3) { // Seulement si la nouvelle position n'est pas dans le tiers du milieu
                this.posX = x; // position de la technologie
            }
        } else { // 6ème technologie
            this.posX = width/2;
        } // position de la technologie
        this.posY = y; 
    }

    void move(int dx, int dy) { // déplace la technologie
        int newX = this.posX + dx;
        if (imageIndex != 5) { // Sans la 6ème technologie
            if (newX < width/3 || newX > 2*width/3) { // seulement si la nouvelle position n'est pas dans le tiers du milieu
                this.posX = newX; // position de la technologie
            } 
        } else { // 6ème technologie
            this.posX = newX; 
        } // position de la technologie
        this.posY += dy;
    }


    void display() {
        image(techImages[imageIndex], posX, posY); // affiche la technologie
    }

    boolean isCollidingWithPlayer(Joueur joueur, int collisionRadius) { // vérifie si le joueur est en collision avec la technologie
        float techCenterX = this.posX + techImages[imageIndex].width / 2; // centre de la technologie
        float techCenterY = this.posY + techImages[imageIndex].height / 2;
        return dist(techCenterX, techCenterY, joueur.x, joueur.y) <= collisionRadius; // distance entre le centre de la technologie et le joueur
    }
}