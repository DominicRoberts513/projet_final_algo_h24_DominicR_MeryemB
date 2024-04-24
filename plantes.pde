class Plante {
    // int x;
    // int y;
    int planteIndex;
    int offsetValue;
    int offset; 
    


    Plante(int planteI, int offsetValue) {
        // this.x = x;
        // this.y = y;

        this.planteIndex = planteI;
        this.offsetValue = offsetValue;
        offset = int(random(offsetValue * -1, offsetValue));

        
    }

    void display(int x, int y) {
        for ( int i = 1; i <= 7; i++) {
            plantesImage[i - 1].resize(50, 75);
        }
        image(plantesImage[planteIndex], posOffset(x), posOffset(y));
    }

    int posOffset(int a) {    
        a = a + offset;
        return a;
    }
}