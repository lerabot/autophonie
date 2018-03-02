//////////////////////////////////
//CABINE LOGIC
//////////////////////////////////

void updateCabine() {

  // PLAY REPONDEUR
  if (!phoneOn && !tone.isPlaying()) {
    tone.play();
  } 

  if (phoneNum.equals(cohenNum) || phoneNum.length() > 9) {
    tone.pause();
    repondeur.play();
    recordMessage("leMessage");
  } 

  if (phoneOn) {
    repondeur.pause();
    repondeur.rewind();
    tone.pause();
    tone.rewind();
    phoneNum = "";
  }
}

void playBouton(int note) {
  int _offset = 47;
  if (note > _offset && note < 59) {
    bouton[note-_offset].rewind();
    bouton[note-_offset].play();
    phoneNum += note - _offset - 1;
    println(phoneNum);
  }
}

//////////////////////////////////
//FILE RECORDER
//////////////////////////////////
void recordMessage(String fileName) {
  File f, newF;

  f = new File(sketchPath() + "/message.wav");
  newF = new File(sketchPath() + "/messages/" + tag + '/' + fileNum + "_message.wav");

  if ((repondeur.position() > repondeur.length() - 200) && !message.isRecording()) {
  //if (!phoneOn && !message.isRecording()) {
    message.beginRecord();
  } else if (message.isRecording() && phoneOn) {
    message.endRecord();
    message.save();
    f.renameTo(newF);
    message = minim.createRecorder(in, "message.wav");
    fileNum++;
    phoneNum = "";
    //message.
  }
}