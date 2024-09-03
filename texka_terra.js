// Variables
let resizer = 100;
let resizerHighRes = 600;
let collisionRadius = 100;

// Colors
let noir, rouge, jaune, vert, vert_foncee, bleu, bleu_pale, blanc, beigeLettrage, brunLettrage;

let sonClicInteraction;
let sonArriere_01, sonArriere_02, sonArriere_03;
let sonCd, sonPager, sonPhone, sonRadio, sonWalkman;
let sonVictoire, sonTV1, sonTV2, sonTV3;
let coffeeMilk;

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
let tvsImagesHighRes = [];

// Booleans
let isGameOn = false;

// Player position and movement
let pX, pY, pS = 10;
let upKeyPressed = false;
let downKeyPressed = false;
let leftKeyPressed = false;
let rightKeyPressed = false;
let spaceKeyPressed = false;
let mouseJustPressed = false;

// Scrolling
let pTop = false;
let pBot = false;

// Garden positioning
let jardinLength;
let jardinY;
let jardinYSubDiv = 30;
let jardinXSubDiv = 26;
let jardinPosXMatrix, jardinPosYMatrix, jardinImgMatrix, jardinPerspSize;

// Mountain
let mtnW, mtnH;
let mtnImg;

// Plant variables
let planteOffsetX = 20;
let planteOffsetY = 10;
let offsetValueX, offsetValueY;
let planteX, planteY;


// Technology variables
let randomXCD, randomYCD, randomX, randomY;
let tvsLastChange = 0;
let tvsChangeInterval = 1000;
let isCdPlayerDone = false, isPagerDone = false, isPhoneDone = false, isRadioDone = false, isWalkmanDone = false;
let isCDPickedUp = false, isTechZoom = false;
let distanceToCD;

// Video
let theEnd;
let isVideoStarted = false;

class Technologie {
    constructor(techImages, highResTechImages, imageIndex) {
        this.posX = 0;
        this.posY = 0;
        this.highResPosX = 0;
        this.highResPosY = 0;
        this.techImages = techImages;
        this.highResTechImages = highResTechImages;
        this.imageIndex = imageIndex;
        this.spacePressed = false;
        this.spaceWasPressed = false;
        this.highResDisplayed = false;
        this.buttonsPager = [
            new Button(335, 456, 75, 75, 1),
            new Button(439, 458, 75, 75, 2),
            new Button(532, 456, 75, 75, 3),
            new Button(639, 467, 75, 75, 4)
        ];
        this.buttonOrderPager = [3, 4, 4, 2, 1, 3, 4, 2, 3, 1, 2];
        this.currentOrderPagerIndex = 0;
        this.buttonsRadio = [
            new Button(467, 455, 15, 15, 0),
            new Button(499, 455, 15, 15, 1),
            new Button(522, 455, 15, 15, 2),
            new Button(545, 455, 15, 15, 3),
            new Button(576, 455, 15, 15, 4),
            new Button(610, 455, 15, 15, 5),
            new Button(638, 455, 15, 15, 6)
        ];
    }

    setPosition(x, y) {
        if (this.imageIndex != 5 && (x < width / 3 || x > 2 * width / 3)) {
            this.posX = x;
        } else if (this.imageIndex == 5) {
            this.posX = x;
        }
        this.posY = y;
    }

    move(dx, dy) {
        let newX = this.posX + dx;
        if (newX < width / 3 || newX > 2 * width / 3) {
            this.posX = newX;
        }
        this.posY += dy;
    }

    display(joueur, posX, posY) {
        let newWidth = this.highResTechImages[this.imageIndex].width;
        let newHeight = this.highResTechImages[this.imageIndex].height;

        this.highResPosX = width / 2 - newWidth / 2;
        this.highResPosY = height / 2 - newHeight / 2;

        if (this === technologies[5]) {
            this.highResDisplayed = true;
            this.highResPosX = width / 5;
            this.highResPosY = this.posY + (-jardinLength) + jardinLength / 12.5;
        }

        if (this.spacePressed && !this.spaceWasPressed && this !== technologies[5]) {
            if (this.isCollidingWithPlayer(joueur, collisionRadius) || this.highResDisplayed) {
                this.highResDisplayed = !this.highResDisplayed;
            }
        }

        if (this.highResDisplayed) {
            image(this.highResTechImages[this.imageIndex], this.highResPosX, this.highResPosY, newWidth, newHeight);
        } else {
            image(this.techImages[this.imageIndex], posX, posY);
        }

        this.spaceWasPressed = this.spacePressed;
    }

    isCollidingWithPlayer(joueur, collisionRadius) {
        let techCenterX = this.posX + this.techImages[this.imageIndex].width / 2;
        let techCenterY = this.posY + this.techImages[this.imageIndex].height / 2;
        return dist(techCenterX, techCenterY, joueur.x, joueur.y) <= collisionRadius;
    }

    isPointInHighResImage(x, y) {
        if (!this.highResDisplayed) {
            return false;
        }

        let newWidth = this.highResTechImages[this.imageIndex].width;
        let newHeight = this.highResTechImages[this.imageIndex].height;
        let highResPosX = width / 2 - newWidth / 2;
        let highResPosY = height / 2 - newHeight / 2;

        return x >= highResPosX && x <= highResPosX + newWidth && y >= highResPosY && y <= highResPosY + newHeight;
    }

    isButtonClicked(x, y) {
        if (this.currentOrderPagerIndex === this.buttonOrderPager.length) {
            return false;
        }

        for (let button of this.buttonsPager) {
            if (button.isMouseInside(x, y) && !isPagerDone) {
                if (button.order === this.buttonOrderPager[this.currentOrderPagerIndex]) {
                    this.currentOrderPagerIndex++;
                    if (this.currentOrderPagerIndex === this.buttonOrderPager.length) {
                        this.imageIndex = 5;
                        isPagerDone = true;
                        sonPager.play();
                    } else {
                        this.imageIndex = button.order;
                    }
                } else {
                    this.currentOrderPagerIndex = 0;
                    this.imageIndex = 0;
                }
                return true;
            }
        }
        return false;
    }

    isRadioClicked(x, y) {
        for (let button of this.buttonsRadio) {
            if (button.isMouseInside(x, y) && !isRadioDone) {
                if (button.order === 5) {
                    this.imageIndex = 7;
                    sonRadio.play();
                    isRadioDone = true;
                    return true;
                }
                this.imageIndex = button.order;
                console.log(button.order);
                console.log(this.imageIndex);
                return true;
            }
        }
        return false;
    }
}

class Button {
    constructor(x, y, width, height, order) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.order = order;
    }

    isMouseInside(px, py) {
        return px >= this.x - this.width / 2 && px <= this.x + this.width / 2 &&
               py >= this.y - this.height / 2 && py <= this.y + this.height / 2;
    }
}


class Joueur {
    // Constructor
    constructor(x, y, s) {
      this.x = x; // Position x
      this.y = y; // Position y
      this.xSpeed = s; // Speed in x direction
      this.ySpeed = s; // Speed in y direction
      this.radius = 20; // Player radius
      this.isTechClose = false; // True when a technology is within 200px
      this.distTechJoueur = 0; // Distance between player and technology
    }
  
    // Method to display the player
    display() {
      this.move(); // Call move method
      this.interact(); // Call interact method
  
      // Draw the player
      fill(255);
      noStroke();
      circle(this.x, this.y, this.radius);
    }
  
    // Method to move the player
    move() {
      if (keyIsPressed) {
        if (keyCode === UP_ARROW) { // Move up
          if (this.y > height / 5) {
            this.y -= this.ySpeed;
          }
          upKeyPressed = true;
        } else if (keyCode === DOWN_ARROW) { // Move down
          if (this.y < (height / 5) * 4) {
            this.y += this.ySpeed;
          }
          downKeyPressed = true;
        } else if (keyCode === LEFT_ARROW) { // Move left
          this.x -= this.xSpeed;
          leftKeyPressed = true;
        } else if (keyCode === RIGHT_ARROW) { // Move right
          this.x += this.xSpeed;
          rightKeyPressed = true;
        }
      } else {
        upKeyPressed = false;
        downKeyPressed = false;
        leftKeyPressed = false;
        rightKeyPressed = false;
      }
  
      // Handle screen scrolling
      pTop = this.y <= height / 5;
      pBot = this.y >= (height / 5) * 4;
    }
  
    // Method to interact with technologies
    interact() {
      for (let i = 0; i < technologies.length; i++) { // Loop through all technologies
        this.distTechJoueur = dist(this.x, this.y, technologies[i].posX, technologies[i].posY); // Calculate distance between player and technology
  
        if (this.distTechJoueur < 80) { // If player is within 80px of a technology
          this.isTechClose = true;
          if (keyIsPressed && key === ' ') { // Check if space key is pressed
            spaceKeyPressed = true;
          } else {
            spaceKeyPressed = false;
          }
          break; // Exit loop if technology is close
        } else {
          this.isTechClose = false;
        }
      }
    }
  }

  class Plante {
    constructor(offsetValueX, offsetValueY) {
      // Initialize the offset with a random value within the given range
      this.offsetX = int(random(-offsetValueX, offsetValueX));
      this.offsetY = int(random(-offsetValueY, offsetValueY));
      this.posX = 0;
      this.posY = 0;
    }
  
    // Method to display the plant image at the updated position
    display(i, x, y) {
      this.updatePosition(x, y); // Update the position of the plant
      image(plantesImage[i], this.posX, this.posY); // Display the image at the calculated position
    }
  
    // Method to calculate the new position with an offset
    posOffset(a, offset) {
      return a + offset;
    }
  
    // Update the position of the plant with the offset
    updatePosition(x, y) {
      this.posX = this.posOffset(x, this.offsetX);
      this.posY = this.posOffset(y, this.offsetY);
    }
  
    // Update the size of the plant image
    updateSize(i, a) {
      let w, h;
  
      // Determine the new width and height based on the given size modifier `a`
      if (a > 0) {
        w = resizer + a;
        h = resizer + a;
      } else if (a === 0) {
        w = resizer;
        h = resizer;
      } else {
        w = 1;
        h = 1;
      }
  
      plantesImage[i].resize(w, h); // Resize the plant image
    }
  }

 class Jardin {
      constructor() {
        this.jardinPosXMatrix = [];
        this.jardinPosYMatrix = [];
        this.jardinImgMatrix = [];
        this.layoutMatrix();
      }
    
      display() {
        this.scrolling();
    
        // Mountains
        for (let j = 0; j < jardinYSubDiv; j++) {
          if (j === jardinYSubDiv / 3) {
            this.displayMtn(0, jardinLength / 3 + jardinY);                    
            this.displayMtn(width - mtnW, jardinLength / 3 + jardinY);
          } else if (j === (jardinYSubDiv / 3) * 2) {
            this.displayMtn(0, ((jardinLength / 3) * 2) + jardinY);
            this.displayMtn(width - mtnW, ((jardinLength / 3) * 2) + jardinY);
          }
        }
    
        // Loops
        for (let k = 0; k < jardinXSubDiv; k++) {
          for (let j = 0; j < jardinYSubDiv; j++) {
            // Plants
            // Masking
            // Limit to the top of the mountain
            if (this.jardinPosYMatrix[k][j] + jardinY >= jardinY) {
              // Limits for the path
              if (this.jardinPosXMatrix[k][j] <= width / 3 || this.jardinPosXMatrix[k][j] >= ((width / 3) * 2) - 20) {
                // Limits for the cliffs of the mountains
                if (this.jardinPosYMatrix[k][j] + jardinY >= jardinLength / 3 + jardinY && this.jardinPosYMatrix[k][j] + jardinY <= jardinLength / 3 + mtnH + jardinY) {
                  // Do nothing
                } else if (this.jardinPosYMatrix[k][j] + jardinY >= ((jardinLength / 3) * 2) + jardinY && this.jardinPosYMatrix[k][j] + jardinY <= ((jardinLength / 3) * 2) + mtnH + jardinY) {
                  // Hello
                } else {
                  // Display plants
                  plantes.updateSize(this.jardinImgMatrix[k][j], 0);
                  plantes.display(this.jardinImgMatrix[k][j], this.jardinPosXMatrix[k][j], this.jardinPosYMatrix[k][j] + jardinY); // Call the display method of the plant objects
    
                  // Debug UI
                  if (jardinDebugUi === true) {
                    textSize(25);
                    fill('white');
                    text(`(${k}, ${j}, ${this.jardinImgMatrix[k][j]})`, this.jardinPosXMatrix[k][j], this.jardinPosYMatrix[k][j] + jardinY);
                    text(`(${this.jardinPosXMatrix[k][j]}, ${this.jardinPosYMatrix[k][j]})`, this.jardinPosXMatrix[k][j], this.jardinPosYMatrix[k][j] + jardinY + 25);
                  }
                }
              }
            }
          }
        }
      }
    
      // Handles the scrolling of the garden
      scrolling() {
        if (jardinY <= height / 6 * 5) {
          if (pTop === true && upKeyPressed === true) { 
            jardinY += int(pS);
            randomYCD += int(pS);
            for (let tech of technologies) {
              tech.move(0, int(pS)); // Move technologies down
            }
          } 
        }
        if (jardinY >= height * -1.1) {
          if (pBot === true && downKeyPressed === true) {
            jardinY -= int(pS);
            randomYCD -= int(pS);
            for (let tech of technologies) {
              tech.move(0, -int(pS)); // Move technologies up
            }
          }
        }
      }
      
      // Index for plant images
      layoutMatrix() {
        // Initialize the matrix
        let x = ((width / jardinXSubDiv) / 2) * -1;
        let y = jardinY;
        let imageIndex;
    
        // Initialize the 2D arrays
        for (let k = 0; k < jardinXSubDiv; k++) {
          this.jardinPosXMatrix[k] = [];
          this.jardinPosYMatrix[k] = [];
          this.jardinImgMatrix[k] = [];
        }
    
        // Matrix
        for (let k = 0; k < jardinXSubDiv; k++) {
          for (let j = 0; j < jardinYSubDiv; j++) {
            // X position
            if (x >= width - (width / jardinXSubDiv) / 2) {
              x = ((width / jardinXSubDiv) / 2) * -1;
            }
    
            this.jardinPosXMatrix[k][j] = (x + planteOffsetX) - 20;
    
            x += (width / jardinXSubDiv) + int(random(planteOffsetX * -1, planteOffsetX));
            
            // Y position
            if (y > jardinLength) {
              y = jardinY;
            }
    
            this.jardinPosYMatrix[k][j] = (y - planteOffsetY) - 20;
    
            if (j === int(jardinYSubDiv / 3) || j === int((jardinYSubDiv / 3) * 2)) {
              y = (k * (jardinLength / jardinYSubDiv)) + int(random(planteOffsetY * -1, planteOffsetY)) + 100;
            } else {
              y = (k * (jardinLength / jardinYSubDiv)) + int(random(planteOffsetY * -1, planteOffsetY));
            }               
    
            // Image index
            imageIndex = int(random(7));
            this.jardinImgMatrix[k][j] = imageIndex; 
          }
        }
      }
    
      // Displays the mountains
      displayMtn(x, y) {
        image(mtnImg, x, y + 50);
      } 
    }

  class Ui {
    constructor() {
        // Position
        this.moveKeyX = width / 6 * 5;
        this.moveKeyY = height / 6 * 5;
        this.txtSz = 36;
    }

    display() { // For displaying the UI
        this.move();
        this.interact();
    }

    move() { // Handles the movement keys
        // Up
        if (upKeyPressed) {
            image(upKey[1], this.moveKeyX, this.moveKeyY - width / 12); 
        } else {
            image(upKey[0], this.moveKeyX, this.moveKeyY - width / 12);
        }

        // Down
        if (downKeyPressed) {
            image(downKey[1], this.moveKeyX, this.moveKeyY);
        } else {
            image(downKey[0], this.moveKeyX, this.moveKeyY);
        }

        // Left
        if (leftKeyPressed) {
            image(leftKey[1], this.moveKeyX - width / 12, this.moveKeyY);
        } else {
            image(leftKey[0], this.moveKeyX - width / 12, this.moveKeyY);
        }

        // Right
        if (rightKeyPressed) {
            image(rightKey[1], this.moveKeyX + width / 12, this.moveKeyY);
        } else {
            image(rightKey[0], this.moveKeyX + width / 12, this.moveKeyY);
        }
    }

    interact() { // Handles the interaction bar
        // Space bar
        if (joueur.isTechClose || distanceToCD < 100 || (technologies[5].highResPosY > -100 && isWalkmanDone && isCdPlayerDone && isPagerDone && isPhoneDone && isRadioDone)) {
            if (spaceKeyPressed) {
                image(spaceKey[1], width / 2 - 150, this.moveKeyY);
            } else {
                image(spaceKey[0], width / 2 - 150, this.moveKeyY);
            }
        }

        // Text
        for (let tech of technologies) {
            if (tech.highResDisplayed && tech !== technologies[5]) {
                textAlign(CENTER);
                textFont(coffeeMilk);
                textSize(this.txtSz);
                fill(brunLettrage);
                text(interactionSourisUi, width / 2 + 2, height / 8 + 2);
                fill(beigeLettrage);
                text(interactionSourisUi, width / 2, height / 8);
            }
        }
    }

    menuDisplay() {
        // Button hover
        this.btnSurvol();

        // Menu background
        let menuX = 0;
        let menuY = 0;

        if (menuImgIndex === 1) {
            menuX = 100;
            menuY = 150;
        }

        image(menuBg[menuImgIndex], menuX, menuY);

        // Display buttons
        if (menuImgIndex === 0) {
            // Play button
            image(playBtn[playBtnImgIndex], width / 2 - btnW / 2, height / 2 - btnH / 2);
            
            // Quit button
            image(quitBtn[quitBtnImgIndex], width / 2 - btnW / 2, ((height / 3) * 2) - btnH / 2);
        } 
    }

    btnSurvol() {
        if (mouseX > width / 2 - btnW / 2 && mouseX < width / 2 + btnW / 2) {
            // Play
            if (mouseY > height / 2 - btnH / 2 && mouseY < height / 2 + btnH / 2) {
                playBtnImgIndex = 1;
            } else {
                playBtnImgIndex = 0;
            }

            // Quit
            if (mouseY > ((height / 3) * 2) - btnH / 2 && mouseY < ((height / 3) * 2) + btnH / 2) {
                quitBtnImgIndex = 1;
            } else {
                quitBtnImgIndex = 0;
            }
        }
    }
}

function preload() {
  // Load sounds
  sonClicInteraction = loadSound('sons/clic_interaction.wav');
  sonArriere_01 = loadSound("sons/bs_02.wav");
  sonCd = loadSound("sons/cd_01.wav");
  sonPager = loadSound("sons/pager_01.wav");
  sonPhone = loadSound("sons/phone_01.wav");
  sonRadio = loadSound("sons/radio_01.wav");
  sonWalkman = loadSound("sons/walkman_01.wav");
  sonVictoire = loadSound("sons/bs_fin.wav");
  sonTV1 = loadSound("sons/tv_fin_01.wav");
  sonTV2 = loadSound("sons/tv_fin_02.wav");
  sonTV3 = loadSound("sons/tv_fin_03.wav");
  
  // Load fonts
  coffeeMilk = loadFont("data/Coffeemilk.otf");
  
  // Load images for UI
  for (let i = 1; i <= 2; i++) {
      upKey.push(loadImage("img/ui/up_0" + i + ".png"));
      downKey.push(loadImage("img/ui/down_0" + i + ".png"));
      leftKey.push(loadImage("img/ui/left_0" + i + ".png"));
      rightKey.push(loadImage("img/ui/right_0" + i + ".png"));
      spaceKey.push(loadImage("img/ui/space_0" + i + ".png"));
      menuBg.push(loadImage("img/ui/menu_0" + i + ".png"));
      playBtn.push(loadImage("img/ui/play-button-0" + i + ".png"));
      quitBtn.push(loadImage("img/ui/quit-button-0" + i + ".png"));
  }
  
  // Load images for plants
  for (let i = 1; i <= 7; i++) {
      plantesImage.push(loadImage("img/plantes/plante-0" + i + ".png"));
  }
  
  // Function to load images for a given technology
  function loadTechnologyImages(basePath, count) {
      let images = [];
      let highResImages = [];
      for (let i = 0; i < count; i++) {
          images.push(loadImage(`${basePath}-${i + 1}.png`));
          highResImages.push(loadImage(`${basePath}-${i + 1}.png`));
      }
      return { images, highResImages };
  }
  
  // Load images for technologies
  let cdPlayerImagesData = loadTechnologyImages("img/technologies/cdplayer/cdplayer", 5);
  cdPlayerImages = cdPlayerImagesData.images;
  cdPlayerImagesHighRes = cdPlayerImagesData.highResImages;
  
  let pagerImagesData = loadTechnologyImages("img/technologies/pager/pager", 5);
  pagerImages = pagerImagesData.images;
  pagerImagesHighRes = pagerImagesData.highResImages;
  
  let phoneImagesData = loadTechnologyImages("img/technologies/phone/phone", 5);
  phoneImages = phoneImagesData.images;
  phoneImagesHighRes = phoneImagesData.highResImages;
  
  let radioImagesData = loadTechnologyImages("img/technologies/radio/radio", 5);
  radioImages = radioImagesData.images;
  radioImagesHighRes = radioImagesData.highResImages;
  
  let walkmanImagesData = loadTechnologyImages("img/technologies/walkman/walkman", 2); // Only 2 images for walkman
  walkmanImages = walkmanImagesData.images;
  walkmanImagesHighRes = walkmanImagesData.highResImages;
  
  let tvsImagesData = loadTechnologyImages("img/technologies/tvs/tvs", 5);
  tvsImages = tvsImagesData.images;
  tvsImagesHighRes = tvsImagesData.highResImages;
}
    

// Setup function
function setup() {
    // General setup
    createCanvas(1000, 800);
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
  
    background(noir);
  
    upKey.forEach(img => img.resize(100, 100));
    downKey.forEach(img => img.resize(100, 100));
    leftKey.forEach(img => img.resize(100, 100));
    rightKey.forEach(img => img.resize(100, 100));
    spaceKey.forEach(img => img.resize(300, 100));
    playBtn.forEach(img => img.resize(300, 150));
    quitBtn.forEach(img => img.resize(300, 150));
    plantesImage.forEach(img => img.resize(100, 100));
    cdPlayerImages.forEach(img => img.resize(100, 100));
    cdPlayerImagesHighRes.forEach(img => img.resize(600, 600));
    pagerImages.forEach(img => img.resize(100, 100));
    pagerImagesHighRes.forEach(img => img.resize(600, 600));
    phoneImages.forEach(img => img.resize(100, 100));
    phoneImagesHighRes.forEach(img => img.resize(600, 600));
    radioImages.forEach(img => img.resize(100, 100));
    radioImagesHighRes.forEach(img => img.resize(600, 600));
    walkmanImages.forEach(img => img.resize(100, 100));
    walkmanImagesHighRes.forEach(img => img.resize(600, 600));
    tvsImages.forEach(img => img.resize(100, 100));
    tvsImagesHighRes.forEach(img => img.resize(600, 600));
  
    // Initialize UI object
    ui = new Ui();
  
    // Garden setup
    jardinLength = height * 2;
    jardinY = height - jardinLength;
    jardin = new Jardin();
  
    // Player setup
    pX = width / 2;
    pY = (height / 4) * 3;
    joueur = new Joueur(pX, pY, pS);
  
    // Mountain setup
    mtnW = width / 3;
    mtnH = 200;
    mtnImg = loadImage("img/plantes/cliff-02.png");
    mtnImg.resize(mtnW, mtnH);
  
    // Plants setup
    for (let i = 1; i <= plantesImage.length; i++) {
      plantesImage[i - 1] = loadImage("img/plantes/plante-0" + i + ".png");
      plantesImage[i - 1].resize(resizer, resizer);
    }
  
    offsetValueX = int(random(planteOffsetX * -1, planteOffsetX));
    offsetValueY = int(random(planteOffsetY * -1, planteOffsetY));
    plantes = new Plante(offsetValueX, offsetValueY);
  
  
    // Technologies setup
    // Initialize the technologies array
    technologies = [];
  
    // CD Player Images
    cdPlayerImages = [];
    cdPlayerImagesHighRes = [];
    for (let i = 0; i < 5; i++) {
      cdPlayerImages.push(loadImage("img/technologies/cdplayer/cdplayer-" + (i + 1) + ".png"));
      cdPlayerImages[i].resize(resizer, resizer);
  
      cdPlayerImagesHighRes.push(loadImage("img/technologies/cdplayer/cdplayer-" + (i + 1) + ".png"));
      cdPlayerImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
    }
    technologies[0] = new Technologie(cdPlayerImages, cdPlayerImagesHighRes, 0);
  
    // Pager Images
    pagerImages = [];
    pagerImagesHighRes = [];
    for (let i = 0; i < 6; i++) {
      pagerImages.push(loadImage("img/technologies/pager/pager-" + (i + 1) + ".png"));
      pagerImages[i].resize(resizer, resizer);
  
      pagerImagesHighRes.push(loadImage("img/technologies/pager/pager-" + (i + 1) + ".png"));
      pagerImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
    }
    technologies[1] = new Technologie(pagerImages, pagerImagesHighRes, 0);
  
    // Phone Images
    phoneImages = [];
    phoneImagesHighRes = [];
    for (let i = 0; i < 13; i++) {
      phoneImages.push(loadImage("img/technologies/phone/phone-" + (i + 1) + ".png"));
      phoneImages[i].resize(resizer, resizer);
  
      phoneImagesHighRes.push(loadImage("img/technologies/phone/phone-" + (i + 1) + ".png"));
      phoneImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
    }
    technologies[2] = new Technologie(phoneImages, phoneImagesHighRes, 0);
  
    // Radio Images
    radioImages = [];
    radioImagesHighRes = [];
    for (let i = 0; i < 8; i++) {
      radioImages.push(loadImage("img/technologies/radio/radio-" + (i + 1) + ".png"));
      radioImages[i].resize(resizer, resizer);
  
      radioImagesHighRes.push(loadImage("img/technologies/radio/radio-" + (i + 1) + ".png"));
      radioImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
    }
    technologies[3] = new Technologie(radioImages, radioImagesHighRes, 0);
  
    // Walkman Images
    walkmanImages = [];
    walkmanImagesHighRes = [];
    for (let i = 0; i < 2; i++) {
      walkmanImages.push(loadImage("img/technologies/walkman/walkman-" + (i + 1) + ".png"));
      walkmanImages[i].resize(resizer, resizer);
  
      walkmanImagesHighRes.push(loadImage("img/technologies/walkman/walkman-" + (i + 1) + ".png"));
      walkmanImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
    }
    technologies[4] = new Technologie(walkmanImages, walkmanImagesHighRes, 0);
  
    // TVs Images
    tvsImages = [];
    tvsImagesHighRes = [];
    for (let i = 0; i < 12; i++) {
      tvsImages.push(loadImage("img/technologies/tvs/tvs-" + (i + 1) + ".png"));
      tvsImages[i].resize(resizer, resizer);
  
      tvsImagesHighRes.push(loadImage("img/technologies/tvs/tvs-" + (i + 1) + ".png"));
      tvsImagesHighRes[i].resize(resizerHighRes, resizerHighRes);
    }
    technologies[5] = new Technologie(tvsImages, tvsImagesHighRes, 0);
  
    // Assign references for easier access
    walkman = technologies[4];
    pager = technologies[1];
    phone = technologies[2];
    radio = technologies[3];
    cdPlayer = technologies[0];
    tvs = technologies[5];
  
    // Positioning technologies ensuring they are not too close to each other
    for (let i = 0; i < technologies.length - 1; i++) {  // Loop through the first 5 technologies
      if (i !== 5) { // Skip the last technology (TVs)
        let isTooClose;
  
        do {
          isTooClose = false;
  
          // Generate a random position for the technology
          randomX = int(random(50, width - 50));
          randomY = int(random(jardinY + 100, jardinY + jardinLength));
  
          // Calculate the distance between this technology and all previous ones
          for (let j = 0; j < i; j++) {
            let distance = dist(randomX, randomY, technologies[j].posX, technologies[j].posY);
  
            if (distance < 600) {  // If the distance is less than 600 pixels
              isTooClose = true;
              break;
            }
          }
              
        } while (isTooClose); // Repeat until a suitable position is found
  
        // Set the position for the technology
        technologies[i].setPosition(randomX, randomY);
      }
    }
      
    // Position the CD Player technology separately to ensure it's not too close to others
    let isCDTooClose;
    do { 
      isCDTooClose = false; // Initialize the flag to false
          
      if (random(1) < 0.5) { // 50% chance to place in the left third of the screen
        randomXCD = int(random(100, width / 3 - 100));
      } else { // 50% chance to place in the right third of the screen
        randomXCD = int(random(2 * width / 3 + 50, width - 100));
      }
  
      randomYCD = int(random(jardinY + 100, jardinY + jardinLength));
          
      // Check the distance between the CD and all other technologies
      for (let i = 0; i < technologies.length - 1; i++) {
        let distance = dist(randomXCD, randomYCD, technologies[i].posX, technologies[i].posY);
        if (distance < 600) {  // If the distance is less than 600 pixels
          isCDTooClose = true;
          break;
        }
      }
    } while (isCDTooClose);
  
    // Set the position for the CD Player technology
    cdPlayer.setPosition(randomXCD, randomYCD);
}
  


function draw() {
    // général
    background(noir);

    if (isGameOn) {
        // général
        fill(bleu);
        rect(technologies[5].highResPosX - width, technologies[5].highResPosY, width * 2, height / 1.88);
        distanceToCD = dist(joueur.x, joueur.y, randomXCD, randomYCD);

        // jardin
        // // plantes
        jardin.display();

        // Afficher les technologies
        for (let tech of technologies) {
            tech.display(joueur, tech.posX, tech.posY);
        }

        if (distanceToCD < 100 && spaceKeyPressed) { // Si le joueur est en collision avec le CD
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

        if (tvs.highResPosY > -100 && tvs.imageIndex >= 1 && tvs.imageIndex < 9 && isWalkmanDone && isCdPlayerDone && isPagerDone && isPhoneDone && isRadioDone) {
            // Si assez de temps est passé, changer l'image de la télévision 
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
    if (key === ' ') {  // If space bar is pressed
        for (let tech of technologies) { // For each technology
            tech.spacePressed = true;  // Activate interaction
        }

        if (distanceToCD < 100) { // If player is close to the CD
            isCDPickedUp = true; // Pick up the CD
        }

        if (technologies[5].highResPosY > -100 && isWalkmanDone && isCdPlayerDone && isPagerDone && isPhoneDone && isRadioDone) {
            sonTV1.play();
            tvs.imageIndex = 1;
            sonVictoire.stop();
        }
    }  
}

function keyReleased() {
    if (key === ' ') { 
        for (let tech of technologies) { 
            tech.spacePressed = false; 
        }
    }
}

function mousePressed() {
    sonClicInteraction.play(); // Play interaction sound
    mouseJustPressed = true;

    if (isGameOn) {
        if (walkman.isPointInHighResImage(mouseX, mouseY)) {
            walkman.imageIndex = 1;  // Change Walkman image to the second one
            sonWalkman.play(); // Play Walkman sound
            isWalkmanDone = true; // Walkman is done
        }

        if (cdPlayer.isPointInHighResImage(mouseX, mouseY) && isCDPickedUp && cdPlayer.imageIndex !== 3) { // If CD is picked up and CDPlayer image is not the 4th one
            cdPlayer.imageIndex += 1;  // Change CDPlayer image to the next one if CD is picked up
            if (cdPlayer.imageIndex === 1) {
                cdPlayer.techImages[4] = null; // Remove CD image
            }

            if (cdPlayer.imageIndex === 3) {
                sonCd.play(); // Play CD sound
                isCdPlayerDone = true; // CDPlayer is done
            }
        }

        if (phone.isPointInHighResImage(mouseX, mouseY) && phone.imageIndex !== 12) {
            phone.imageIndex += 1;  // Change Phone image to the next one
            if (phone.imageIndex === 12) {
                isPhoneDone = true; // Phone is done
                sonPhone.play(); // Play Phone sound
            }
        }

        pager.isButtonClicked(mouseX, mouseY); // Check if Pager button is clicked
        
        // If mouse is on TV image and clicked, play end sound and video
        if (tvs.isPointInHighResImage(mouseX, mouseY) && tvs.imageIndex === 10 && isWalkmanDone && isCdPlayerDone && isPagerDone && isPhoneDone && isRadioDone) {
            tvs.imageIndex = 11;
            sonTV3.play();
            endGame();
        }
    } else {
        if (menuImgIndex === 0) {
            if (mouseX > width / 2 - btnW / 2 && mouseX < width / 2 + btnW / 2) {
                // Play button
                if (mouseY > height / 2 - btnH / 2 && mouseY < height / 2 + btnH / 2) {
                    menuImgIndex = 1;
                }

                // Quit button
                if (mouseY > ((height / 3) * 2) - btnH / 2 && mouseY < ((height / 3) * 2) + btnH / 2) {
                    noLoop(); // Stops the draw loop
                    exit(); // Exit the application
                }
            }
        } else if (menuImgIndex === 1) {
            isGameOn = true;
        }
    }
}

function mouseReleased() {
    mouseJustPressed = false;
}

// End game function
function endGame() {
    isGameOn = false;
    menuImgIndex = 0;
    isCdPlayerDone = false;
    isPagerDone = false;
    isPhoneDone = false;
    isRadioDone = false;
    isWalkmanDone = false;
    isCDPickedUp = false;
    tvs.imageIndex = 0;
    // Reset other variables if needed
}