/**
 * creates the instructions panel
 */
void createInstructionsPanel() {
  int panelW = 450;
  int panelH = 345;
  // create a group to store the oscBox elements
  //instructionsPanel = cp5.addGroup("instructions",width/2 - 150,100,300);
  instructionsPanel = cp5.addGroup("instructions", width/2 - panelW/2, 100, panelW);
  instructionsPanel.setBackgroundHeight(panelH);
  instructionsPanel.setBackgroundColor(color(0, 255));
  instructionsPanel.hideBar();

  //Textareas take up a lot of CPU for some reason (too many Textareas will freeze Processing). 
  //Odd and static spacing enables line breaks and saves CPU 
  //BUT is ineffective and time-consuming to restyle.
  Textarea readme = cp5.addTextarea("readme");
  configureInstructionsText(readme, panelW, panelH, 5, 1);
  readme.setText("simpleK is an interface for the Kinect and any OSC-ready application."
    +"        "
    +"1. Click on the 'OSC Config' tab and set the output OSC controls.              "
    +"2. Click on the 'OSC Skeleton' tab and turn on joint sends.                    "
    +" You must toggle a joint before any information is sent.");
  
  Textarea readmeKey = cp5.addTextarea("readmeKeyTitle");
  configureInstructionsText(readmeKey, panelW, panelH, 5, 6);
  readmeKey.setText("Use your keyboard to control the interface.                                                  "
    +"'k' configures OSC with Kyma.                                                                 "
    +"'S' toggles skeleton tracking.                                                                    "
    +"'C' toggles Center of Mass (CoM) tracking.                                                "
    +"'P' toggles the point cloud (saves on CPU).                                               "
    +"'1','2','3','4' manually switches the skeleton between users.                          "
    +"'D' toggles sending specific joint messages (see below)"
  );
  
  Textarea readmeJoints = cp5.addTextarea("readmeJoints");
  configureInstructionsText(readmeJoints, panelW, panelH, 5, 14);
  readmeJoints.setText("simpleK sends distances between certain joints. (on by default)"
    +"               "
    +"The joint distances sent are:                                                                  "
    +"     /lhandToRhand, /lhandToTorso, "
    +"/rhandToTorso, /lhandToRfoot, /rhandToLfoot, /lhandToHead, and /rhandToHead"
  );
  
  Textarea readmeCredits = cp5.addTextarea("readmeCredits");
  configureInstructionsText(readmeCredits, panelW, panelH, 5, 21);
  readmeCredits.setText("                               "
    +"simpleKinect is by Jon Bellona.  ");//http://jpbellona.com
  
  cp5.addButton("gotojpbellona")
    .setPosition(panelW-125, panelH-33)
    .setColorBackground(200)
    .setSize(115,20)
    .setCaptionLabel("   http://jpbellona.com")
    .moveTo(instructionsPanel);
}

void configureInstructionsText(Textarea text, int panelW, int panelH, int indent, int lineNum) {
 int lineH = 15;
 text.setPosition(indent, lineNum*lineH)
    .setSize(panelW, panelH)
    .setFont(createFont("helvetica", lineH-2))
    .setLineHeight(lineH)
    .setColor(color(255)); 
 text.moveTo(instructionsPanel);
}

void gotojpbellona (float v) {
 link("http://jpbellona.com"); 
}
