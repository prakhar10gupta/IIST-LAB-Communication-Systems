const int led  =  12;     //use digital I/O pin 8
void setup()
{
pinMode(led,OUTPUT);
}

void loop()
{
   // Framing header for sync
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds
   // Framing header for sync

   // Barker code
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds   
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);
   // Barker code

   // H
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds   
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds   
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 

   // E
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds   
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds   
   digitalWrite(led,HIGH);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 

   // L
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds   
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds   
   digitalWrite(led,HIGH);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 

    // L
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds   
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds   
   digitalWrite(led,HIGH);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 

   // O
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds   
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);   //set pin 8 HIGH, turning on LED
   delay(1);          //delay 1000 milliseconds   
   digitalWrite(led,HIGH);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 
   digitalWrite(led,HIGH);    //set pin 8 LOW, turning off LED
   delay(1);          //delay 1000 milliseconds 

   // Make it go to 0
   digitalWrite(led,LOW);    //set pin 8 LOW, turning off LED
   delay(100);
}

