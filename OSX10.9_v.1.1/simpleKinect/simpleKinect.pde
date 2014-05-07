/**
 * simpleKinect is an interface application for sending data
 * from the Microsoft Kinect to any OSC-enabled application. 
 * The application attempts to improve upon similar software 
 * by offering more openni features and more user control.
 * 
 * Enables routing of Kinect data to external OSC-enabled software 
 *
 * by Jon Bellona
 * http://jpbellona.com
 *
 * Dependencies
 * simpleopenni:     https://code.google.com/p/simple-openni/
 * controlP5:        www.sojamo.de/libraries/controlP5
 * oscP5:            www.sojamo.de/libraries/oscP5
 */

//kinect library and vars
import processing.opengl.*;
import SimpleOpenNI.*;
SimpleOpenNI  kinect;
boolean  autoCalib = true;
int trackUserNum = 1;  //sets which userID to track
//major function gates
boolean trackCoM = true;
boolean trackSkeleton = true;
boolean drawPointCloud = true;
//boolean drawDepthImage = false;
boolean sendDistances = true;
boolean realWorldMode = false;
boolean projectiveMode = false;
boolean bodyMode = true;
//default array of all joint IDs to track, once we have a skeleton calibrated.
int[] trackJointArray = { };// = new int[15]; //array of openni joint IDs.
int[] depthMap;
//map controls -- keyboard controls Processing only
float zoomF = 0.33f;
float rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                            // the data from openni comes upside down
float rotY = radians(0);
PFont font;

//GUI libary and vars
import controlP5.*;
import java.util.List;
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress remoteLocation;
ControlP5 cp5;
ControlGroup oscControls;
Button oscTab;
int oscBoxResult = -1;
String oscIP = "127.0.0.1";
int oscPort = 8000;
float t;
int centerX, centerY;
ControlGroup skelOSCControls;
Canvas vCanvas;
Button skelTab;
String[] jointNames = { 
    "head", "neck", "torso", 
    "left_hand", "left_elbow", "left_shoulder", 
    "left_hip", "left_knee", "left_foot", 
    "right_hand", "right_elbow", "right_shoulder", 
    "right_hip", "right_knee", "right_foot"
  };
String oscURI_left_hand = "/leftHand";
String oscURI_left_elbow = "/leftElbow";
String oscURI_left_shoulder = "/leftShoulder";
String oscURI_right_hand = "/rightHand";
String oscURI_right_elbow = "/rightElbow";
String oscURI_right_shoulder = "/rightShoulder";
String oscURI_left_hip = "/leftHip";
String oscURI_left_knee = "/leftKnee";
String oscURI_left_foot = "/leftFoot";
String oscURI_right_hip = "/rightHip";
String oscURI_right_knee = "/rightKnee";
String oscURI_right_foot = "/rightFoot";
String oscURI_torso = "/torso";
String oscURI_neck = "/neck";
String oscURI_head = "/head";
ControlGroup instructionsPanel;
Button instructionsTab;
String[] tabNames = { "oscBox", "skelBox", "instructBox" };

void setup() {
  size(720,600,P3D);
  centerX = int(width/2);
  centerY = int(height/2);
  noStroke();
  
  //titlebar
  frame.setTitle("simpleKinect [v.1.1]  by Jon Bellona");
  
  //KINECT setup
  kinect = new SimpleOpenNI(this);
  // enable depthMap generation and other Kinect essentials 
  kinect.enableDepth();
  if(kinect.enableDepth() == false) {
     println("Can't open the depthMap, maybe the camera is not connected!"); 
     exit();
     return;
  }
  kinect.enableUser(); // SimpleOpenNI.SKEL_PROFILE_ALL : no longer requires argument
  kinect.setMirror(true); // mirror is by default enabled
  //kinect.enableScene();
  smooth();  
  //perspective(radians(45), float(width)/float(height), 10, 150000); //default radians(45);
  
  //GUI setup
  cp5 = new ControlP5(this);
  vCanvas = new vitruvianCanvas();
  vCanvas.pre(); // use vCanvas.post(); to draw on top of existing controllers.
  //OSC ports
  createOSCControlBox();
  oscTab = cp5.addButton("oscBox",1,0,20,80,20);
  oscTab.setLabel("OSC Config");
  oscTab.setColorBackground(color(127,127,127));
  oscControls.hide();
  //this tab is for typical skeleton controls
  createSkelOSCControlBox();
  addBodyModeControls();
  skelTab = cp5.addButton("skelBox",1,0,40,80,20);
  skelTab.setLabel("OSC Skeleton");
  skelTab.setColorBackground(color(127,127,127));
  skelOSCControls.hide();
  //tab for instructions
  createInstructionsPanel();
  instructionsTab = cp5.addButton("instructBox", 1, 0, 60, 80, 20);
  instructionsTab.setLabel("Controls");
  instructionsTab.setColorBackground(color(127, 127, 127));
  instructionsPanel.hide();
  textFont(createFont("",300));
  
  // OSC input port
  oscP5 = new OscP5(this, 3301);
  // OSC output port
  remoteLocation = new NetAddress(oscIP, oscPort); //Processing, Kyma, Max, etc.
}


void draw() {
  int bg;
  if (oscControls.isVisible() || 
      skelOSCControls.isVisible() ||
      instructionsPanel.isVisible() ) {
    bg = 128;
  }
  else {
    bg = 0;
  }
  
  //KINECT  loop
  kinect.update(); // update the cam
  background(bg,bg,bg); //reset bg
//  if (drawDepthImage) {
//    image(kinect.depthImage(),0,0);
//  }
  updateCamera(); //position camera position -- effects Processing only
  updateTracking(); //@see customTracking
  camera(); //reset camera for the GUI controls.
}



