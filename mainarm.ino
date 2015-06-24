//Beta version for hand control

#include <Servo.h>
const int NUM=4;
int incomingByte=0 ;
int data[NUM]={};
int current[NUM]={};
int count=0;
int index=0;
Servo th1,th2,th3,fo1;
int pos = 0;

void setup() {
  th1.attach(2); 
  th2.attach(3);  
  th3.attach(4);  
  fo1.attach(5);  
 
  Serial.begin(115200);
}

void loop() {
  
  if (Serial.available()) {
    
    incomingByte = Serial.read();

    if (incomingByte==10)
    {
           
      for(int i=0;i<NUM;i=i+1)
      {
        current[i]=data[i];
        Serial.print(data[i]);
        Serial.print(",");
      }
      Serial.println("...processing");
      WriteServo(data[0], data[1], data[2], data[3]); //write fetcing data to servo
          
      for(int i=0;i<NUM;i=i+1)
      {
        data[i]=0;
      }      
      count=-1;
      index=0;              
    }
    else if (incomingByte==44)
    { 
      index=index+1;
    }
    else
    {
      if(count%3==0)
      {
        data[index]=data[index]+(incomingByte-48)*10;
      }
      else
      {
        data[index]=data[index]+(incomingByte-48);
      }
    }
    count=count+1;
  }
  else
  {
    WriteServo(current[0]+30, current[1], current[2], current[3]); //write fetcing data to servo
  }

 /*   for(pos = 0; pos <= 180; pos += 1) // goes from 0 degrees to 180 degrees 
  {                                  // in steps of 1 degree 
    th1.write(pos);              // tell servo to go to position in variable 'pos' 
    delay(15);                       // waits 15ms for the servo to reach the position 
  } 
  for(pos = 180; pos>=0; pos-=1)     // goes from 180 degrees to 0 degrees 
  {                                
    th1.write(pos);              // tell servo to go to position in variable 'pos' 
    delay(15);                       // waits 15ms for the servo to reach the position 
  }*/
}

void WriteServo(int a1, int a2, int a3, int b1)
{
    th1.write(a1);
    delay(1);   
    th2.write(a2);
    delay(1);
    th3.write(a3);
    delay(1);
    fo1.write(b1);
    delay(1);  
}
