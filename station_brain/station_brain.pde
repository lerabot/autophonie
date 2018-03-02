import java.io.File;
import ddf.minim.*;
import themidibus.*;
// need to import this so we can use Mixer and Mixer.Info objects
import javax.sound.sampled.*;

/////MIDI//////
MidiBus cabine;
//MidiBus voiture;

////SOUND FILES//////
Minim minim;
Mixer.Info[] mixerInfo;
AudioOutput station;
AudioOutput voiture;
AudioPlayer repondeur;
AudioPlayer tone;
AudioPlayer bouton[];
AudioInput in;
AudioRecorder message;

int[] note = {0, 0};
boolean newNote;
boolean phoneOn = true;
String tag = "none";
int mic = 0;
String phoneNum = "";
String cohenNum = "5149990212";
int fileNum = 0;


static final int telephone = 72;

void setup() {
  size(500, 500);
  //MIDI//////////////////
  MidiBus.list();
  cabine = new MidiBus(this, 0, -1);
  //FILES///////////////////
  File folder = new File(sketchPath() + "/messages/none/");
  println("Saving in " + folder);
  fileNum = folder.listFiles().length + 1;
  //AUDIO/////////////////
  minim = new Minim(this);
  mixerInfo = AudioSystem.getMixerInfo();
  println(mixerInfo);
  in = minim.getLineIn();
  
  tone = minim.loadFile("16_Tonalite.wav");
  repondeur = minim.loadFile("13_Accueil_V2.wav");
  message = minim.createRecorder(in, "message.wav");
  bouton = new AudioPlayer[12];
  for (int i = 1; i < 13; i++) {
    bouton[i-1] = minim.loadFile(i + "_dial.wav");
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
}

void noteOff(int channel, int pitch, int velocity) {
  println("note off-> " + pitch);
  if (pitch == telephone)
    phoneOn = false;
}

void controllerChange(int channel, int number, int value) {
  if (number == 0)
    mic = value;
}