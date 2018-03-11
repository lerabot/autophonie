import java.io.File;
import java.util.Arrays;
import ddf.minim.*;
import themidibus.*;
// need to import this so we can use Mixer and Mixer.Info objects
import javax.sound.sampled.*;

/////MIDI//////
MidiBus cabine_midi;
MidiBus voiture_midi;
MidiBus fl_midi;

////MINIM//////
Minim[] minim; // 0 = cabine, 1 = voiture
Mixer.Info[] mixerInfo;
AudioInput in; //cabine
AudioOutput station; //cabine
AudioOutput voiture; //voiture
AudioPlayer repondeur;
AudioPlayer tropLong;
AudioPlayer tone; 
AudioSample[] bouton;

AudioRecorder message;
//FILES///////////////////
int fileNum = 0;
File dir;

//NOTES//////////////////////
int[] note = {0, 0};
boolean newNote;
boolean phoneOn = false; //DEFAULT = FALSE
String tag = "none";
int mic = 0;



static final int telephone = 72;

void setup() {
  size(500, 500);
  //MIDI//////////////////
  MidiBus.list();
  cabine_midi = new MidiBus(this, 0, -1); //INPUT
  //voiture_midi = new MidiBus(this, 1, -1); //INPUT
  //fl_midi = new MidiBus(this, 0, 0); //OUTPUT
  //FILES///////////////////
  dir = new File(sketchPath() + "/messages/");
  println("Saving in " + dir);
  fileNum = dir.listFiles().length;
  //AUDIO/////////////////
  minim = new Minim[3];
  for (int i = 0 ; i < 3; i++)
    minim[i] = new Minim(this);
  mixerInfo = AudioSystem.getMixerInfo();
  println(mixerInfo);
  in = minim[0].getLineIn();
  voiture = minim[0].getLineOut();

  tone = minim[0].loadFile("16_Tonalite.wav");
  tropLong = minim[0].loadFile("14_Trop_long.wav");
  repondeur = minim[0].loadFile("13_Accueil_V2.wav");
  message = minim[0].createRecorder(in, "message.wav");
  bouton = new AudioSample[12];
  for (int i = 1; i < 13; i++) {
    bouton[i-1] = minim[0].loadSample(i + "_dial.wav", 512);
  }
  //VOITURE
  initVoiture();

  //GUI////////////////////
  setGUI();
}

void draw() {
  background(0);
  updateCabine();
  //updateVoiture();
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
  //println("note off-> " + pitch);
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