 /*
**
 ** Travail_02
 ** par : Dominic & Meryem
 ** Présenté à Sofian Audry
 **
 */
// // librairie // //
// sound //
// [processing-p5-convert] import processing.sound.*;
// [processing-p5-convert] import processing.video.*;
// // variables // //
// général //
let resizer = 100 ; // déclare une variable pour le redimensionnement des images
let resizerHighRes = 600 ; // déclare une variable pour le redimensionnement des images en haute résolution
let collisionRadius = 100 ; // Rayon de collision


// arriere plan
let sonArriere_01 ; let sonArriere_02 ; let sonArriere_03 ; // technologies
let sonCd ; let sonPager ; let sonPhone ; let sonRadio ; let sonWalkman ; // q sonore
let sonVictoire ; let sonClicInteraction ; let isSonVictoire = false ; //son de la fin du jeu
let sonTV1 ; let sonTV2 ; let sonTV3 ; // ui //
let interactionSourisUi = 'Utilisez la souris pour intéragir avec la technologie!';

// images
// // move

let menuImgIndex = 0;
let btnW = 300;
let btnH = 150;
let playBtnImgIndex = 0;
let quitBtnImgIndex = 0;
let coffeeMilk;

let isGameOn = false ; // pour détecter si le jeu est en mode menu ou jeu
// objet
let ui ; // déclare l'objet
// joueur //
// position
let pX ; // déclare une variable pour la position en x du joueur
let pY ; // déclare une variable pour la position en y du joueur
let pS = 20 ; // déclare une variable pour la vitesse de déplacement du joueur
// mouvement
let upKeyPressed = false ; let downKeyPressed = false ; let leftKeyPressed = false ; let rightKeyPressed = false ; // interaction
let spaceKeyPressed = false ; let mouseJustPressed = false ; // défilement
let pTop = false ; let pBot = false ; // objet
let joueur ; // déclare l'objet joueur
// jardin //
// debug
/*
 ** permet de faire apparaitre les coordonné des plantes ainsi
 ** que les matrices d'index d'images sur le canva
 */
let jardinDebugUi = false ; // position & formatage
// // jardin
let jardinLength ; // déclare une variable pour storer la longueur du jardin
let jardinY ; // déclare une variable pour enregistrer la coordonée y du jardin
let jardinYSubDiv = 30 ; // 25 // sous division en y du jardin
let jardinXSubDiv = 26 ; // 22 // sous division en x du jardin
let jardinPosXMatrix = Array.from(new Array(jardinXSubDiv), ()=>new Array(jardinYSubDiv)); let jardinPosYMatrix = Array.from(new Array(jardinXSubDiv), ()=>new Array(jardinYSubDiv)); let jardinImgMatrix = Array.from(new Array(jardinXSubDiv), ()=>new Array(jardinYSubDiv)); let jardinPerspSize = Array.from(new Array(jardinXSubDiv), ()=>new Array(jardinYSubDiv)); // // montagnes
let mtnW ; let mtnH ; let mtnImg ; // objet
let jardin ; // déclare l'objet jardin
// plantes //
// quantité
let planteOffsetX = 20 ; // 50
let planteOffsetY = 10 ; // 20
let offsetValueX ; let offsetValueY ; // position
let planteX ; // déclare une variable pour la position en x de la plante
let planteY ; // déclare une variable pour la position en y de la plante
// images
// technologies //
//position des technologies
let randomXCD , randomYCD ; // Pour le CD
let randomX , randomY ; // Pour les autres technologies
//variables pour les technologies
let tvsLastChange = 0 ; // Dernier changement d'image
let tvsChangeInterval = 1000 ; // Intervalle de temps pour changer l'image
let isCdPlayerDone = false ; // Vérifie si le CdPlayer est terminé
let isPagerDone = false ; // Vérifie si le Pager est terminé
let isPhoneDone = false ; // Vérifie si le Phone est terminé
let isRadioDone = false ; // Vérifie si la Radio est terminée
let isWalkmanDone = false ; // Vérifie si le Walkman est terminé
// bool
let isCDPickedUp = false ; // Vérifie si le CD est ramassé
let isTechZoom = false ; // vérifie si la tech est zoom
let distanceToCD ; // Distance entre le joueur et le CD
// images
let theEnd ; let isVideoStarted = false ; // objet
let plantes ; // déclare un tableau d'objet pour les plantes
let technologies = new Array(6); // déclare un tableau d'objet pour les technologies
let walkman ; // Déclare une variable pour l'objet Walkman
let pager ; // Idem
let phone ; let radio ; let cdPlayer ; let tvs ; // // // // // // // // // // fonctions // // // // // // // // // //

let upKey = [];
let downKey = [];
let leftKey = [];
let rightKey = [];
let spaceKey = [];
let menuBg = [];
let playBtn = [];
let quitBtn = [];
let plantesImage = [];
let cdPlayerImages = [];
let cdPlayerImagesHighRes = [];
let pagerImages = [];
let pagerImagesHighRes = [];
let phoneImages = [];
let phoneImagesHighRes = [];
let radioImages = [];
let radioImagesHighRes = [];
let walkmanImages = [];
let walkmanImagesHighRes = [];
let tvsImages = [];
let tvsImagesHighRes = []

class Technologie {
    constructor(techImages, highResTechImages, imageIndex) {
        this.posX = 0; // Initialize with default value
        this.posY = 0; // Initialize with default value
        this.highResPosX = 0; // Initialize with default value
        this.highResPosY = 0; // Initialize with default value
        this.techImages = techImages; // images des technologies
        this.highResTechImages = highResTechImages; // high-resolution images
        this.imageIndex = imageIndex; // index de l'image de la technologie
        this.spacePressed = false; // true si la touche espace est pressée
        this.spaceWasPressed = false; // true si la touche espace était pressée
        this.highResDisplayed = false; // true si l'image haute résolution est affichée
        this.buttonsPager = [
            // boutons pour le pager
            new Button(335, 456, 75, 75, 1), // position x, position y, largeur, hauteur, ordre du bouton
            new Button(439, 458, 75, 75, 2),
            new Button(532, 456, 75, 75, 3),
            new Button(639, 467, 75, 75, 4),
        ];
        this.buttonOrderPager = [3, 4, 4, 2, 1, 3, 4, 2, 3, 1, 2]; // ordre des boutons pour le pager
        this.currentOrderPagerIndex = 0; // index de l'ordre actuel
        this.buttonsRadio = [
            // boutons pour le pager
            new Button(467, 455, 15, 15, 0), // position x, position y, largeur, hauteur, ordre du bouton
            new Button(499, 455, 15, 15, 1),
            new Button(522, 455, 15, 15, 2),
            new Button(545, 455, 15, 15, 3),
            new Button(576, 455, 15, 15, 4),
            new Button(610, 455, 15, 15, 5),
            new Button(638, 455, 15, 15, 6),
        ];
    }

    setPosition(x, y) {
        // Validate inputs
        if (typeof x !== 'number' || typeof y !== 'number') {
            console.error(`Invalid input: x and y must be numbers. Received x=${x}, y=${y}`);
            return;
        }

        // Define the position of the technology
        const middleThirdStart = width / 3;
        const middleThirdEnd = (2 * width) / 3;

        // Set posX based on conditions
        if (this.imageIndex == 5 || x < middleThirdStart || x > middleThirdEnd) {
            this.posX = x;
        }

        // Always set posY
        this.posY = y;
    }

    move(dx, dy) {
        // déplace la technologie
        let newX = this.posX + dx;

        if (newX < width / 3 || newX > (2 * width) / 3) {
            // seulement si la nouvelle position n'est pas dans le tiers du milieu
            this.posX = newX; // position de la technologie
        }
        this.posY += dy;
    }

    display(joueur, posX, posY) {
    
        // Calculate the width and height of the high-resolution image
        let newWidth = this.highResTechImages[this.imageIndex].width;
        let newHeight = this.highResTechImages[this.imageIndex].height;
    
        // Calculate the position of the high-resolution image
        this.highResPosX = width / 2 - newWidth / 2;
        this.highResPosY = height / 2 - newHeight / 2;
    
        // If this is the fifth technology, always display the high-resolution image
        if (this == technologies[5]) {
            this.highResDisplayed = true;
            this.highResPosX = width / 5;
            this.highResPosY = this.posY - jardinLength + jardinLength / 12.5;
            
        } else if (this.spacePressed && !this.spaceWasPressed) {
            // If the space key is pressed and wasn't pressed in the previous frame
            // and this is not the fifth technology
            if (this.isCollidingWithPlayer(joueur, collisionRadius) || this.highResDisplayed) {
                // Toggle the display of the high-resolution image
                this.highResDisplayed = !this.highResDisplayed;
            }
        }
    
        if (this.highResDisplayed) {
            // Display the high-resolution image at the calculated position
            image(this.highResTechImages[this.imageIndex], this.highResPosX, this.highResPosY, newWidth, newHeight);
        } else {
            // If the high-resolution image is not displayed, display the normal image at the technology's position
            image(this.techImages[this.imageIndex], posX, posY);
        }
    
        // Update the state of the space key
        this.spaceWasPressed = this.spacePressed;
    }

    isCollidingWithPlayer(joueur, collisionRadius) {
        // vérifie si le joueur est en collision avec la technologie
        let techCenterX =
            this.posX + this.techImages[this.imageIndex].width / 2; // centre de la technologie
        let techCenterY =
            this.posY + this.techImages[this.imageIndex].height / 2;
        return (
            dist(techCenterX, techCenterY, joueur.x, joueur.y) <=
            collisionRadius
        ); // distance entre le centre de la technologie et le joueur
    }

    isPointInHighResImage(x, y) {
        // vérifie si la souris est dans l'image haute résolution
        if (!this.highResDisplayed) {
            // si l'image haute résolution n'est pas affichée
            return false; // retourne faux
        }
        let newWidth = this.highResTechImages[this.imageIndex].width; // largeur de l'image haute résolution
        let newHeight = this.highResTechImages[this.imageIndex].height; // hauteur de l'image haute résolution
        let highResPosX = width / 2 - newWidth / 2; // position x de l'image haute résolution
        let highResPosY = height / 2 - newHeight / 2; // position y de l'image haute résolution
        return (
            x >= this.highResPosX &&
            x <= this.highResPosX + newWidth &&
            y >= this.highResPosY &&
            y <= this.highResPosY + newHeight
        ); // retourne vrai si la souris est dans l'image haute résolution
    }

    isButtonClicked(x, y) {
        // vérifie si un bouton est cliqué
        if (this.currentOrderPagerIndex == this.buttonOrderPager.length) {
            // Si l'ordre complet a été complété
            return false; // fait rien
        }
        for (let button of this.buttonsPager) {
            if (button.isMouseInside(x, y) && !isPagerDone) {
                // si le point est à l'intérieur du bouton
                if (
                    button.order == this.buttonOrderPager[this.currentOrderPagerIndex]
                ) {
                    // si l'ordre du bouton est correct
                    this.currentOrderPagerIndex++; // incrémente l'index de l'ordre
                    if (
                        this.currentOrderPagerIndex == this.buttonOrderPager.length
                    ) {
                        // Si l'ordre complet a été complété
                        this.imageIndex = 5; // Change à l'image de la technologie finale
                        isPagerDone = true; // Le pager est terminé
                        sonPager.play(); // Joue le son du pager
                    } else {
                        this.imageIndex = button.order; // Change à l'image du boutton cliqué
                    }
                } else {
                    this.currentOrderPagerIndex = 0; // Reset l'ordre
                    this.imageIndex = 0; // Reset l'image
                }
                return true;
            }
        }
        return false;
    }

    isRadioClicked(x, y) {
        // vérifie si un bouton est cliqué
        for (let button of this.buttonsRadio) {
            if (button.isMouseInside(x, y) && !isRadioDone) {
                // si le point est à l'intérieur du bouton
                if (button.order == 5) {
                    this.imageIndex = 7;
                    sonRadio.play();
                    isRadioDone = true;
                    return true;
                }
                this.imageIndex = button.order; // Change à l'image du boutton cliqué
                console.log(button.order);
                console.log(this.imageIndex);
                return true;
            }
        }
        return false;
    }
}

/* class Button {
    constructor(x, y, width, height, order) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.order = order;
    }

    isMouseInside(px, py) {
        return px >= this.x - this.width / 2 && px <= this.x + this.width / 2 && py >= this.y - this.height / 2 && py <= this.y + this.height / 2;
    }
}*/

class Jardin {

    constructor() {
        this.layoutMatrix();
    }

    display() {
        this.scrolling(); // montagne
        for (let j = 0; j < jardinYSubDiv; j++) {
            if (j == jardinYSubDiv / 3) {
                this.displayMtn(0, jardinLength / 3 + jardinY);
                this.displayMtn(width - mtnW, jardinLength / 3 + jardinY);
            } else if (j == (jardinYSubDiv / 3) * 2) {
                this.displayMtn(0, (jardinLength / 3) * 2 + jardinY);
                this.displayMtn(width - mtnW, (jardinLength / 3) * 2 + jardinY);
            }
        } // boucles

        for (let k = 0; k < jardinXSubDiv; k++) {
            for (let j = 0; j < jardinYSubDiv; j++) {
                // plantes
                // // masking
                // // // limite au sommet de la montagne
                if (jardinPosYMatrix[k][j] + jardinY >= jardinY) {
                    // // // limites pour le chemin
                    if (
                        jardinPosXMatrix[k][j] <= width / 3 ||
                        jardinPosXMatrix[k][j] >= (width / 3) * 2 - 20
                    ) {
                        // // // limites pour les falaises de la montagnes
                        if (
                            jardinPosYMatrix[k][j] + jardinY >=
                                jardinLength / 3 + jardinY &&
                            jardinPosYMatrix[k][j] + jardinY <=
                                jardinLength / 3 + mtnH + jardinY
                        ) {
                            // fait rien
                        } else if (
                            jardinPosYMatrix[k][j] + jardinY >=
                                (jardinLength / 3) * 2 + jardinY &&
                            jardinPosYMatrix[k][j] + jardinY <=
                                (jardinLength / 3) * 2 + mtnH + jardinY
                        ) {
                            // allo
                        } else {
                            // affichage des plants
                            plantes.updateSize(jardinImgMatrix[k][j], 0);
                            plantes.display(
                                jardinImgMatrix[k][j],
                                jardinPosXMatrix[k][j],
                                jardinPosYMatrix[k][j] + jardinY
                            ); // appel la methode display des objets plantes
                            // jardin debug ui
                            if (jardinDebugUi == true) {
                                textSize(25);
                                fill(blanc);
                                text(
                                    "(" +
                                        k +
                                        ", " +
                                        j +
                                        ", " +
                                        jardinImgMatrix[k][j] +
                                        " )",
                                    jardinPosXMatrix[k][j],
                                    jardinPosYMatrix[k][j] + jardinY
                                );
                                text(
                                    "(" +
                                        jardinPosXMatrix[k][j] +
                                        ", " +
                                        jardinPosYMatrix[k][j] +
                                        " )",
                                    jardinPosXMatrix[k][j],
                                    jardinPosYMatrix[k][j] + jardinY + 25
                                );
                            }
                        }
                    }
                }
            }
        }
    } // fait le défilement du jardin

    scrolling() {
        if (jardinY <= (height / 6) * 5) {
            if (pTop == true && upKeyPressed == true) {
                jardinY = jardinY + int(pS);
                randomYCD += int(pS);
                for (let tech of technologies) {
                    tech.move(0, int(pS)); // Bouge les technologies vers le bas
                }
            }
        }
        if (jardinY >= height * -1.1) {
            if (pBot == true && downKeyPressed == true) {
                jardinY = jardinY - int(pS);
                randomYCD -= int(pS);
                for (let tech of technologies) {
                    tech.move(0, -int(pS)); // Bouge les technologies vers le haut
                }
            }
        }
    } // index pour les images de plantes

    layoutMatrix() {
        /* 
        **
        |$ éléments du tableau $|
            - position en x
            - position en y
            - index de l'image       
        **
        */
        let x = (width / jardinXSubDiv / 2) * -1;
        let y = jardinY;
        let imageIndex; // tableau //
        for (let k = 0; k < jardinXSubDiv; k++) {
            for (let j = 0; j < jardinYSubDiv; j++) {
                // // x
                if (x >= width - width / jardinXSubDiv / 2) {
                    x = (width / jardinXSubDiv / 2) * -1;
                }
                jardinPosXMatrix[k][j] = x + planteOffsetX - 20;
                x +=
                    width / jardinXSubDiv +
                    int(random(planteOffsetX * -1, planteOffsetX)); // println("rangé " + k + " : " + jardinPosXMatrix[k][j] + " (" + k + ", " + j + ")");
                // // y
                if (y > jardinLength) {
                    y = jardinY;
                }
                jardinPosYMatrix[k][j] = y - planteOffsetY - 20;
                if (
                    j == int(jardinYSubDiv / 3) ||
                    j == int((jardinYSubDiv / 3) * 2)
                ) {
                    y =
                        k * (jardinLength / jardinYSubDiv) +
                        int(random(planteOffsetY * -1, planteOffsetY)) +
                        100;
                } else {
                    y =
                        k * (jardinLength / jardinYSubDiv) +
                        int(random(planteOffsetY * -1, planteOffsetY));
                } // println("rangé " + k + " : " + jardinPosYMatrix[k][j] + " (" + k + ", " + j + ")");
                // // image index
                imageIndex = int(random(7));
                jardinImgMatrix[k][j] = imageIndex;
            }
        }
    }
    displayMtn(x, y) {
        // montagnes
        // println("x : " + x + ", y : " + y);
        image(mtnImg, x, y + 50);
    }
}

class Joueur {
    // variables
    x; // déclare une variable correspondant à la position en x de l'objet
    y; // déclare une variable correspondant à la position en y de l'objet
    xSpeed; // déclare une variable correpondant à la vitesse en x de l'objet
    ySpeed; // déclare une variable correspondant à la vitesse en y de l'objet
    radius = 20; // déclare une variable correspondant au rayon du joueur
    // interaction
    isTechClose = false; // devioent true quand une tech est a moins de 200px
    distTechJoueur; // constructor
    constructor(x, y, s) {
        // variables
        this.x = x; // correspond la valeur en x qu'on donne en appelant l'objet à celle de l'instence de l'objet
        this.y = y; // correspond la valeur en y qu'on donne en appelant l'objet à celle de l'instence de l'objet
        this.xSpeed = s; // donne la valeur de vitesse s qu'on donne en appelant l'objet à celle de l'instence de l'objet
        this.ySpeed = s; // donne la valeur de vitesse s qu'on donne en appelant l'objet à celle de l'instence de l'objet
    } // méthodes
    // // display
    display() {
        // sert à déssiner le joueur
        // appel la méthode move
        this.move(); // appel lamethode interact
        this.interact(); // dessine le joueur
        fill(255);
        noStroke();
        circle(this.x, this.y, this.radius);
    }

    move() {
        // sert à faire bouger le joueur
        // fait bouger le joueur
        if (keyIsPressed) {
                if (keyCode === UP_ARROW) {
                    // fait bouger le joueur par en haut
                    if (this.y > height / 5) {
                        this.y = this.y - this.ySpeed;
                    }
                    upKeyPressed = true;
                }
                if (keyCode === DOWN_ARROW) {
                    // fait bouger le joueur par en bas
                    if (this.y < (height / 5) * 4) {
                        this.y = this.y + this.ySpeed;
                    }
                    downKeyPressed = true;
                }
                if (keyCode === LEFT_ARROW) {
                    // fait bouger le joueur à gauche
                    if (this.x > width / 10) { // Uncommented for bounds checking
                        this.x = this.x - this.xSpeed;
                    }
                    leftKeyPressed = true;
                }
                if (keyCode === RIGHT_ARROW) {
                    // fait bouger le joueur à droite
                    if (this.x < (width / 10) * 9) { // Uncommented for bounds checking
                        this.x = this.x + this.xSpeed;
                    }
                    rightKeyPressed = true;
                }
        } else {
            upKeyPressed = false;
            downKeyPressed = false;
            leftKeyPressed = false;
            rightKeyPressed = false;
        }

        // intéragit avec le défilement
        if (this.y <= height / 5) {
            pTop = true;
        } else {
            pTop = false;
        }
        if (this.y >= (height / 5) * 4) {
            pBot = true;
        } else {
            pBot = false;
        }
    }

    interact() {
        /*
        ** si le joueur est proche dune technologie. un signal visuel et sonore? apparait
            -- jai mis un zoom mais un signal sonore serait cool 
            -- coeur
        ** calcul la disstance entre le joueur et les technologie
        ** sous une certaine distance le signal apparait
        */
        for (let i = 1; i <= technologies.length; i++) {
            // boucle sur tout les technologies
            this.distTechJoueur = dist(
                this.x,
                this.y,
                technologies[i - 1].posX,
                technologies[i - 1].posY
            ); // calcul la distance entre les technologies
            if (this.distTechJoueur < 80) {
                // si le joueur est a moins de 200px
                this.isTechClose = true; //
                if (keyIsPressed) {
                    if (key == " ") {
                        spaceKeyPressed = true;
                    }
                } else {
                    spaceKeyPressed = false;
                } //println(spaceKeyPressed);
            } else {
                this.isTechClose = false;
            }
            if (this.isTechClose == true) {
                break;
            }
        }
    }
}


class Plante {
    posX;
    posY;
    offsetX;
    offsetY;
    constructor(offsetValueX, offsetValueY) {
        this.offsetX = int(random(offsetValueX * -1, offsetValueX));
        this.offsetY = int(random(offsetValueY * -1, offsetValueY));
    }
    display(i, x, y) {
        this.updatePosition(x, y);
        image(plantesImage[i], this.posX, this.posY);
    }
    posOffset(a, offset) {
        a = a + offset;
        return a;
    } // update la position de la plante avec un offset
    updatePosition(x, y) {
        this.posX = this.posOffset(x, this.offsetX);
        this.posY = this.posOffset(y, this.offsetY);
    } // update la grosseur des images
    updateSize(i, a) {
        let w;
        let h; // if batard pour pas que la fonction fasse chier
        if (a > 0) {
            w = resizer + a;
            h = resizer + a;
        } else if (a == 0) {
            w = resizer;
            h = resizer;
        } else {
            w = 1;
            h = 1;
        }
        plantesImage[i].resize(w, h);
    }
}

class Button {
    // classe pour les boutons
    x;
    y;
    width;
    height;
    order; // position x, position y, largeur, hauteur, ordre du bouton
    constructor(x, y, width, height, order) {
        // constructeur de la classe Button
        this.x = x; // position x du bouton
        this.y = y; // position y du bouton
        this.width = width; // largeur du bouton
        this.height = height; // hauteur du bouton
        this.order = order; // ordre du bouton
    }

    isMouseInside(px, py) {
        // vérifie si la souris est à l'intérieur du bouton
        return (
            px >= this.x - this.width / 2 &&
            px <= this.x + this.width / 2 &&
            py >= this.y - this.height / 2 &&
            py <= this.y + this.height / 2
        ); // retourne vrai si le point est à l'intérieur du bouton
    }
}

function keyPressed() {
    // si une touche est pressée
    if (keyCode === UP_ARROW) {
        console.log('allo'); // la barre d'espacement est pressée
    }

    if (keyCode === UP_ARROW) {
        console.log('allo'); // la barre d'espacement est pressée
    }
}

class Ui {
    // position
    moveKeyX;
    moveKeyY;
    txtSz = 36; // constructor
    constructor() {
        this.moveKeyX = (width / 6) * 5;
        this.moveKeyY = (height / 6) * 5;
    }

    display() {
        // sert à faire apparaitre le
        this.move();
        this.interact();
    }

    move() {
        // gere les touche de déplacement
        // up
        if (upKeyPressed == true) {
            image(upKey[1], this.moveKeyX, this.moveKeyY - width / 12);
        } else {
            image(upKey[0], this.moveKeyX, this.moveKeyY - width / 12);
        } // down
        if (downKeyPressed == true) {
            image(downKey[1], this.moveKeyX, this.moveKeyY);
        } else {
            image(downKey[0], this.moveKeyX, this.moveKeyY);
        } // left
        if (leftKeyPressed == true) {
            image(leftKey[1], this.moveKeyX - width / 12, this.moveKeyY);
        } else {
            image(leftKey[0], this.moveKeyX - width / 12, this.moveKeyY);
        } // right
        if (rightKeyPressed == true) {
            image(rightKey[1], this.moveKeyX + width / 12, this.moveKeyY);
        } else {
            image(rightKey[0], this.moveKeyX + width / 12, this.moveKeyY);
        }
    }

    interact() {
        // gere la barre despacement pour l'interaction
        // barre d'espacement
        if (
            joueur.isTechClose == true ||
            distanceToCD < 100 ||
            (technologies[5].highResPosY > -100 &&
                isWalkmanDone &&
                isCdPlayerDone &&
                isPagerDone &&
                isPhoneDone &&
                isRadioDone)
        ) {
            if (spaceKeyPressed == true) {
                image(spaceKey[1], width / 2 - 150, this.moveKeyY);
            }
            if (spaceKeyPressed == false) {
                image(spaceKey[0], width / 2 - 150, this.moveKeyY);
            }
        } // texte
        
        for (let tech of technologies) {
            if (tech.highResDisplayed && tech != technologies[5]) {
                textAlign(CENTER);
                textFont(coffeeMilk, this.txtSz);
                fill(brunLettrage);
                text(interactionSourisUi, width / 2 + 2, height / 8 + 2);
                fill(beigeLettrage);
                text(interactionSourisUi, width / 2, height / 8);
            }
        }
    }

    menuDisplay() {
        // interaction
        this.btnSurvol(); // menu arriere plan
        let menuX = 0;
        let menuY = 0;
        if (menuImgIndex == 1) {
            menuX = 100;
            menuY = 150;
        } else {
            menuX = 0;
            menuY = 0;
        }
        image(menuBg[menuImgIndex], menuX, menuY); // afficher les boutons
        if (menuImgIndex == 0) {
            // bouton joué
            image(
                playBtn[playBtnImgIndex],
                width / 2 - btnW / 2,
                height / 2 - btnH / 2
            ); // bouton quitté
            image(
                quitBtn[quitBtnImgIndex],
                width / 2 - btnW / 2,
                (height / 3) * 2 - btnH / 2
            );
        }
    }

    btnSurvol() {
        if (mouseX > width / 2 - btnW / 2 && mouseX < width / 2 + btnW / 2) {
            // play
            if (
                mouseY > height / 2 - btnH / 2 &&
                mouseY < height / 2 + btnH / 2
            ) {
                playBtnImgIndex = 1;
            } else {
                playBtnImgIndex = 0;
            } // quit
            if (
                mouseY > (height / 3) * 2 - btnH / 2 &&
                mouseY < (height / 3) * 2 + btnH / 2
            ) {
                quitBtnImgIndex = 1;
            } else {
                quitBtnImgIndex = 0;
            }
        }
    }
}

function preload() {
    sonClicInteraction = loadSound("sons/clic_interaction.wav");
    coffeeMilk = loadFont("data/Coffeemilk.otf");
    mtnImg = loadImage("img/plantes/cliff-02.png");
    sonArriere_01 = loadSound("sons/bs_02.wav");
    sonCd = loadSound("sons/cd_01.wav");
    sonPager = loadSound("sons/pager_01.wav");
    sonPhone = loadSound("sons/phone_01.wav");
    sonRadio = loadSound("sons/radio_01.wav");
    sonWalkman = loadSound("sons/walkman_01.wav");
    sonTV1 = loadSound("sons/tv_fin_01.wav");
    sonTV2 = loadSound("sons/tv_fin_02.wav");
    sonTV3 = loadSound("sons/tv_fin_03.wav");
    sonVictoire = loadSound("sons/bs_fin.wav");

    // Load UI images
    for (let i = 1; i <= 2; i++) {
        upKey[i - 1] = loadImage("img/ui/up_0" + i + ".png");
        downKey[i - 1] = loadImage("img/ui/down_0" + i + ".png");
        leftKey[i - 1] = loadImage("img/ui/left_0" + i + ".png");
        rightKey[i - 1] = loadImage("img/ui/right_0" + i + ".png");
        spaceKey[i - 1] = loadImage("img/ui/space_0" + i + ".png");
        menuBg[i - 1] = loadImage("img/ui/menu_0" + i + ".png");
        playBtn[i - 1] = loadImage("img/ui/play-button-0" + i + ".png");
        quitBtn[i - 1] = loadImage("img/ui/quit-button-0" + i + ".png");
    }

    // Load plant images
    for (let i = 1; i <= 7; i++) { // Assuming there are 5 plant images
        plantesImage[i - 1] = loadImage("img/plantes/plante-0" + i + ".png");
    }

    // Load CD player images
    for (let i = 1; i <= 5; i++) { // Assuming there are 5 CD player images
        cdPlayerImages[i - 1] = loadImage("img/technologies/cdplayer/cdplayer-" + i + ".png");
        cdPlayerImagesHighRes[i - 1] = loadImage("img/technologies/cdplayer/cdplayer-" + i + ".png");
    }

    // Load pager images
    for (let i = 1; i <= 6; i++) { // Assuming there are 6 pager images
        pagerImages[i - 1] = loadImage("img/technologies/pager/pager-" + i + ".png");
        pagerImagesHighRes[i - 1] = loadImage("img/technologies/pager/pager-" + i + ".png");
    }

    // Load phone images
    for (let i = 1; i <= 13; i++) { // Assuming there are 13 phone images
        phoneImages[i - 1] = loadImage("img/technologies/phone/phone-" + i + ".png");
        phoneImagesHighRes[i - 1] = loadImage("img/technologies/phone/phone-" + i + ".png");
    }

    // Load radio images
    for (let i = 1; i <= 8; i++) { // Assuming there are 8 radio images
        radioImages[i - 1] = loadImage("img/technologies/radio/radio-" + i + ".png");
        radioImagesHighRes[i - 1] = loadImage("img/technologies/radio/radio-" + i + ".png");
    }

    // Load walkman images
    for (let i = 1; i <= 2; i++) { // Assuming there are 2 walkman images
        walkmanImages[i - 1] = loadImage("img/technologies/walkman/walkman-" + i + ".png");
        walkmanImagesHighRes[i - 1] = loadImage("img/technologies/walkman/walkman-" + i + ".png");
    }

    for (let i = 1; i <= 12; i++) { 
        tvsImages[i - 1] = loadImage("img/technologies/tvs/tvs-" + i + ".png");
        tvsImagesHighRes[i - 1] = loadImage("img/technologies/tvs/tvs-" + i + ".png");
    }
}


function setup() {
    // général
    createCanvas(1000, 800); // donne la grosseur à la fenêtre
    noir = color(49, 1, 11);
    rouge = color(239, 60, 92);
    jaune = color(234, 234, 40);
    vert = color(34, 216, 100);
    vert_foncee = color(68, 123, 28);
    bleu = color(37, 89, 161);
    bleu_pale = color(236, 248, 252);
    blanc = color(255, 255, 255);
    beigeLettrage = color(241, 166, 86);
    brunLettrage = color(151, 60, 27);

    background(noir); // ui

    // // font
    // // objet
    ui = new Ui(); // // move
    // // // up
    for (let i = 1; i <= upKey.length; i++) {
        upKey[i - 1].resize(resizer, resizer);
    } // // // down
    for (let i = 1; i <= downKey.length; i++) {
        downKey[i - 1].resize(resizer, resizer);
    } // // // left
    for (let i = 1; i <= leftKey.length; i++) {
        leftKey[i - 1].resize(resizer, resizer);
    } // // // right
    for (let i = 1; i <= rightKey.length; i++) {
        rightKey[i - 1].resize(resizer, resizer);
    } // // interact
    for (let i = 1; i <= rightKey.length; i++) {
        spaceKey[i - 1].resize(resizer * 3, resizer);
    } // // menu image
    // // // arriere plan
    for (let i = 1; i <= menuBg.length; i++) {} // // // boutons
    for (let i = 1; i <= playBtn.length; i++) {
        playBtn[i - 1].resize(btnW, btnH);
        quitBtn[i - 1].resize(btnW, btnH);
    } // jardin
    jardinLength = height * 2; // calcul la valeur pour la longueur du jardin
    jardinY = height - jardinLength; // calcul la valeur y du jardin
    // // objet
    jardin = new Jardin(); // joueur
    // // position
    pX = width / 2; // donne une valeur initial à la variable pX
    pY = (height / 4) * 3; // donne une valeur initial à la variable pY
    // // objet
    joueur = new Joueur(pX, pY, pS); // crée un instence de l'objet joueur
    // mtn
    mtnW = width / 3;
    mtnH = 200;
    mtnImg.resize(mtnW, mtnH); // plantes
    // // images
    for (let i = 1; i <= plantesImage.length; i++) {
        // charge les images dans le tableau d'images
        plantesImage[i - 1].resize(resizer, resizer);
    } // // objets
    // crée une quantité d'objet plante
    offsetValueX = int(random(planteOffsetX * -1, planteOffsetX));
    offsetValueY = int(random(planteOffsetY * -1, planteOffsetY));
    plantes = new Plante(offsetValueX, offsetValueY); // music
    // // musique de fond
    // charge le son dans la variable
    sonArriere_01.play(); // fait jouer le son
    sonArriere_01.loop(); // fait rejouer le son une fois que ce oson a terminer de jouer
    // // technologies
    // // interaction
    //images
    //Mettre les images dans des tableaux afin de choisir les images selon l'interaction
    
       for (let i = 0; i < cdPlayerImages.length; i++) {
        if (cdPlayerImages[i]) {
            cdPlayerImages[i].resize(resizer, resizer);
        } else {
            console.error("cdPlayerImages[" + i + "] is not loaded");
        }
        if (cdPlayerImagesHighRes[i]) {
            cdPlayerImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
        } else {
            console.error("cdPlayerImagesHighRes[" + i + "] is not loaded");
        }
    }
    
    technologies[0] = new Technologie(cdPlayerImages, cdPlayerImagesHighRes, 0); // crée un objet technologie
    
    for (let i = 0; i < pagerImages.length; i++) {
        pagerImages[i].resize(resizer, resizer);
        pagerImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
    }
    
    technologies[1] = new Technologie(pagerImages, pagerImagesHighRes, 0);
    
    for (let i = 0; i < phoneImages.length; i++) {
        phoneImages[i].resize(resizer, resizer);
        phoneImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
    }

    technologies[2] = new Technologie(phoneImages, phoneImagesHighRes, 0);
    
    for (let i = 0; i < radioImages.length; i++) {
        radioImages[i].resize(resizer, resizer);
        radioImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
    }

    technologies[3] = new Technologie(radioImages, radioImagesHighRes, 0);
    
    for (let i = 0; i < walkmanImages.length; i++) {
        walkmanImages[i].resize(resizer, resizer);
        walkmanImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
    }

    technologies[4] = new Technologie(walkmanImages, walkmanImagesHighRes, 0);
    
    for (let i = 0; i < tvsImages.length; i++) {
        tvsImages[i].resize(resizer, resizer);
        tvsImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
    }
    
    technologies[5] = new Technologie(tvsImages, tvsImagesHighRes,  0);
    
    walkman = technologies[4]; // Déclare l'objet Walkman
    pager = technologies[1]; // Idem
    phone = technologies[2];
    radio = technologies[3];
    cdPlayer = technologies[0];
    tvs = technologies[5];

    for (let i = 0; i < technologies.length - 1; i++) {
        // Boucle pour les 5 premières technologies
        if (i != 5) {
            // Sauf pour la dernière technologie
            let isTooClose;
            do {
                isTooClose = false; // Générer une position aléatoire pour la technologie
                randomX = int(random(50, width - 50));
                randomY = int(random(jardinY + 100, jardinY + jardinLength)); // Calculer la distance entre la technologie et les autres technologies
                for (let j = 0; j < i; j++) {
                    if (typeof technologies[j].posX === 'undefined' || typeof technologies[j].posY === 'undefined') {
                        console.error(`technologies[${j}].posX or technologies[${j}].posY is not defined`);
                        continue;
                    }
                    let distance = dist(
                        randomX,
                        randomY,
                        technologies[j].posX,
                        technologies[j].posY
                    );
                    if (distance < 200) {
                        // Si la distance est inférieure à 500 pixels
                        isTooClose = true;
                        break;
                    }
                }
            } while (isTooClose); // Répéter la génération de position aléatoire jusqu'à ce que la technologie soit assez éloignée des autres
            // Mettre la position aléatoire à la technologie
            technologies[i].setPosition(randomX, randomY);
        }
    }

    let isCDTooClose; // Vérifier si le CD est trop proche des autres technologies

    do {
        isCDTooClose = false; // Initialiser la variable à faux
        if (random(1) < 0.5) {
            // 50% de chance de choisir le tiers gauche de l'écran
            randomXCD = int(random(100, width / 3 - 100));
        } else {
            // 50% de chance de choisir le tiers droit de l'écran
            randomXCD = int(random((2 * width) / 3 + 50, width - 100));
        }
        randomYCD = int(random(jardinY + 100, jardinY + jardinLength)); // Vérifier la distance entre le CD et les autres technologies
        
        for (let i = 0; i < technologies.length - 1; i++) {
            if (typeof technologies[i].posX === 'undefined' || typeof technologies[i].posY === 'undefined') {
                console.error(`technologies[${i}].posX or technologies[${i}].posY is not defined`);
                continue;
            }
            let distance = dist(
                randomXCD,
                randomYCD,
                technologies[i].posX,
                technologies[i].posY
            );
            if (distance < 600) {
                // Si la distance est inférieure à 500 pixels
                isCDTooClose = true;
                break;
            }
        }
    } while (isCDTooClose);
}



function draw() {
    // général
    background(noir);
    if (isGameOn != false) {
        // général
        fill(bleu);
        rect(
            tvs.highResPosX - width,
            tvs.highResPosY,
            width * 2,
            height / 1.88
        );

        distanceToCD = dist(joueur.x, joueur.y, randomXCD, randomYCD); // jardin
        // // plantes
        jardin.display(); // Afficher les technologies

        for (let tech of technologies) {
            tech.display(joueur, tech.posX, tech.posY);
        }

        if (distanceToCD < 100 && spaceKeyPressed) {
            // Si le joueur est en collision avec le CD
            isCDPickedUp = true; // Ramasser le CD
        }

        if (!isRadioDone) {
            radio.isRadioClicked(mouseX, mouseY);
        }

        if (isCDPickedUp) {
            if (cdPlayer.techImages[4] != null) {
                image(cdPlayer.techImages[4], 0, 0); // Afficher le CD
            }
        } else {
            if (cdPlayer.techImages[4] != null) {
                image(cdPlayer.techImages[4], randomXCD, randomYCD); // Afficher le CD
            }
        } 
        
        /* if(isWalkmanDone && isCdPlayerDone && isPagerDone && isPhoneDone && isRadioDone){
     sonArriere_01.stop();
     sonVictoire.play(); // Ca bug ca
     tvs.imageIndex = 1;
     } CA BUG MAIS JE SAIS POURQUOI JARRANGERAIS LATER*/


        if (
            tvs.highResPosY > -100 &&
            tvs.imageIndex >= 1 &&
            tvs.imageIndex < 9 &&
            isWalkmanDone &&
            isCdPlayerDone &&
            isPagerDone &&
            isPhoneDone &&
            isRadioDone
        ) {
            //Si assez de temps est passé, changer l'image de la télévision
            if (millis() - tvsLastChange >= tvsChangeInterval) {
                // Changer l'image de la télévision et réinitialiser le temps
                tvs.imageIndex += 1;
                tvsLastChange = millis();
                sonTV1.play();
            }
        } else if (tvs.imageIndex == 9 && mouseJustPressed) {
            tvs.imageIndex = 10;
            sonTV1.stop();
            sonTV2.play();
        }
        joueur.display();
        ui.display();
    } else {
        ui.menuDisplay();
    }
}



function keyPressed() {
    if (key == " ") {

        // Si la touche espace est pressée
        for (let tech of technologies) {
            // Pour chaque technologie
            tech.spacePressed = true; // Activer l'interaction
        }
        if (distanceToCD < 100) {
            // Si le joueur est en collision avec le CD
            isCDPickedUp = true; // Ramasser le CD
        }
        if (
            technologies[5].highResPosY > -100 && isWalkmanDone && isCdPlayerDone && isPagerDone && isPhoneDone && isRadioDone) 
            {
            sonTV1.play();
            tvs.imageIndex = 1;
            sonVictoire.stop();
        }
    }

}

function keyReleased() {
    if (key == " ") {
        for (let tech of technologies) {
            tech.spacePressed = false;
        }
    }
} // click de souris

function mousePressed() {
    sonClicInteraction.play(); // Joue le son de l'interaction
    mouseJustPressed = true;
    if (isGameOn != false) {
        if (walkman.isPointInHighResImage(mouseX, mouseY)) {
            walkman.imageIndex = 1; // Change l'image du Walkman à la deuxième image
            sonWalkman.play(); // Joue le son du Walkman
            isWalkmanDone = true; // Le Walkman est terminé
        }
        if (cdPlayer.isPointInHighResImage(mouseX, mouseY) &&isCDPickedUp && cdPlayer.imageIndex != 3) {
            //Si le CD est ramassé et que l'image du Cdplayer n'est pas la 4e image et que la souris est sur l'image du Cdplayer
            cdPlayer.imageIndex += 1; // Change l'image du Cdplayer à la prochaine image si le CD est ramassé
            if (cdPlayer.imageIndex == 1) {
                cdPlayer.techImages[4] = null; // Enlève l'image du CD
            }
            if (cdPlayer.imageIndex == 3) {
                sonCd.play(); // Joue le son du CD
                isCdPlayerDone = true; // Le CdPlayer est terminé
            }
        }
        if (
            phone.isPointInHighResImage(mouseX, mouseY) &&
            phone.imageIndex != 12
        ) {
            phone.imageIndex += 1; // Change l'image du Phone à la prochaine image
            if (phone.imageIndex == 12) {
                isPhoneDone = true; // Le Phone est terminé
                sonPhone.play(); // Joue le son du Phone
            }
        }
        pager.isButtonClicked(mouseX, mouseY); // Vérifie si le bouton de la technologie Pager est cliqué
        //Si la souris est sur l'image de la télévision et que la souris est cliquée, faire jouer le son et la vidéo de fin
        if (
            tvs.isPointInHighResImage(mouseX, mouseY) &&
            tvs.imageIndex == 10 &&
            isWalkmanDone &&
            isCdPlayerDone &&
            isPagerDone &&
            isPhoneDone &&
            isRadioDone
        ) {
            tvs.imageIndex = 11;
            sonTV3.play();
            fin();
        }
    } else {
        if (menuImgIndex == 0) {
            if (
                mouseX > width / 2 - btnW / 2 &&
                mouseX < width / 2 + btnW / 2
            ) {
                // play
                if (
                    mouseY > height / 2 - btnH / 2 &&
                    mouseY < height / 2 + btnH / 2
                ) {
                    menuImgIndex = 1;
                } // quit
                if (
                    mouseY > (height / 3) * 2 - btnH / 2 &&
                    mouseY < (height / 3) * 2 + btnH / 2
                ) {
                   // exit(); // ferme l'application
                }
            }
        } else if (menuImgIndex == 1) {
            isGameOn = true;
        }
    }
}

function mouseReleased() {
    mouseJustPressed = false;
} //fin

function fin() {
    isGameOn = false;
    menuImgIndex = 0;
    isCdPlayerDone = false;
    isPagerDone = false;
    isPhoneDone = false;
    isRadioDone = false;
    isWalkmanDone = false;
    isCDPickedUp = false;
    tvs.imageIndex = 0; 
    cdPlayer.imageIndex = 0;
    pager.imageIndex = 0;
    phone.imageIndex = 0;
    radio.imageIndex = 0;
    walkman.imageIndex = 0;// tout ce que tu a reset
}