import java.io.File;
import controlP5.*;
import g4p_controls.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import themidibus.*;

/////MIDI//////
MidiBus cabine;
//MidiBus voiture;

////SOUND FILES//////
Minim minim;
AudioPlayer repondeur;
AudioInput in;
AudioRecorder message;

////GUI//////
ControlP5 gui;

int[] note = {0, 0};
boolean newNote;
boolean phoneOn = false;
String tag = "none";
int mic = 0;

static final int telephone = 72;

void setup() {
  size(500, 500);
  //MIDI//////////////////
  MidiBus.list();
  cabine = new MidiBus(this, 0, -1);
  //AUDIO/////////////////
  minim = new Minim(this);
  in = minim.getLineIn();
  repondeur = minim.loadFile("repondeur2.wav");
  message = minim.createRecorder(in, "message.wav");
  //GUI////////////////////
  gui = new ControlP5(this);
  setGUI();
}

void draw() {
  background(0);
  updateCabine();
  renderGUI();
}

void noteOn(int channel, int pitch, int velocity) {
  println("note -> " + pitch);
  if (pitch == telephone)
    phoneOn = true;

  if (pitch != note[0]) {
    note[0] = pitch;
    note[1] = velocity;
    newNote = true;
  } else
    newNote = false;
}

void noteOff(int channel, int pitch, int velocity) {
  if (pitch == telephone)
    phoneOn = false;
}

void controllerChange(int channel, int number, int value) {
  if (number == 0)
    mic = value;
  
}