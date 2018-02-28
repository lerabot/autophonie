#include <Keypad.h>

/*
midi
 5 bouton
 2 knob
 
 */

#define K5 6
#define K4 7 
#define K1 8 
#define YELLOW 22 
#define RED 11

#define K3 21
#define K6 20
#define K7 19
#define K2 18
#define BLK 17
#define HOOK 16
#define GREEN 15  //HEADPHONE




#define LED 13 

const byte ROWS = 4; // Four rows
const byte COLS = 3; // Three columns
// Define the Keymap
char keys[ROWS][COLS] = {
  {
    '1','2','3'  }
  ,
  {
    '4','5','6'  }
  ,
  {
    '7','8','9'  }
  ,
  {
    '#','0','*'  }
};
// Connect keypad ROW0, ROW1, ROW2 and ROW3 to these Arduino pins.
byte rowPins[ROWS] = {
  K7, K6, K5, K4};
// Connect keypad COL0, COL1 and COL2 to these Arduino pins.
byte colPins[COLS] = {
  K1, K2, K3}; 

// Create the Keypad
Keypad kpd = Keypad( makeKeymap(keys), rowPins, colPins, ROWS, COLS );


boolean telephone = false;

void setup() {
  //Serial.begin(9600);
  //MIDI.begin();
  pinMode(HOOK, INPUT_PULLUP);
  pinMode(LED, OUTPUT);
  //pinMode(BLK, OUTPUT);
  //digitalWrite(BLK, LOW);
  //pinMode(RED, OUTPUT);
  //digitalWrite(RED, LOW);


}


void loop() {

  tone(GREEN, 440);
  usbMIDI.sendControlChange(0, analogRead(A9), 0);
  char key = kpd.getKey();
  if(key)
    usbMIDI.sendNoteOn(key,100,0);
  /*
  if(key)  // Check for a valid key.
   {
   switch (key)
   {
   case '*':
   usbMIDI.sendNoteOn(73,100,0);
   break;
   case '#':
   digitalWrite(ledpin, HIGH);
   break;
   default:
   Serial.println(key);
   }
   }
   */

  if(digitalRead(HOOK)) //INVERT IN FINAL
    usbMIDI.sendNoteOn(72,100,0);
  else
    usbMIDI.sendNoteOff(72,100,0);


  //Serial.println("wow");
  delay(5);

}


