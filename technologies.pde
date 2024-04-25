class Technologie {
    int posX;
    int posY;
    PImage[] techImages;
    PImage[] highResTechImages; 
    int imageIndex;
    boolean spacePressed = false; // true si la touche espace est pressée
    boolean spaceWasPressed = false; // true si la touche espace était pressée
    boolean highResDisplayed = false; // true si l'image haute résolution est affichée
    Button[] buttonsPager = { // boutons pour le pager
        new Button(335, 456, 75, 75, 1), // position x, position y, largeur, hauteur, ordre du bouton
        new Button(439, 458, 75, 75, 2),
        new Button(532, 456, 75, 75, 3),
        new Button(639, 467, 75, 75, 4)
    };
    int[] buttonOrderPager = {3, 4, 4, 2, 1, 3, 4, 2, 3, 1, 2}; // ordre des boutons pour le pager
    int currentOrderPagerIndex = 0; // index de l'ordre actuel
    Button[] buttonsRadio = { // boutons pour le pager
        new Button(479, 476, 50, 50, 1), // position x, position y, largeur, hauteur, ordre du bouton
        new Button(499, 473, 50, 50, 2),
        new Button(528, 471, 50, 50, 3),
        new Button(554, 469, 50, 50, 4),
        new Button(583, 468, 50, 50, 5),
        new Button(605, 466, 50, 50, 6),
        new Button(636, 465, 50, 50, 7)
    };

    Technologie(PImage[] techImages, PImage[] highResTechImages, int imageIndex) { // constructeur de la classe Technologie
        this.techImages = techImages; // images des technologies
        this.highResTechImages = highResTechImages; // high-resolution images
        this.imageIndex = imageIndex; // index de l'image de la technologie
    }
    

    void setPosition(int x, int y) { // définit la position de la technologie
        if (imageIndex != 5 && (x < width/3 || x > 2*width/3)) { // Seulement si la nouvelle position n'est pas dans le tiers du milieu
            this.posX = x; // position de la technologie
        } else if (imageIndex == 5) {
            this.posX = x;
        }
        this.posY = y; 
    }

    void move(int dx, int dy) { // déplace la technologie
        int newX = this.posX + dx;
        if (imageIndex != 5 && (newX < width/3 || newX > 2*width/3)) { // seulement si la nouvelle position n'est pas dans le tiers du milieu
            this.posX = newX; // position de la technologie
        } else if (imageIndex == 5) {
            this.posX = newX;
        }
        this.posY += dy;
    }


    void display(Joueur joueur, int posX, int posY) {
        // Calcul de la largeur et de la hauteur de l'image haute résolution
        int newWidth = highResTechImages[imageIndex].width;
        int newHeight = highResTechImages[imageIndex].height;
    
        // Calcul de la position de l'image haute résolution
        int highResPosX = width / 2 - newWidth / 2;
        int highResPosY = height / 2 - newHeight / 2;
    
        // Si la touche espace est pressée et qu'elle n'était pas pressée au frame précédent
        if (spacePressed && !spaceWasPressed) {
            // Si le joueur est en collision avec la technologie actuelle et que l'image haute résolution n'est pas déjà affichée
            if (isCollidingWithPlayer(joueur, collisionRadius) || highResDisplayed) {
                // Active l'affichage de l'image haute résolution
                highResDisplayed = !highResDisplayed;
            }
        }
    
        if (highResDisplayed) {
            // Affiche l'image haute résolution au centre de l'écran
            image(highResTechImages[imageIndex], highResPosX, highResPosY, newWidth, newHeight);
        } else {
            // Si l'image haute résolution n'est pas affichée, affiche l'image normale à la position de la technologie
            image(techImages[imageIndex], posX, posY);
        }
    
        // Mis à jour de l'état de la touche espace
        spaceWasPressed = spacePressed;
    }
    
    boolean isCollidingWithPlayer(Joueur joueur, int collisionRadius) { // vérifie si le joueur est en collision avec la technologie
        float techCenterX = this.posX + techImages[imageIndex].width / 2; // centre de la technologie
        float techCenterY = this.posY + techImages[imageIndex].height / 2;
        return dist(techCenterX, techCenterY, joueur.x, joueur.y) <= collisionRadius; // distance entre le centre de la technologie et le joueur
    }

    boolean isPointInHighResImage(int x, int y) { // vérifie si la souris est dans l'image haute résolution
        if (!highResDisplayed) { // si l'image haute résolution n'est pas affichée
            return false; // retourne faux
        }

        int newWidth = highResTechImages[imageIndex].width; // largeur de l'image haute résolution
        int newHeight = highResTechImages[imageIndex].height; // hauteur de l'image haute résolution
        int highResPosX = width / 2 - newWidth / 2; // position x    de l'image haute résolution
        int highResPosY = height / 2 - newHeight / 2; // position y de l'image haute résolution

        return x >= highResPosX && x <= highResPosX + newWidth && y >= highResPosY && y <= highResPosY + newHeight; // retourne vrai si la souris est dans l'image haute résolution
    }

    boolean isButtonClicked(int x, int y) { // vérifie si un bouton est cliqué
        if (currentOrderPagerIndex == buttonOrderPager.length) { // Si l'ordre complet a été complété
            return false; // fait rien
        }
    
        for (Button button : buttonsPager) { 
            if (button.isMouseInside(x, y)) { // si le point est à l'intérieur du bouton
                if (button.order == buttonOrderPager[currentOrderPagerIndex]) { // si l'ordre du bouton est correct
                    currentOrderPagerIndex++; // incrémente l'index de l'ordre
                    if (currentOrderPagerIndex == buttonOrderPager.length) { // Si l'ordre complet a été complété
                        imageIndex = 5; // Change à l'image de la technologie finale
                        sonPager.play(); // Joue le son du pager
                    } else {
                        imageIndex = button.order; // Change à l'image du boutton cliqué
                    }
                } else {
                    currentOrderPagerIndex = 0; // Reset l'ordre
                    imageIndex = 0; // Reset l'image
                }
                return true;
            }
        }
        return false;
    }
}

class Button { // classe pour les boutons
    int x, y, width, height, order; // position x, position y, largeur, hauteur, ordre du bouton

    Button(int x, int y, int width, int height, int order) { // constructeur de la classe Button
        this.x = x; // position x du bouton
        this.y = y; // position y du bouton
        this.width = width; // largeur du bouton
        this.height = height; // hauteur du bouton
        this.order = order; // ordre du bouton
    }

    boolean isMouseInside(int px, int py) { // vérifie si la souris est à l'intérieur du bouton
        return px >= x - width / 2 && px <= x + width / 2 && py >= y - height / 2 && py <= y + height / 2; // retourne vrai si le point est à l'intérieur du bouton
    }
}