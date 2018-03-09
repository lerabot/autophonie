void setGUI() {
  fill(255);
  stroke(255);
}

void renderGUI() {
  int _l = 20;
  text("phone -> " +int(phoneOn), 20, 1 * _l);
  text("recording -> " + message.isRecording(), 20, 2 * _l);
  text("current note-> " +note[0], 20, 4 * _l);
  text("repondeur pos-> " +repondeur.position(), 20, 5 * _l);
  //text("audio level-> " +mic, 20, 6 * _l);
  text("knob Left ->" + knobLeft, 20, 6 * _l);
  text("knob Right ->" + knobRight, width/2, 6 * _l);
  text("delay before next message ->" + (mDelay-second()), 20, 7 * _l);
  
  
  // draw the waveforms so we can see what we are monitoring
  pushMatrix();
  translate(0,200);
  int scale = 100;
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line( i, 50 + in.left.get(i)*scale, i+1, 50 + in.left.get(i+1)*scale );
    line( i, 150 + in.right.get(i)*scale, i+1, 150 + in.right.get(i+1)*scale );
  }
  popMatrix();
}