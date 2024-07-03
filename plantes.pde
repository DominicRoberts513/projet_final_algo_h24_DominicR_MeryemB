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
        updateSize(i, 0);
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

    void updateSize(int i, int a) {
        int w;
        int h;
        if (a > 0) {
            w = (resizer + a);
            h = (resizer + a);
        } else if ( a == 0) {
            w = resizer;
            h = resizer;
        } else {
            w = 1;
            h = 1;
        }
        
        plantesImage[i].resize(w, h);
    }
}