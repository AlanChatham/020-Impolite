import processing.video.*;

// Preload images for Processing.js
/* @pjs preload = "Impolite/data/Noses/UpLeft/0.png,
Impolite/data/Noses/UpLeft/1.png,
Impolite/data/Noses/UpLeft/2.png,
Impolite/data/Noses/UpLeft/3.png,
Impolite/data/Noses/UpLeft/4.png,
Impolite/data/Noses/UpCenter/0.png,
Impolite/data/Noses/UpCenter/1.png,
Impolite/data/Noses/UpCenter/2.png,
Impolite/data/Noses/UpCenter/3.png,
Impolite/data/Noses/UpCenter/4.png,
Impolite/data/Noses/UpRight/0.png,
Impolite/data/Noses/UpRight/1.png,
Impolite/data/Noses/UpRight/2.png,
Impolite/data/Noses/UpRight/3.png,
Impolite/data/Noses/UpRight/4.png,
Impolite/data/Noses/CenterLeft/0.png,
Impolite/data/Noses/CenterLeft/1.png,
Impolite/data/Noses/CenterLeft/2.png,
Impolite/data/Noses/CenterLeft/3.png,
Impolite/data/Noses/CenterLeft/4.png,
Impolite/data/Noses/CenterCenter/0.png,
Impolite/data/Noses/CenterCenter/1.png,
Impolite/data/Noses/CenterCenter/2.png,
Impolite/data/Noses/CenterCenter/3.png,
Impolite/data/Noses/CenterCenter/4.png,
Impolite/data/Noses/CenterRight/0.png,
Impolite/data/Noses/CenterRight/1.png,
Impolite/data/Noses/CenterRight/2.png,
Impolite/data/Noses/CenterRight/3.png,
Impolite/data/Noses/CenterRight/4.png,
Impolite/data/Noses/DownLeft/0.png,
Impolite/data/Noses/DownLeft/1.png,
Impolite/data/Noses/DownLeft/2.png,
Impolite/data/Noses/DownLeft/3.png,
Impolite/data/Noses/DownLeft/4.png,
Impolite/data/Noses/DownCenter/0.png,
Impolite/data/Noses/DownCenter/1.png,
Impolite/data/Noses/DownCenter/2.png,
Impolite/data/Noses/DownCenter/3.png,
Impolite/data/Noses/DownCenter/4.png,
Impolite/data/Noses/DownRight/0.png,
Impolite/data/Noses/DownRight/1.png,
Impolite/data/Noses/DownRight/2.png,
Impolite/data/Noses/DownRight/3.png,
Impolite/data/Noses/DownRight/4.png; */

int VerticalFrames = 5;
int HorizontalFrames = 5;

int MAX_FRAMES = 50;

int IMAGES_PER_FOLDER = 5;

int SRC_X = 400;
int SRC_Y = 50;
int SRC_WIDTH = 600;
int SRC_HEIGHT = 750;

int[][] LastImagePositions = new int[MAX_FRAMES][MAX_FRAMES];
int[][] ImageIndexArray = new int[MAX_FRAMES][MAX_FRAMES];
PImage[] UpLeftImages = new PImage[IMAGES_PER_FOLDER];
PImage[] UpCenterImages = new PImage[IMAGES_PER_FOLDER];
PImage[] UpRightImages = new PImage[IMAGES_PER_FOLDER];

PImage[] CenterLeftImages = new PImage[IMAGES_PER_FOLDER];
PImage[] CenterCenterImages = new PImage[IMAGES_PER_FOLDER];
PImage[] CenterRightImages = new PImage[IMAGES_PER_FOLDER];

PImage[] DownLeftImages = new PImage[IMAGES_PER_FOLDER];
PImage[] DownCenterImages = new PImage[IMAGES_PER_FOLDER];
PImage[] DownRightImages = new PImage[IMAGES_PER_FOLDER];


Movie mov;
int newFrame = 0;
int movFrameRate = 30;


void setup() {
  size(800, 600);
  background(0);
  setupImages();
  // Load and set the video to play. Setting the video 
  // in play mode is needed so at least one frame is read
  // and we can get duration, size and other information from
  // the video stream. 
 // mov = new Movie(this, "Nose.mov");
  
  // Pausing the video at the first frame. 
 // mov.loop();
 // mov.jump(0);
 // mov.pause();
}

void setupImages(){
  preloadImageArray(UpLeftImages, "UpLeft");
  preloadImageArray(UpCenterImages, "UpCenter");
  preloadImageArray(UpRightImages, "UpRight");
  preloadImageArray(CenterLeftImages, "CenterLeft");
  preloadImageArray(CenterCenterImages, "CenterCenter");
  preloadImageArray(CenterRightImages, "CenterRight");
  preloadImageArray(DownLeftImages, "DownLeft");
  preloadImageArray(DownCenterImages, "DownCenter");
  preloadImageArray(DownRightImages, "DownRight");
}

void preloadImageArray(PImage[] imageArray, String folderName){
  for (int i = 0; i < IMAGES_PER_FOLDER; i++){
    imageArray[i] = loadImage("Noses/" + folderName + "/" + i + ".png");
  }
}

void draw() {
  //background(0);
  for (int x = 0; x < HorizontalFrames; x++){
    for (int y = 0; y < VerticalFrames; y++){
      int imageWidth = width / HorizontalFrames;
      int imageHeight = height / VerticalFrames;
      int imagePosition = getImagePosition(x * imageWidth + imageWidth/2, y * imageHeight + imageHeight / 2);
      if (imagePosition != LastImagePositions[x][y]){
        ImageIndexArray[x][y] = (int)random(IMAGES_PER_FOLDER);
        LastImagePositions[x][y] = imagePosition;
      }
      PImage image = pickImage(LastImagePositions[x][y], ImageIndexArray[x][y]);
      copy(image, SRC_X, SRC_Y, SRC_WIDTH, SRC_HEIGHT, 
           x * imageWidth, y * imageHeight, imageWidth, imageHeight);
    }
  }
}

// This takes in the position of the image we're fill
//  and returns an appropriate index based on the position of the mouse
int getImagePosition(int imageX, int imageY){
  int halfImageWidth = width / (2 * HorizontalFrames);
  int halfImageHeight = height / (2 * VerticalFrames);
  int position = 5;
  if (mouseX < imageX + halfImageWidth && 
      mouseX > imageX - halfImageWidth &&
      mouseY < imageY + halfImageHeight &&
      mouseY > imageY - halfImageHeight){
    position = 5;
  }
  else{
      // Have the nose point to center if you're hovering over that picture
    float angle = atan2(mouseY - imageY, mouseX - imageX);
    if (angle >= (5 * PI / 8) && angle < (7 * PI / 8))
      position = 7;
    if (angle >= (3 * PI / 8) && angle < (5 * PI / 8))
      position = 8;
    if (angle >= (1 * PI / 8) && angle < (3 * PI / 8))
      position = 9;
    if (angle >= (7 * PI / 8) || angle < (-7 * PI / 8))
      position = 4;
    if (angle >= (-1 * PI / 8) && angle < (1 * PI / 8))
      position = 6;
    if (angle >= (-7 * PI / 8) && angle < (-5 * PI / 8))
      position = 1;
    if (angle >= (-5 * PI / 8) && angle < (-3 * PI / 8))
      position = 2;
    if (angle >= (-3 * PI / 8) && angle < (-1 * PI / 8))
      position = 3;
  }
  return position;
}

PImage pickImage(int position, int imageNumber){
  switch (position){
    case 1: return UpLeftImages[imageNumber];
    case 2: return UpCenterImages[imageNumber];
    case 3: return UpRightImages[imageNumber];
    case 4: return CenterLeftImages[imageNumber];
    case 5: return CenterCenterImages[imageNumber];
    case 6: return CenterRightImages[imageNumber];
    case 7: return DownLeftImages[imageNumber];
    case 8: return DownCenterImages[imageNumber];
    case 9: return DownRightImages[imageNumber];
  }
  return UpLeftImages[0];
}

void keyPressed(){
  if (key == 'v' && VerticalFrames > 0)
    VerticalFrames--;
  if (key == 'V' && VerticalFrames < MAX_FRAMES)
    VerticalFrames++;
  if (key == 'h' && HorizontalFrames > 0)
    HorizontalFrames--;
  if (key == 'H' && HorizontalFrames < MAX_FRAMES)
    HorizontalFrames++;
 
}
  
