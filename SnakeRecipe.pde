
// 1. Follow the recipe instructions inside the Segment class.

// The Segment class will be used to represent each part of the moving snake.

class Segment {

  //2. Create x and y member variables to hold the location of each segment.
  int posX;
  int posY;
  // 3. Add a constructor with parameters to initialize each variable.
  Segment(int x, int y) {
    posX = x;
    posY = y;
  }

  // 4. Add getter and setter methods for both the x and y member variables.
  int getX() {
    return posX;
  }

  void setX(int x) {
    posX = x;
  }

  int getY() {
    return posY;
  }

  void setY(int y) {
    posY = y;
  }
}


// 5. Create (but do not initialize) a Segment variable to hold the head of the Snake
Segment head;


// 6. Create and initialize a String to hold the direction of your snake e.g. "up"
String direction = "up";


// 7. Create and initialize a variable to hold how many pieces of food the snake has eaten.
// give it a value of 1 to start.
int foodConsumed = 1;


// 8. Create and initialize foodX and foodY variables to hold the location of the food.
int foodX = ((int)random(50)*10);
int foodY = ((int)random(50)*10);
// (Hint: use the random method to set both the x and y to random locations within the screen size (500 by 500).)

//int foodX = ((int)random(50)*10);



void setup() {

  // 9. Set the size of your sketch (500 by 500).

  size(500, 500);


  // 10. initialize your head to a new segment.
  head = new Segment(width/2, height/2);

  // 11. Use the frameRate(int rate) method to set the rate to 20.
  frameRate(20);
}


void draw() {

  background(0);


  //12. Call the manageTail, drawFood, drawSnake, move, and collision methods.
  manageTail();
  drawFood();
  drawSnake();
  move();
  collision();
}


// 13. Complete the drawFood method below. (Hint: each piece of food should be a 10 by 10 rectangle).

void drawFood() {
  fill(255, 0, 0);
  rect((int) foodX, (int) foodY, 10, 10);
}


//14. Draw the snake head (use a 10 by 10 rectangle)

void drawSnake() {
  /*rect((int) head.getX(), 0, 10, height);
  rect(0, (int) head.getY(), width, 10);*/
  
  fill(255);
  rect((int) head.getX(), (int) head.getY(), 10, 10);

  //test your code
}


// 15. Complete the move method below.

void move() {

  // 16. Using a switch statement, make your snake head move by 10 pixels in the correct direction.
  //This is an incomplete switch statement:

  switch (direction) {

  case "up":
    head.setY(head.getY()-10);
    break;

  case "down":
    head.setY(head.getY()+10);
    break;

  case "left":
    head.setX(head.getX()-10);
    break;

  case "right":
    head.setX(head.getX()+10);
    break;
  }



  // 17. Call the checkBoundaries method to make sure the snake head doesn't go off the screen.
  checkBoundaries();
}


// 18. Complete the keyPressed method below. Use if statements to set your direction variable depending on what key is pressed.

void keyPressed() {
  switch (keyCode) {
    case UP:
      if (direction != "down") {
        direction = "up";
      }
      break;
    case DOWN:
      if (direction != "up") {
        direction = "down";
      }
      break;
    case LEFT:
      if (direction != "right") {
        direction = "left";
      }
      break;
    case RIGHT:
      if (direction != "left") {
        direction = "right";
      }
      break;
    default:
      break;
     
  }
}

  // 19. check if your head is out of bounds (teleport your snake head to the other side).

  void checkBoundaries() {
    if (head.getX() < 0) {
      head.setX(width-10);
    } else if (head.getX() > width-10) {
      head.setX(0);
    } else if (head.getY() < 0) {
      head.setY(height-10);
    } else if (head.getY() > height-10) {
      head.setY(0);
    }
  }



  //20. Make sure that the key for your current direction’s opposite doesn’t work(i.e. If you’re going up, down key shouldn’t work)



  // 21. Complete the missing parts of the collision method below.

  void collision() {

    // If the segment is colliding with a piece of food...
    if (head.getX() == foodX && head.getY() == foodY) {
    // Increase the amount of food eaten and set foodX and foodY to new random locations.
      foodConsumed++;
      foodX = ((int)random(50))*10;
      foodY = ((int)random(50))*10;
    }
  }



  /**
   
   ** Part 2: making the tail (the rest of the snake)
   
   **/

  //  1. Create and initialize an ArrayList of Segments. (This will be your snake tail!)
  ArrayList<Segment> tail = new ArrayList<Segment>();

  // 2. Complete the missing parts of the manageTail method below and call it in the draw method.

  void manageTail() {

    //Call the drawTail and checkTailCollision methods.
    drawTail();
    checkTailCollision();
    // Add a new Segment to your ArrayList that has the same X and Y as the head of your snake.
    tail.add(new Segment(head.getX(), head.getY()));
    // To keep your tail the right length:
    // while the tail size is greater than the number of food pieces eaten, remove the first Segment in your tail.
    while (tail.size() > foodConsumed) {
      tail.remove(0);
    }
  }

  void drawTail() {
    // Draw a 10 by 10 rectangle for each Segment in your snake ArrayList.
    for (int i = 0; i < tail.size(); i++) {
      Segment segment = tail.get(i);
      fill(lerpColor(color(0, 255, 255), color(255), (((float) i + 1) / (float) tail.size() - 1)));
      rect(segment.getX(), segment.getY(), 10, 10);
    }
  }


  // 3. Complete the missing parts of the bodyCollision method below.

  void checkTailCollision() {

    // If your head has the same location as one of your segments...
    for (Segment segment : tail) {
    // reset your food variable
      if (head.getX() == segment.getX() && head.getY() == segment.getY()) {
        foodConsumed = 0;
      }
    //Call this method at the beginning of your manageTail method.
    }
  }

