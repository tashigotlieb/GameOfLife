import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );
buttons = new Life[NUM_ROWS][NUM_COLS];

  //your code to initialize buttons goes here
for(int i =0; i<buttons.length;i++){
  for(int j=0; j<buttons[0].length;j++){
    buttons[i][j] = new Life(i,j);
  }
}
  buffer = new boolean[NUM_ROWS][NUM_COLS];
  //your code to initialize buffer goes here
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
for(int r = 0; r < NUM_ROWS; r++){
  for(int c = 0; c < NUM_COLS; c++) {
    if(countNeighbors(r,c) == 3){
     buffer[r][c] = true;
  } else if(countNeighbors(r, c) == 2 && buttons[r][c].getLife()) {
        buffer[r][c] = true;
      } else {
        buffer[r][c] = false;
      }
} 
}
  copyFromBufferToButtons();
}

public void keyPressed() {
if(key =='a'){
  running = !running;
}
}

public void copyFromButtonsToBuffer() {
  for(int r = 0; r<NUM_ROWS; r++){
    for(int c = 0; c<NUM_COLS; c++){
      buffer[r][c] = buttons[r][c].getLife();
    }
  }
  
  
  //your code here
}

public void copyFromBufferToButtons() {
  for(int r = 0; r< NUM_ROWS; r++){
    for(int c = 0; c<NUM_COLS; c++){
      buttons[r][c].setLife(buffer[r][c]);
    }
  }
}

public boolean isValid(int row, int col){
  if(row >= NUM_ROWS || row < 0 || col >= NUM_COLS || col < 0) {
    return false;
  } return true;
}


public int countNeighbors(int row, int col) {
  int neighbors = 0;
if(isValid(row,col+1) == true){
if(buttons[row][col+1].getLife() == true){
  neighbors++;
}
}
if(isValid(row,col-1) == true){
if(buttons[row][col-1].getLife() == true){
  neighbors++;
}
}
if(isValid(row+1,col+1) == true){
if(buttons[row+1][col+1].getLife() == true){
  neighbors++;
}
}
if(isValid(row+1,col-1) == true){
if(buttons[row+1][col-1].getLife() == true){
  neighbors++;
}
}
if(isValid(row+1,col) == true){
if(buttons[row+1][col].getLife() == true){
  neighbors++;
}
}
if(isValid(row-1,col) == true){
if(buttons[row-1][col].getLife() == true){
  neighbors++;
}
}
if(isValid(row-1,col-1) == true){
if(buttons[row-1][col-1].getLife() == true){
  neighbors++;
}
}
return neighbors;
  
}


public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
     width = 400/NUM_COLS;
     height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill( 150 );
    rect(x, y, width, height);
  }
  public boolean getLife() {
  return alive;
  }
  public void setLife(boolean living) {
  alive = living;
  }
}
