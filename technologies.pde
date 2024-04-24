class Technologie {
    int posX;
    int posY;
    PImage[] techImages;
    int imageIndex;

    Technologie(PImage[] techImages, int imageIndex) {
        this.techImages = techImages;
        this.imageIndex = imageIndex;
    }

    void setPosition(int x, int y) {
        this.posX = x;
        this.posY = y;
    }

    void display() {
        image(techImages[imageIndex], posX, posY);
    }
}