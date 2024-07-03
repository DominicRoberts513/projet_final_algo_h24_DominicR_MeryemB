class Plante {
    int posX;
    int posY;
    int offsetX;
    int offsetY;
    


    Plante( int offsetValueX, int offsetValueY) {
        this.offsetX = offsetValueX;
        this.offsetY = offsetValueY;
    }

    void display(int i, int x, int y) {
        updatePosition(x, y);
        image(plantesImage[i], posX, posY);
    }

    int posOffset(int a, int offset) { 
        a = a + offset;

        return a;
    }

    // update la position de la plante avec un offset
    void updatePosition(int x, int y) {
        posX = posOffset(x, offsetX);

        posY = posOffset(y, offsetY);
    }

    void updateSize(int i, int y) {
        int w;
        int h;

        if (y/1000 <=  0) {
            y = 1;
        }

        y = y/3 * 2;

        w = (resizer + y);
        h = (resizer + y);

        plantesImage[i].resize(w, h);
    }
}