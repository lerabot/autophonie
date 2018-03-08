AudioPlayer[] Vmessage = new AudioPlayer[5];
File[] f;
int lastMessage = 0;
int mNote;

void initVoiture() {
  //init folder;
  f = listFiles(dir);
  println(fileNum + " files in message folder");
  //println(f);
  //5 audioPlayer, 1 par bouton.
  voiture = minim.getLineOut();
  for (int i=0; i < 5; i++) {
    int num = int(random(fileNum));
    Vmessage[i] = minim.loadFile(f[num].toString(), 512);
    delay(150);
  }

  //set Channel
}

void playMessage(int note) {
  mNote = note - 20; 

  if (mNote >= 0 && mNote < 5) {
    Vmessage[mNote].play();
    Vmessage[lastMessage].pause();
    Vmessage[lastMessage].close();
    int num = int(random(fileNum));
    Vmessage[lastMessage] = minim.loadFile(f[num].toString());
    if (num < 8) //CREATION D'ÉLÈVE
      fl_midi.sendControllerChange(1, 0, 0); //CHANNEL 1!
    else
      fl_midi.sendControllerChange(1, 0, 127); //CHANNEL 1
    //delay(100);
  }
  lastMessage = mNote;
}