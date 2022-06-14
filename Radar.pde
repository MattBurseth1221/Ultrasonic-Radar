//Draws and updates scanning line

class Radar {
  int x = 0;
  int y = 0;
  int rot = 0;
  int degrees = rot;
  int offset = 1;

  public Radar() {
    
  }
  
  void show() {
    stroke(255); 
    strokeWeight(3);
    pushMatrix();
    rotate(radians(degrees));
    line(x, y, 0, 2 * -height);
    popMatrix();
  }
  
  void update(String[] data) {
    try {
      int pos = int(data[0]);
      //int dist = int(data[1]);
      
    } catch (Exception e) {
       //print(e); 
    }
    
    degrees = 90 - pos;
    //degrees += offset;
      
    /*if (degrees > 180 + rot || degrees < rot) {
       offset *= -1;
    }*/
  }
}
