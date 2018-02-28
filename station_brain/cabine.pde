//////////////////////////////////
//CABINE LOGIC
//////////////////////////////////

void updateCabine() {

  // PLAY REPONDEUR
  if (phoneOn && !repondeur.isPlaying())
    repondeur.play();
  else if (!phoneOn && repondeur.isPlaying()) {
    repondeur.pause();
    repondeur.rewind();
  }

  //
  if (phoneOn) {
    switch (note[0]) {
    case 73 : 
      tag = "sexe";
      repondeur.pause();
      repondeur.rewind();
      break;
    case 74 : 
      tag = "voix";
      break;
    case 75 : 
      tag = "poesie";
      break;
    case 76 : 
      tag = "charme";
      break;
    case 77 : 
      tag = "podcast";
      break;
    }
  }
  recordMessage("wow");
}

//////////////////////////////////
//FILE RECORDER
//////////////////////////////////


int counter = 0;
void recordMessage(String fileName) {
  File f, newF;

  f = new File(sketchPath() + "/message.wav");
  newF = new File(sketchPath() + "/messages/" + tag + '/' + "message" + counter +".wav");

  //if (newNote && note[0] == 48)
  if (repondeur.position() > 9500)
    message.beginRecord();
  else if (message.isRecording()) {
    message.endRecord();
    message.save();
    f.renameTo(newF);
    message = minim.createRecorder(in, "message.wav");
    counter++;
    //message.
  }
}