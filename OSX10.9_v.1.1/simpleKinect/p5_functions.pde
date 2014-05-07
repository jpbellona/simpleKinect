/****************************************************/
/********************* MAIN NAV *********************/
/****************************************************/

/**
 * toggles the visibility of the "OSC Ports" control box
 */
void oscBox(int theValue) {
  if (oscControls.isVisible()) {
    oscControls.hide();
    oscTab.setColorBackground(color(127, 127, 127));
  } 
  else {
    oscControls.show();
    oscTab.setColorBackground(color(2, 52, 77));
    //alter other global controls.
    hideControls("oscControls", "oscBox");
  }
}

/**
 * toggles the visibility of the "OSC Skeleton" control box
 */
void skelBox(int theValue) {
  //"skelOSCControls" "skelBox"
  if (skelOSCControls.isVisible()) {
    skelOSCControls.hide();
    skelTab.setColorBackground(color(127, 127, 127));
  } else {
    //turn on skeleton controls.  
    skelOSCControls.show();
    skelTab.setColorBackground(color(2, 52, 77));
    //alter other global controls.
    hideControls("skelOSCControls", "skelBox");
  }
}

/**
 * toggles the visibility of the "Instructions" control box
 */
void instructBox(int theValue) {
  if (instructionsPanel.isVisible()) {
    instructionsPanel.hide();
    instructionsTab.setColorBackground(color(127, 127, 127));
  } 
  else {
    //turn on skeleton controls.  
    instructionsPanel.show();
    instructionsTab.setColorBackground(color(2, 52, 77));
    //alter other global controls.
    hideControls("instructions", "instructBox");
  } 
}

/**
 * Hides controls boxes and colors globals tabs
 * utilizes global tabNames[]
 */
void hideControls(String controlName, String tabName) {
  //hide all other controls.
  List list = cp5.getAll(Group.class);
  for (int i=0; i<list.size(); i++) {
    Group g = (Group) list.get(i); //cast the object
    if (!g.getName().equals(controlName)) {
      g.hide();
    }
  }
  //change all other tabs
  for (int i=0; i<tabNames.length; i++) {
    Button b = (Button) cp5.getController(tabNames[i]);
    if (!b.getName().equals(tabName)) {
      b.setColorBackground(color(127, 127, 127));
      b.setColorBackground(color(127, 127, 127));
    }
  } 
}


// inputbox is called whenever RETURN has been pressed 
// in textfield-controller inputbox 
//void inputbox(String theString) {
//  println("got something from the inputbox : "+theString);
//  oscIP = ((Textfield)cp5.controller("inputbox")).getText();
//  ((Textfield)cp5.controller("inputbox")).setText(oscIP);
////  oscBox.hide();
//}

/****************************************************/
/****************** CONTROL FUNCS *******************/
/****************************************************/


/**
 * All control events handled here (from all tabs)
 */
void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
    if(theEvent.getName().equals("inputip")) {
       oscIP = theEvent.getStringValue();
       ((Textfield)cp5.controller("inputip")).setFocus(false);
    } 
    if(theEvent.getName().equals("inputport")) {
       oscPort = int(theEvent.getStringValue());
       ((Textfield)cp5.controller("inputport")).setFocus(false);
    } 
    if(theEvent.getName().equals("lhand-url")) {
       oscURI_left_hand = theEvent.getStringValue();
       ((Textfield)cp5.controller("lhand-url")).setFocus(false);
    } 
    if(theEvent.getName().equals("lelbow-url")) {
       oscURI_left_elbow = theEvent.getStringValue();
       ((Textfield)cp5.controller("lelbow-url")).setFocus(false);
    } 
    if(theEvent.getName().equals("lshoulder-url")) {
       oscURI_left_shoulder = theEvent.getStringValue();
       ((Textfield)cp5.controller("lshoulder-url")).setFocus(false);
    } 
    if(theEvent.getName().equals("rhand-url")) {
       oscURI_right_hand = theEvent.getStringValue();
       ((Textfield)cp5.controller("rhand-url")).setFocus(false);
    } 
    if(theEvent.getName().equals("relbow-url")) {
       oscURI_right_elbow = theEvent.getStringValue();
       ((Textfield)cp5.controller("relbow-url")).setFocus(false);
    } 
    if(theEvent.getName().equals("rshoulder-url")) {
       oscURI_right_shoulder = theEvent.getStringValue();
       ((Textfield)cp5.controller("rshoulder-url")).setFocus(false);
    } 
    if(theEvent.getName().equals("lhip-url")) {
       oscURI_left_hip = theEvent.getStringValue();
       ((Textfield)cp5.controller("lhip-url")).setFocus(false);
    } 
    if(theEvent.getName().equals("lknee-url")) {
       oscURI_left_knee = theEvent.getStringValue();
       ((Textfield)cp5.controller("lknee-url")).setFocus(false);
    } 
    if(theEvent.getName().equals("lfoot-url")) {
       oscURI_left_foot = theEvent.getStringValue();
       ((Textfield)cp5.controller("lfoot-url")).setFocus(false);
    } 
    if(theEvent.getName().equals("rhip-url")) {
       oscURI_right_hip = theEvent.getStringValue();
       ((Textfield)cp5.controller("rhip-url")).setFocus(false);
    }
    if(theEvent.getName().equals("rknee-url")) {
       oscURI_right_knee = theEvent.getStringValue();
       ((Textfield)cp5.controller("rknee-url")).setFocus(false);
    }
    if(theEvent.getName().equals("rfoot-url")) {
       oscURI_right_foot = theEvent.getStringValue();
       ((Textfield)cp5.controller("rfoot-url")).setFocus(false);
    }
    if(theEvent.getName().equals("torso-url")) {
       oscURI_torso = theEvent.getStringValue();
       ((Textfield)cp5.controller("torso-url")).setFocus(false);
    }
    if(theEvent.getName().equals("neck-url")) {
       oscURI_neck = theEvent.getStringValue();
       ((Textfield)cp5.controller("neck-url")).setFocus(false);
    }
    if(theEvent.getName().equals("head-url")) {
       oscURI_head = theEvent.getStringValue();
       ((Textfield)cp5.controller("head-url")).setFocus(false);
    }
  }
  
  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } 
  else if (theEvent.isController()) {
//    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
    toggleJointSend(theEvent.getController());
  }
}

/**
 * Turn on/off joint sends via append/pop from TrackJointArray
 */
void toggleJointSend(Controller controller) {
  String[] match;
//  String[] jointSends = { 
//    "head-send", "neck-send", "torso-send", 
//    "left_hand-send", "left_elbow-send", "left_shoulder-send", 
//    "left_hip-send", "left_knee-send", "left_foot-send", 
//    "right_hand-send", "right_elbow-send", "right_shoulder-send", 
//    "right_hip-send", "right_knee-send", "right_foot-send"
//  };

  match = match(controller.getName(), "-send");
  if (match != null && !(controller.getName().equals("alljoints_send"))) {
    println(controller.getName() + ": val: " + controller.getValue());
    //remove "-send"
    //conver to Uppercase and then assign jointID to jointArray
    String trackJointSplit[] = controller.getName().split("-");
    String trackJoint = trackJointSplit[0];
    int trackJointGate = int(controller.getValue());
    int tempJointID = getJointID("SKEL_" + trackJoint.toUpperCase());
    //    println(trackJoint.toUpperCase());
    if (trackJointGate == 1) {
      //check to see if in the joint array already. only add if not in the array
      if (! in_intArray(tempJointID, trackJointArray)) {
        println("not in the joint array");
        //not in the joint array, so add 
        addJointID(tempJointID);
      }
    } 
    else { //trackJointGate is off.  remove jointID from the trackJointArray
      if (in_intArray(tempJointID, trackJointArray)) {
        removeJointID(tempJointID);
      }
    }
  } 
}
