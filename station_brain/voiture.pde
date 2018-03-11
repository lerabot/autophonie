AudioPlayer[] Vmessage = new AudioPlayer[5];
File[] f;
int lastMessage = 0;
int mNote = 0;
int mDelay = -1;

int knobLeft;
int knobRight;

void initVoiture() {
  //init folder;
  f = listFiles(dir);
  for (File t : f) {
    //println(t.toString());
  }
  println(f.length + " files in message folder");

  //5 audioPlayer, 1 par bouton.
  //minim[1].setOutputMixer()
  voiture = minim[1].getLineOut();
  for (int i=0; i < 5; i++) {
    int num = floor(random(0, fileNum-1));
    Vmessage[i] = minim[1].loadFile(f[num].toString());
    delay(25);
  }
  mDelay = second();
}

void updateVoiture() {
  pushNewMessage();
}

void playMessage(int note) {
  mNote = note - 20; 
  if (mNote >= 0 && mNote < 5) {
    Vmessage[mNote].play();

    if (Vmessage[lastMessage].isPlaying()) {
      Vmessage[lastMessage].pause();
      Vmessage[lastMessage].close();
    }
    int num = floor(random(0, fileNum-1));
    Vmessage[lastMessage] = minim[1].loadFile(f[num].toString());

    /*
    if (num < 8) //CREATION D'ÉLÈVE
     fl_midi.sendControllerChange(1, 0, 0); //CHANNEL 1!
     else
     fl_midi.sendControllerChange(1, 0, 127); //CHANNEL 1
     */

    //delay(100);
    lastMessage = mNote;
  }
  
}

void pushNewMessage() {
  if(Vmessage[mNote].isPlaying() == false && second() == mDelay) {
    playMessage(floor(random(20,25)));
    mDelay = floor(random(60));
    println("next message at " + mDelay);
  }
}