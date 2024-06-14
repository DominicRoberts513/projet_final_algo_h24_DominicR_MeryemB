class Plante {
    int posX;
    int posY;
    int offset;
    


    Plante( int offsetValue) {
        this.offset = offsetValue;
    }

    void display(int i, int x, int y) {
        updatePosition(x, y);
        image(plantesImage[i], posX, posY);
    }

    int posOffset(int a) {    
        a = a + offset;
        
        return a;
    }

    // update la position de la plante avec un offset
    void updatePosition(int x, int y) {
        posX = posOffset(x);

        posY = posOffset(y);
    }

    void updateSize(int i, int y) {
        int w;
        int h;

        if (y/1000 <=  0) {
            y = 1;
        }

        w = (resizer + y);
        h = (resizer + y);

        plantesImage[i].resize(w, h);
    }
}