class Plante {
    int posX;
    int posY;
    int offset;
    


    Plante( int offsetValue) {
        this.offset = offsetValue;
    }

    void display(int i) {
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
}