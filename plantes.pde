class Plante {
    // int x;
    // int y;
    int planteIndex;
    int offsetValue;
    int offset; 
    // image
    PImage[] plantesImage = new PImage[3]; // déclare une variable pour y storer une image


    Plante(int planteI, int offsetValue) {
        // this.x = x;
        // this.y = y;

        this.planteIndex = planteI;
        offsetValue = this.offsetValue;
        offset = int(random(offsetValue * -1, offsetValue));

        // image
        for (int i = 1; i <= 3; i++) {
            plantesImage[i - 1] = loadImage ( "img/plantes/plante_0" + i + ".png" ); // charge les images dans le tableau d'images
            plantesImage[i - 1].resize(50, 75);
        }
    }

    void display(int x, int y) {
        image(plantesImage[planteIndex], posOffset(x), posOffset(y));
    }

    int posOffset(int a) {    
        a = a + offset;
        return a;
    }
}