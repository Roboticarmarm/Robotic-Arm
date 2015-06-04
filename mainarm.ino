//Beta version for hand control

#include <Servo.h> 
int incomingByte=0 ;
int data[17]={};
int count=0;
int index=0;
Servo th1,th2,th3,fo1,fo2,fo3,mi1,mi2,mi3,ri1,ri2,ri3,li1,li2,li3; //th=thumb,fo=forefinger,mi=middle,ri=ring,li=little

void setup() {
  pinMode(22,INPUT);
  th1.attach(23); 
  pinMode(24,INPUT);
  th2.attach(25);  
  pinMode(26,INPUT);
  th3.attach(27);  
  pinMode(28,INPUT);
  fo1.attach(29);  
  pinMode(30,INPUT);
  fo2.attach(31);  
  pinMode(32,INPUT);
  fo3.attach(33);  
  pinMode(34,INPUT);
  mi1.attach(35);  
  pinMode(36,INPUT);
  mi2.attach(37);  
  pinMode(38,INPUT);
  mi3.attach(39);  
  pinMode(40,INPUT);
  ri1.attach(41);  
  pinMode(42,INPUT);
  ri2.attach(43);  
  pinMode(44,INPUT);
  ri3.attach(45); 
  pinMode(46,INPUT);
  li1.attach(47);
  pinMode(48,INPUT);
  li2.attach(49);
  pinMode(50,INPUT);
  li3.attach(51);
  Serial.begin(115200);
}

void loop() {
  if (Serial.available()) {
    
    incomingByte = Serial.read();

    if (incomingByte==10)
    {
      for(int i=0;i<17;i=i+1)
      {
        Serial.print(data[i]);
        Serial.print(",");
      }
      Serial.println("...processing");
      WriteServo(data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7], data[8], data[9], data[10], data[11], data[12], data[13], data[14]); //write fetcing data to servo

      for(int i=0;i<17;i=i+1) //init
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
}

void WriteServo(int a1, int a2, int a3, int b1, int b2, int b3, int c1, int c2 ,int c3 ,int d1, int d2 ,int d3 ,int e1, int e2 ,int e3 )
{
    th1.write(a1);   
    th2.write(a2);
    th3.write(a3);
    fo1.write(b1);   
    fo2.write(b2);
    fo3.write(b3);
    mi1.write(c1);   
    mi2.write(c2);
    mi3.write(c3);
    ri1.write(d1);   
    ri2.write(d2);
    ri3.write(d3);
    li1.write(e1);   
    li2.write(e2);
    li3.write(e3);
}
