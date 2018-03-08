import java.io.File;
import ddf.minim.*;
import themidibus.*;
// need to import this so we can use Mixer and Mixer.Info objects
import javax.sound.sampled.*;

/////MIDI//////
MidiBus cabine_midi;
MidiBus voiture_midi;
MidiBus fl_midi;

////MINIM//////
Minim minim;
Mixer.Info[] mixerInfo;
AudioOutput station;
AudioOutput voiture;
AudioPlayer repondeur;
AudioPlayer tone;
AudioSample[] bouton;
AudioInput in;
AudioRecorder message;
//FILES///////////////////
int fileNum = 0;
File dir;

//NOTES//////////////////////
int[] note = {0, 0};
boolean newNote;
boolean phoneOn = true;
String tag = "none";
int mic = 0;
String phoneNum = "";
String cohenNum = "5149990212";


int knobLeft;
int knobRight;


static final int telephone = 72;

void setup() {
  size(500, 500);
  //MIDI//////////////////
  MidiBus.list();
  cabine_midi = new MidiBus(this, 0, -1); //INPUT
  voiture_midi = new MidiBus(this, 1, -1); //INPUT
  fl_midi = new MidiBus(this, 0, 1); //OUTPUT
  //FILES///////////////////
  dir = new File(sketchPath() + "/messages/none/");
  println("Saving in " + dir);
  fileNum = dir.listFiles().length;
  //AUDIO/////////////////
  minim = new Minim(this);
  mixerInfo = AudioSystem.getMixerInfo();
  //println(mixerInfo);
  in = minim.getLineIn();
  voiture = minim.getLineOut();
  
  tone = minim.loadFile("16_Tonalite.wav");
  repondeur = minim.loadFile("13_Accueil_V2.wav");
  message = minim.createRecorder(in, "message.wav");
  bouton = new AudioSample[12];
  for (int i = 1; i < 13; i++) {
    bouton[i-1] = minim.loadSample(i + "_dial.wav", 512);
  }
  //VOITURE
  initVoiture();

  //GUI////////////////////
  setGUI();
}

void draw() {
  background(0);
  updateCabine();
  renderGUI();
}

void noteOn(int channel, int pitch, int velocity) {
  println("note on-> " + pitch);
  if (pitch == telephone)
    phoneOn = true;

  if (pitch != note[0]) {
    note[0] = pitch;
    note[1] = velocity;
    newNote = true;
  } else
    newNote = false;

  playBouton(pitch);

  if (newNote)
    playMessage(pitch);
}

void noteOff(int channel, int pitch, int velocity) {
  println("note off-> " + pitch);
  if (pitch == telephone)
    phoneOn = false;
}

void controllerChange(int channel, int number, int value) {
  switch(number) {
  case 6:
    knobLeft = value;
    break;
  case 7:
    knobRight = value;
    break;
  }
}