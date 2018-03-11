//////////////////////////////////
//CABINE LOGIC
//////////////////////////////////
int timer = 0; //temp limite pour laisser un message 
int messLimit = 90;
String phoneNum = "";
String cohenNum = "5149990212";

void updateCabine() {

  // PLAY REPONDEUR
  if (!phoneOn && !tone.isPlaying() && !repondeur.isPlaying() && !tropLong.isPlaying() && message.isRecording() == false) {
    tone.play();
  } 

  if (phoneNum.equals(cohenNum) || phoneNum.length() > 9 && message.isRecording() == false) {
    tone.pause();
    repondeur.play();
  } 

  if (repondeur.position() == repondeur.length()) {
    recordMessage("leMessage");
    repondeur.pause();
    repondeur.rewind();
  }

  if (tropLong.position() == tropLong.length()) {
    recordMessage("leMessage");
    tropLong.pause();
    tropLong.rewind();
  }

  if (message.isRecording() && millis() > timer)
    deleteMessage();

  if (phoneOn) {
    if (message.isRecording())
      closeMessage();
    repondeur.pause();
    repondeur.rewind();
    tropLong.pause();
    tropLong.rewind();
    tone.pause();
    tone.rewind();
    phoneNum = "";
  }
}

void playBouton(int note) {
  int _offset = 47;
  if (note > _offset && note < 59) {
    //bouton[note-_offset].rewind();
    bouton[note-_offset].trigger();
    phoneNum += note - _offset - 1;
    //println(phoneNum);
  }
}

//////////////////////////////////
//FILE RECORDER
//////////////////////////////////
void recordMessage(String fileName) {
  if (message.isRecording() == false) {
    message.beginRecord();
    timer = (millis() + 1000 * messLimit); //90 seconde
    phoneNum = "";
  }
}

void closeMessage() { 
  File f, newF;

  f = new File(sketchPath() + "/message.wav");
  newF = new File(dir.toString() + "/" + fileNum + "_message.wav");

  message.endRecord();
  message.save();
  f.renameTo(newF);
  message = minim[0].createRecorder(in, "message.wav");
  fileNum++;
  phoneNum = "";
}


void deleteMessage() {
  File f = new File(sketchPath() + "/message.wav");
  tropLong.play();
  message.endRecord();
  message.save();
  f.delete();
  message = minim[0].createRecorder(in, "message.wav");
}