import processing.serial.*;
Serial port;

int distance;
int degrees;
int dist;
int pos;
String val;
String col;
String[] vals;
String[] data;
boolean firstTime = true;
//public ArrayList<Blip> blips = new ArrayList<Blip>();
public ArrayList<Blip> blips = new ArrayList<Blip>();

Radar r;

void setup() {
    size(512, 512);
    translate(width / 2, height - 30);
    r = new Radar();
    
    try {
      String portName = "COM3";
      port = new Serial(this, portName, 9600);
      port.clear();
    } catch (Exception e) {
       println(e); 
    }
}

void draw() {
   translate(width / 2, height - 30);
   background(0); 
   if (firstTime) {
      delay(1000);
      firstTime = false;
   }
   
   data = serialEvent();
   r.show();
   r.update(data);
   
   try {
     degrees = int(data[0]);
     dist = int(data[1]);
     col = data[2].substring(0, 1);
     if (dist <= 200 && dist > 0) {
         blips.add(new Blip(pos, dist, col)); 
      }
   } catch (Exception e) {
     
   }
   
   for (int i = 0; i < blips.size(); i++) {
      blips.get(i).show(); 
      blips.get(i).update();
   }  
}

String[] serialEvent() {
   if (port.available() > 0) {
     val = port.readStringUntil('\n');
     //print("val: " + val);
     if (val != null) {
        vals = split(val, '@');
        pos = int(vals[0]);
        //distance = int(vals[1]);
        //col = vals[2];
      
        return vals;
        //print(pos);
        //println(" " + distance);
      }
   }
   
   return new String[] {null, null};
}
