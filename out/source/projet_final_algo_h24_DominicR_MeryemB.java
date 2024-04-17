/* autogenerated by Processing revision 1293 on 2024-04-17 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class projet_final_algo_h24_DominicR_MeryemB extends PApplet {

// // variables // //
// général //

// couleurs //


// joueur //
// position
float pX; // déclare une variable pour la position en x du joueur
float pY; // déclare une variable pour la position en y du joueur
float pS = 10; // déclare une variable pour la vitesse de déplacement du joueur

// objet
Joueur joueur; // déclare l'objet joueur

// plantes //
// position
int planteX; // déclare une variable pour la position en x de la plante
int planteY; // déclare une variable pour la position en y de la plante

// image
PImage plante_01; // déclare une variable pour y storer une image
PImage plante_02; // déclare une variable pour y storer une image
PImage plante_03; // déclare une variable pour y storer une image

// objet
Plante[] plantes; // déclare un tableau d'objet pour les plantes

// // fonctions // //
// set up //
public void setup() {
    // général
    /* size commented out by preprocessor */; // donne la grosseur à la fenêtre

    // joueur
    // // position
    pX = width/2; // donne une valeur initial à la variable pX
    pY = height/8 * 7; // donne une valeur initial à la variable pY

    // // objet
    joueur = new Joueur(pX, pY, pS); // cré un instence de l'objet joueurà

    // plantes
    // // images
    plante_01 = loadImage("img/plantes/plante_01.png");
}

// draw // 
public void draw() {
    

    // général
    background(0, 0, 0); // donne une couleur à l'arrière plan
    image(plante_01, 0, 0);
    // joueur
    joueur.display(); // appel la méthode display de l'objet joueur
}
class Joueur {
    // variables
    float x; // déclare une variable correspondant à la position en x de l'objet 
    float y; // déclare une variable correspondant à la position en y de l'objet
    float xSpeed; // déclare une variable correpondant à la vitesse en x de l'objet
    float ySpeed; // déclare une variable correspondant à la vitesse en y de l'objet

    // constructor
    Joueur(float x, float y, float s) {
        // variables
        this.x = x; // correspond la valeur en x qu'on donne en appelant l'objet à celle de l'instence de l'objet
        this.y = y; // correspond la valeur en y qu'on donne en appelant l'objet à celle de l'instence de l'objet
        this.xSpeed = s; // donne la valeur de vitesse s qu'on donne en appelant l'objet à celle de l'instence de l'objet
        this.ySpeed = s; // donne la valeur de vitesse s qu'on donne en appelant l'objet à celle de l'instence de l'objet
    }

    // méthodes
    // // display
    public void display() { // sert à déssiner le joueur
        // appel la méthode move
        this.move();
        
        // dessine le joueur
        fill(255);
        noStroke();
        circle(x, y, 20);
    }

    public void move() { //sert à faire bouger le joueur
        if (keyPressed == true) {
            if (key == CODED) {
                if (keyCode == UP) { // fait bouger le joueur par en haut
                    if (y > 0) {
                        y = y - ySpeed;
                    } 
                }
                if (keyCode == DOWN) { // fait bouger le joueur par en bas
                    if (y < height) {
                        y = y + ySpeed;
                    }
                }
                if (keyCode == LEFT) { // fait bouger le joueur à gauche 
                    if (x > 0) {
                        x = x - xSpeed;
                    }
                }
                if (keyCode == RIGHT) { // fait bouger le joueur à droite
                    if (x < width) {
                        x = x + xSpeed;
                    }
                }
            }
        }
    }
}
class Plante {
    int x;
    int y;

    Plante(int x, int y) {
        this.x = x;
        this.y = y;
    }
}


  public void settings() { size(500, 500); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "projet_final_algo_h24_DominicR_MeryemB" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
