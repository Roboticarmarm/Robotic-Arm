//Beta version for hand control

#include <Servo.h>
const int DISTANCE=80;
const int NUM=4;
int incomingByte=0 ;
int data[NUM]={};
int current[NUM]={};
int count=0;
int index=0;
Servo th1,th2,th3,fo1;
int pos = 0;

void setup() {
  th1.attach(3); 
  th2.attach(5);  
  th3.attach(6);  
  fo1.attach(9);  
  pinMode(7, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(8, INPUT);
  Serial.begin(115200);
}

void loop() {
  long duration, mm;    
  digitalWrite(7, LOW);
  delayMicroseconds(2);
  digitalWrite(7, HIGH);
  delayMicroseconds(20);
  digitalWrite(7, LOW);
  
  duration = pulseIn(8, HIGH);
  mm = duration*34/200;
  Serial.print(mm);
  Serial.print("mm");
  Serial.println();
  
  if (current[0]==80)
  {
    if(mm<=DISTANCE)
    {
      current[0]=44;
      current[1]=50;
      current[2]=30;
      current[3]=60;
      backward(4,10,11,12);
    }
    else
    {
      forward(4,10,11,12);
    }
  }
  else if (current[0]==44)
  {
    backward(4,10,11,12);
  }
  else
  {
    mstop(4,10,11,12);
  }
  if (Serial.available()) 
  {  
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

void forward(int in1,int in2,int in3,int in4)
{
    digitalWrite(in1,HIGH);
    digitalWrite(in2,LOW);
    digitalWrite(in3,HIGH);
    digitalWrite(in4,LOW);
}

void backward(int in1,int in2,int in3,int in4)
{
    digitalWrite(in1,LOW);
    digitalWrite(in2,HIGH);
    digitalWrite(in3,LOW);
    digitalWrite(in4,HIGH);
}

void mstop(int in1,int in2,int in3,int in4)
{
    digitalWrite(in1,LOW);
    digitalWrite(in2,LOW);
    digitalWrite(in3,LOW);
    digitalWrite(in4,LOW);
}
