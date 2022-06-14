//Creates and draws new Blips on Radar with data given from Arduino

class Blip {
   int x;
   int y;
   int w = 10;
   float transparency = 1;
   float distance;
   int deg;
   color col = color(255, 0, 0);
   
   public Blip(int deg, int dist, String colString) {
       this.deg = 90 - deg;
       distance = map(dist, 0, 100, 0, height - 30);
       
       //print(colString);
       if (colString.equals("r")) {
         //print(colString + " ");
         this.col = color(255, 0, 0);
       } else {
         this.col = color(0, 255, 0); 
       }
       //print(distance + " ");
   }
   
   void show() {
      pushMatrix();
      rotate(radians(deg));
      translate(0, 0);
      float a = map(transparency, 0, 1, 0, 255);
      fill(col, a);
      noStroke();
      ellipse(0, -distance, 10, 10);
      popMatrix();
   }
   
   void update() {
      transparency -= 0.01;
      
      if (transparency <= 0) {
        blips.remove(this); 
      }
   }
}
