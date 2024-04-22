/* autogenerated by Processing revision 1293 on 2024-04-22 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import processing.sound.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class projet_final_algo_h24_DominicR_MeryemB extends PApplet {

/*
**
** Travail_02
** par : Dominic & Meryem
** Présenté à Sofian Audry
** 
*/



// // variables // //
// général //

// couleurs //
int noir = color(49, 1, 11);
int rouge = color(239, 60, 92);
int jaune = color(234, 234, 40);
int vert = color(34, 216, 100);
int vert_foncee = color(68, 123, 28);
int bleu = color(42, 135, 223);
int bleu_pale = color(236, 248, 252);

// joueur //
// position
float pX; // déclare une variable pour la position en x du joueur
float pY; // déclare une variable pour la position en y du joueur
float pS = 5; // déclare une variable pour la vitesse de déplacement du joueur

// objet
Joueur joueur; // déclare l'objet joueur

// plantes //
// quantité
int planteQte = 5;

// position
int planteX; // déclare une variable pour la position en x de la plante
int planteY; // déclare une variable pour la position en y de la plante

// objet
Plante[] plantes = new Plante[planteQte]; // déclare un tableau d'objet pour les plantes

// son
SoundFile backgroundSon01;

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
    plantes = new Plante[planteQte];

    for (int i = 0; i < planteQte; i++) {
        int planteIndex = PApplet.parseInt(random(3));
        plantes[i] = new Plante(planteIndex);
    }
    
    backgroundSon01 = new SoundFile(this, "sons/chord_progression_loop.wav");
    backgroundSon01.play();
    backgroundSon01.loop();
}

// draw // 
public void draw() {
    // général
    background(noir); // donne une couleur à l'arrière plan

    // joueur
    joueur.display(); // appel la méthode display de l'objet joueur
    
    // plantes
    for (int y = 0; y < height; y += height/planteQte) {
        println(y);
        for ( int x = 0; x < width; x += width/planteQte) {
            for (int i = 0; i < planteQte; i++) {
                plantes[i].display(x, y);
            }
        }
    }
    
    // for (int y = 0; y < height; y += plante_01.height) {
    // image(plante_01, 0, y); // Dessiner l'image sur le côté gauche de la fenêtre
    // }
    
    // for (int y = 0; y < height; y += plante_02.height) {
    // image(plante_02, width - plante_02.width, y); // Dessiner l'image sur le côté droit de la fenêtre
    // }
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
                    if (x > width/3) {
                        x = x - xSpeed;
                    }
                }
                if (keyCode == RIGHT) { // fait bouger le joueur à droite
                    if (x < width/3 * 2) {
                        x = x + xSpeed;
                    }
                }
            }
        }
    }
}
class Plante {
    // int x;
    // int y;
    int planteIndex;
    int offsetValue = 100;
    int offset; 
    // image
    PImage[] plantesImage = new PImage[3]; // déclare une variable pour y storer une image


    Plante(int planteI) {
        // this.x = x;
        // this.y = y;

        this.planteIndex = planteI;

        offset = PApplet.parseInt(random(offsetValue * -1, offsetValue));

        // image
        for (int i = 1; i <= 3; i++) {
            plantesImage[i - 1] = loadImage ( "img/plantes/plante_0" + i + ".png" ); // charge les images dans le tableau d'images
            plantesImage[i - 1].resize(50, 75);
        }
    }

    public void display(int x, int y) {
        image(plantesImage[planteIndex], posOffset(x), posOffset(y));
    }

    public int posOffset(int a) {    
        a = a + offset;
        return a;
    }
}


  public void settings() { size(800, 800); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "projet_final_algo_h24_DominicR_MeryemB" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
