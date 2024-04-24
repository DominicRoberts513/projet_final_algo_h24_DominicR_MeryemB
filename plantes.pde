class Plante {
    int posX;
    int posY;
    int planteIndex;
    int offset;
    


    Plante(int planteI, int offsetValue) {
        this.planteIndex = planteI;
        this.offset = offsetValue;
    }

    void display() {
        image(plantesImage[planteIndex], posX, posY);
    }

    int posOffset(int a) {    
        a = a + offset;
        return a;
    }

    void updatePosition(int x, int y) {
        posX = posOffset(x);
        posY = posOffset(y);
    }

    
}