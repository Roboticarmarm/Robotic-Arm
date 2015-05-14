#include <Servo.h> 
//For Mega2560 
Servo myservo;  // create servo object to control a servo 
                // twelve servo objects can be created on most boards
void setup() 
{ 
  pinMode(8,INPUT);
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object 
} 
 
void loop() 
{ 
    if (digitalRead(8) == HIGH)
    {    
       myservo.write(120);             
       delay(15);     // waits 15ms for the servo to reach the position 
    }      
    else
    {    
       myservo.write(30);         
       delay(15);    // waits 15ms for the servo to reach the position 
    }       
} 
