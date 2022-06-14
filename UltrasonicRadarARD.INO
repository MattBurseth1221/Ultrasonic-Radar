//Takes data from Ultrasonic Radar + other I/O and sends via serialized String to Processing software

#include <Servo.h>
#define echoPin 2
#define trigPin 3
#define stick A5
#define red 9
#define green 8
#define button 7

int servoPin = 6;
Servo servo;

long duration;
String distance;
int position = 90;

int buttonState;
int lastButtonState = LOW;
int buttonPushCounter = 0;
String color = "red";
unsigned long lastDebounceTime = 0;
unsigned long debounceDelay = 50;

void setup() {
  // put your setup code here, to run once:
  servo.attach(servoPin);

  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(stick, INPUT);
  pinMode(red, OUTPUT);
  pinMode(green, OUTPUT);
  pinMode(button, INPUT);

  Serial.begin(9600);
  //Serial.println("Begin test");

  digitalWrite(red, HIGH);
  
  servo.write(position);
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2000);

/**for (position = 0; position < 180; position++) {
    //servo.write(position);
    digitalWrite(trigPin, HIGH);
    delayMicroseconds(1000);
    digitalWrite(trigPin, LOW);

    duration = pulseIn(echoPin, HIGH);
    delayMicroseconds(10);
    distance[position] = duration * 0.034 / 2;
    delayMicroseconds(10);
  }*/

}

int VRx;

void loop() {
  // put your main code here, to run repeatedly:
  int reading = digitalRead(button);

  if (reading != lastButtonState) {
    lastDebounceTime = millis();
  }

  if ((millis() - lastDebounceTime) > debounceDelay)  {
    if (reading != buttonState) {
      buttonState = reading;

      if (buttonState == HIGH) {
        if (color == "red") {
          color = "green";
          digitalWrite(red, LOW);
          digitalWrite(green, HIGH);
        } else if (color == "green") {
          color = "red";
          digitalWrite(green, LOW);
          digitalWrite(red, HIGH);
        }
      }
    }
  }
  lastButtonState = reading;
  
  VRx = analogRead(stick);
  
  //Serial.println("analog pos: ");
  //Serial.println(VRx);
  if (VRx > 1000) {
    position--;
  } else if (VRx == 0) {
    position++;
  }

  if (position < 0) {
    position = 0;
  } else if (position > 180) {
    position = 180;
  }

  servo.write(position);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  duration = pulseIn(echoPin, HIGH, 10000);
  delayMicroseconds(10);
  distance = String(duration * 0.034 / 2);

  delay(40);

  Serial.print(String(position) + '@' + distance + '@' + color + '@' + '\n');
  
}
