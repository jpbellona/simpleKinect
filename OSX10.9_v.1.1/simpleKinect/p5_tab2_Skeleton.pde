/**
 * creates the OSC control box with control fields
 */
void createSkelOSCControlBox() {
  // create a group to store the oscBox elements
  skelOSCControls = cp5.addGroup("skelOSCControls",0,0);
//  skelOSCControls.setBackgroundHeight(160);
//  skelOSCControls.setBackgroundColor(color(0,100));
  skelOSCControls.hideBar();

  //add the vitruvianMan image to the controls.
  skelOSCControls.addCanvas(vCanvas);

  cp5.addButton("saveSkelOSC")
    .setPosition(centerX-240, centerY-110)
    .setCaptionLabel("save settings")
    .moveTo(skelOSCControls);
  cp5.addButton("loadSkelOSC")
    .setPosition(centerX-240, centerY-90)
    .setCaptionLabel("load settings")
    .moveTo(skelOSCControls);
  
  addJointToggles();
  
//  CheckBox lelbow_toggle = cp5.addCheckBox("lelbow-send", centerX-210, centerY-230);      
//  customizeCheckbox(lelbow_toggle);
  
  Textfield lhand = cp5.addTextfield("lhand-url",centerX-240,centerY-260,80,20);
  customizeTextfield(lhand, oscURI_left_hand); //Textfield and jointURL
  
  Textfield rhand = cp5.addTextfield("rhand-url",centerX+180,centerY-260,80,20);
  customizeTextfield(rhand, oscURI_right_hand);

  Textfield lelbow = cp5.addTextfield("lelbow-url",centerX-180,centerY-220,80,20);
  customizeTextfield(lelbow, oscURI_left_elbow);

  Textfield relbow = cp5.addTextfield("relbow-url",centerX+120,centerY-220,80,20);
  customizeTextfield(relbow, oscURI_right_elbow);

  Textfield lshoulder = cp5.addTextfield("lshoulder-url",centerX-120,centerY-160,80,20);
  customizeTextfield(lshoulder, oscURI_left_shoulder);

  Textfield rshoulder = cp5.addTextfield("rshoulder-url",centerX+60,centerY-160,80,20);
  customizeTextfield(rshoulder, oscURI_right_shoulder);

  Textfield lhip = cp5.addTextfield("lhip-url",centerX-110,centerY+10,80,20);
  customizeTextfield(lhip, oscURI_left_hip);

  Textfield rhip = cp5.addTextfield("rhip-url",centerX+50,centerY+10,80,20);
  customizeTextfield(rhip, oscURI_right_hip);

  Textfield lknee = cp5.addTextfield("lknee-url",centerX-150,centerY+100,80,20);
  customizeTextfield(lknee, oscURI_left_knee);

  Textfield rknee = cp5.addTextfield("rknee-url",centerX+90,centerY+100,80,20);
  customizeTextfield(rknee, oscURI_right_knee);

  Textfield lfoot = cp5.addTextfield("lfoot-url",centerX-180,centerY+190,80,20);
  customizeTextfield(lfoot, oscURI_left_foot);

  Textfield rfoot = cp5.addTextfield("rfoot-url",centerX+120,centerY+190,80,20);
  customizeTextfield(rfoot, oscURI_right_foot);

  Textfield torso = cp5.addTextfield("torso-url",centerX-40,centerY-50,80,20);
  customizeTextfield(torso, oscURI_torso);

  Textfield neck = cp5.addTextfield("neck-url",centerX-40,centerY-200,80,20);
  customizeTextfield(neck, oscURI_neck);

  Textfield head = cp5.addTextfield("head-url",centerX-40,centerY-250,80,20);
  customizeTextfield(head, oscURI_head);
}

void addJointToggles() {
  Toggle joint_toggle = cp5.addToggle("left_hand-send", false)
    .setPosition(centerX-270, centerY-270);      
  customizeToggle(joint_toggle);

  joint_toggle = cp5.addToggle("left_elbow-send", false)
    .setPosition(centerX-210, centerY-230);      
  customizeToggle(joint_toggle);
  
  joint_toggle = cp5.addToggle("left_shoulder-send", false)
    .setPosition(centerX-150, centerY-170);      
  customizeToggle(joint_toggle);
  
  joint_toggle = cp5.addToggle("right_shoulder-send", false)
    .setPosition(centerX+30, centerY-170);      
  customizeToggle(joint_toggle);
  
  joint_toggle = cp5.addToggle("right_elbow-send", false)
    .setPosition(centerX+90, centerY-230);      
  customizeToggle(joint_toggle);
  
  joint_toggle = cp5.addToggle("right_hand-send", false)
    .setPosition(centerX+150, centerY-270);      
  customizeToggle(joint_toggle);
  
  joint_toggle = cp5.addToggle("left_hip-send", false)
    .setPosition(centerX-140, centerY);      
  customizeToggle(joint_toggle);
  
  joint_toggle = cp5.addToggle("right_hip-send", false)
    .setPosition(centerX+20, centerY);      
  customizeToggle(joint_toggle);
  
  joint_toggle = cp5.addToggle("left_knee-send", false)
    .setPosition(centerX-180, centerY+90);      
  customizeToggle(joint_toggle);
  
  joint_toggle = cp5.addToggle("right_knee-send", false)
    .setPosition(centerX+60, centerY+90);      
  customizeToggle(joint_toggle);
  
  joint_toggle = cp5.addToggle("left_foot-send", false)
    .setPosition(centerX-210, centerY+180);      
  customizeToggle(joint_toggle);
  
  joint_toggle = cp5.addToggle("right_foot-send", false)
    .setPosition(centerX+90, centerY+180);      
  customizeToggle(joint_toggle);
  
  joint_toggle = cp5.addToggle("torso-send", false)
    .setPosition(centerX-70, centerY-60);      
  customizeToggle(joint_toggle);
  
  joint_toggle = cp5.addToggle("neck-send", false)
    .setPosition(centerX-70, centerY-210);      
  customizeToggle(joint_toggle);
  
  joint_toggle = cp5.addToggle("head-send", false)
    .setPosition(centerX-70, centerY-260);      
  customizeToggle(joint_toggle);
  
  joint_toggle = cp5.addToggle("alljoints_send", false)
    .setPosition(centerX+150, centerY-60);      
  customizeToggle(joint_toggle);
  joint_toggle.captionLabel().setVisible(true);
  joint_toggle.setCaptionLabel("Send All Joints");
}

void customizeToggle(Toggle tog) {
  tog.moveTo(skelOSCControls)
  .setColorForeground(color(120))
  .setColorActive(color(255))
  .setColorLabel(color(255))
  .setSize(20, 20);
  tog.captionLabel().setVisible(false);
}

//void customizeCheckbox(CheckBox cb) {
//  cb.moveTo(skelOSCControls)
//  .setColorForeground(color(120))
//  .setColorActive(color(255))
//  .setColorLabel(color(255))
//  .setItemsPerRow(1)
//  .setSpacingColumn(30)
//  .setSpacingRow(20)
//  .setSize(20, 20)
//  .addItem("", 50);  
//}

void customizeTextfield(Textfield tf, String jointUrl) {
  tf.moveTo(skelOSCControls);
  tf.setText(jointUrl);
  tf.captionLabel().setVisible(false);
  tf.setColorForeground(color(20));
  tf.setColorBackground(color(20));
  tf.setColorActive(color(100));
  tf.setAutoClear(false);
}

void saveSkelOSC(float v) {
  cp5.saveProperties("default.ser", "default");
}
void loadSkelOSC(float v) {
  cp5.loadProperties(("default.ser"));
}

/**
 * Add body mode dropdown lists to the OSC Control box
 */
void addBodyModeControls() {

  DropdownList lfoot = cp5.addDropdownList("left_foot-mode")
    .setPosition(centerX-180,centerY+190);
  customizeDropdown(lfoot);

  DropdownList lknee = cp5.addDropdownList("left_knee-mode")
    .setPosition(centerX-150,centerY+100);
  customizeDropdown(lknee);

  DropdownList lhip = cp5.addDropdownList("left_hip-mode")
    .setPosition(centerX-110,centerY+10);
  customizeDropdown(lhip);

  DropdownList rfoot = cp5.addDropdownList("right_foot-mode")
    .setPosition(centerX+120,centerY+190);
  customizeDropdown(rfoot);

  DropdownList rknee = cp5.addDropdownList("right_knee-mode")
    .setPosition(centerX+90,centerY+100);
  customizeDropdown(rknee);

  DropdownList rhip = cp5.addDropdownList("right_hip-mode")
    .setPosition(centerX+50,centerY+10);
  customizeDropdown(rhip);

  DropdownList rshoulder = cp5.addDropdownList("right_shoulder-mode")
    .setPosition(centerX+60,centerY-160);
  customizeDropdown(rshoulder);

  DropdownList relbow = cp5.addDropdownList("right_elbow-mode")
    .setPosition(centerX+120,centerY-220);
  customizeDropdown(relbow);

  DropdownList rhand = cp5.addDropdownList("right_hand-mode")
    .setPosition(centerX+180,centerY-260);
  customizeDropdown(rhand);

  DropdownList lshoulder = cp5.addDropdownList("left_shoulder-mode")
    .setPosition(centerX-120,centerY-160);
  customizeDropdown(lshoulder);

  DropdownList lelbow = cp5.addDropdownList("left_elbow-mode")
    .setPosition(centerX-180,centerY-220);
  customizeDropdown(lelbow);

  DropdownList lhand = cp5.addDropdownList("left_hand-mode")
    .setPosition(centerX-240,centerY-260);
  customizeDropdown(lhand);

  DropdownList torso = cp5.addDropdownList("torso-mode")
    .setPosition(centerX-40,centerY-50);
  customizeDropdown(torso);
  torso.setIndex(0);

  DropdownList neck = cp5.addDropdownList("neck-mode")
    .setPosition(centerX-40,centerY-200);
  customizeDropdown(neck);

  DropdownList head = cp5.addDropdownList("head-mode")
    .setPosition(centerX-40,centerY-250);
  customizeDropdown(head);
}

void customizeDropdown(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.moveTo(skelOSCControls);
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(18);
  ddl.setBarHeight(15);
  ddl.setWidth(80);
  ddl.captionLabel().set("Tracking Mode");
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;
  ddl.addItem("Real-World", 0);
  ddl.addItem("Screen", 1);
  ddl.addItem("Body", 2);
  ddl.setIndex(2);
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}

/**
 * All joints Toggle sets all other joint sends.
 */
void alljoints_send(boolean flag) {
  Toggle temp;
  int val = (flag)? 1 : 0;
  for (int i=0; i<jointNames.length; i++) {
    temp = cp5.get(Toggle.class, jointNames[i] + "-send");
    temp.setValue(val);
  }
}

// vitruvianCanvas, your Canvas render class
class vitruvianCanvas extends Canvas {

  PImage vitruvian;

  public void setup(PApplet theApplet) {
    vitruvian = loadImage("images/daVinciBodyFigLeaf.gif");
  }  

  public void draw(PApplet p) {
    imageMode(CENTER);
    image(vitruvian, width/2, height/2);
    // renders a square with randomly changing colors
  }
}
