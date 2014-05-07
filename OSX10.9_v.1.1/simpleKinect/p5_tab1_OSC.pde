/**
 * creates the OSC control box with control fields
 */
void createOSCControlBox() {
  // create a group to store the oscControls elements
  oscControls = cp5.addGroup("oscControls",width/2 - 150,100,300);
  oscControls.setBackgroundHeight(160);
  oscControls.setBackgroundColor(color(0,100));
  oscControls.hideBar();
  
  // add a TextLabel to the oscControls.
  Textlabel lkip = cp5.addTextlabel("oscBoxLabel","Set OSC IP Address",20,20);
  lkip.moveTo(oscControls);
  
  // add a textfield-controller with named-id inputbox
  // this controller will be linked to function inputbox() below.
  Textfield kip = cp5.addTextfield("inputip",20,36,260,20);
  kip.captionLabel().setVisible(false);
  kip.moveTo(oscControls);
  kip.setColorForeground(color(20));
  kip.setColorBackground(color(20));
  kip.setColorActive(color(100));
  kip.setText(oscIP);
  kip.setAutoClear(false);
  
  Textlabel lkp = cp5.addTextlabel("inputportLabel","Set OSC Port",20,65);
  lkp.moveTo(oscControls);
  Textfield kp = cp5.addTextfield("inputport",20,80,260,20);
  kp.captionLabel().setVisible(false);
  kp.moveTo(oscControls);
  kp.setColorForeground(color(20));
  kp.setColorBackground(color(20));
  kp.setColorActive(color(100));
  kp.setText(str(oscPort));
  kp.setAutoClear(false);
  
  // add the OK button to the oscControls.
  // the name of the button corresponds to function buttonOK
  // below and will be triggered when pressing the button.
  Button b1 = cp5.addButton("buttonOK",0,65,120,80,24);
  b1.moveTo(oscControls);
  b1.setColorBackground(color(40));
  b1.setColorActive(color(20));
  // by default setValue would trigger function buttonOK, 
  // therefore we disable the broadcasting before setting
  // the value and enable broadcasting again afterwards.
  // same applies to the cancel button below.
  b1.setBroadcast(false); 
  b1.setValue(1);
  b1.setBroadcast(true);
  b1.setCaptionLabel("OK");
  // centering of a label needs to be done manually 
  // with marginTop and marginLeft
  //b1.captionLabel().style().marginTop = -2;
  //b1.captionLabel().style().marginLeft = 26;
  
  // add the Cancel button to the oscControls. 
  // the name of the button corresponds to function buttonCancel
  // below and will be triggered when pressing the button.
  Button b2 = cp5.addButton("buttonCancel",0,155,120,80,24);
  b2.moveTo(oscControls);
  b2.setBroadcast(false);
  b2.setValue(0);
  b2.setBroadcast(true);
  b2.setCaptionLabel("Cancel");
  b2.setColorBackground(color(40));
  b2.setColorActive(color(20));
  //b2.captionLabel().toUpperCase(false);
  // centering of a label needs to be done manually 
  // with marginTop and marginLeft
//  b2.captionLabel().style().marginTop = -2;
//  b2.captionLabel().style().marginLeft = 16;
}

// function buttonOK will be triggered when pressing
// the OK button of the oscControls.
void buttonOK(int theValue) {
//  println("a button event from button OK.");
  oscIP = ((Textfield)cp5.controller("inputip")).getText();
  oscPort = int(((Textfield)cp5.controller("inputport")).getText());
  remoteLocation = new NetAddress(oscIP, oscPort);
  oscBoxResult = theValue;
  oscTab.setColorBackground(color(127, 127, 127));
  oscControls.hide();
}


// function buttonCancel will be triggered when pressing
// the Cancel button of the oscBox.
void buttonCancel(int theValue) {
//  println("a button event from button Cancel.");
  oscBoxResult = theValue;
  oscTab.setColorBackground(color(127, 127, 127));
  oscControls.hide();
}
