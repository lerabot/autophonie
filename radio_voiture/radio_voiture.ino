/////////////////////////////////////////
//RADIO DE LA CADILLAC

/////////////////////////////////////////

void setup() {
  pinMode(13, OUTPUT);
  pinMode(2, INPUT_PULLUP);
  pinMode(3, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);
  pinMode(5, INPUT_PULLUP);
  pinMode(6, INPUT_PULLUP);
  Serial.begin(9600);  
}

void loop() {
  digitalWrite(13, digitalRead(2));

  Serial.print("Active = ");
  for (int i = 2; i < 7; i++) {
    Serial.print(digitalRead(i));
    Serial.print(" ");
  }
  Serial.println(analogRead(A8));
  Serial.println();
  
  
  delay(25);
}


