
int incomingByte=0 ;
int data[17]={};
  int count=0;
  int index=0;
  
void setup() {
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
      for(int i=0;i<17;i=i+1)
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

void WriteServo()
{
  
  
}
