/// this is OSC listener for MUSE EEG, by John Lee 31 Jan 2019

/// to start MUSE server use this in terminal muse-io --preset 14 --device <DEVICE_NAME> --osc osc.udp://localhost:5000

/// this is tutorial site https://sites.google.com/a/interaxon.ca/muse-developer-site/museio/tutorial

import oscP5.*;
import netP5.*;
import java.util.Map;

OscP5 oscP5;

float[] EEG;

void setup() 
{
  size(640, 480);

  oscP5 = new OscP5(this, 5000);

  initDefaultData();
}

void initDefaultData()
{
  EEG = new float[4];
}

void oscEvent(OscMessage theOscMessage) 
{
  /*
  print("---OSC Message Received---");
   print(" Address Path: ", theOscMessage.addrPattern());
   println(" Types: ", theOscMessage.typetag());
   */

  if (theOscMessage.checkAddrPattern("/muse/eeg")==true) 
  {  
    for (int i = 0; i < 4; i++) 
    {
      EEG[i] = theOscMessage.get(i).floatValue();

      print("EEG on channel ", i, ": ", theOscMessage.get(i).floatValue(), "\n");
    }
  }
}

void displayTags()
{
  ;
}

void draw()
{  
  background(0);

  for (int i = 0; i < 4; i++) 
  {
    rect(i*100+50, height/2-EEG[i]/10,  20, EEG[i]/10);
  }

  text("I'm MUSE listener!!", 20, 20);
}
