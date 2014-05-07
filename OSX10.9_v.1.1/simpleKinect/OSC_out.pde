/*
 * outgoing functions for joint nodes as OSC messages.
 * Tracked Skeleton ONLY
 *
 * @author Jon Bellona
 * @release 1.0
 */
 


/**
 * Generates and outputs all our OSC messages dealing with tracked users
 *
 * @param int trackUserNum  the userID of tracked user
 * @see updateTracking() in customTracking
 */
void sendOSC_tracking(int trackUserNum) {

  if (sendDistances) {
    //send distance between joints (in mm)
    //the hands
    sendOSC_jointDistance(trackUserNum,  SimpleOpenNI.SKEL_LEFT_HAND,  SimpleOpenNI.SKEL_RIGHT_HAND, "/lhandToRhand");
    //hands and torso
    sendOSC_jointDistance(trackUserNum,  SimpleOpenNI.SKEL_LEFT_HAND,  SimpleOpenNI.SKEL_TORSO, "/lhandToTorso");
    sendOSC_jointDistance(trackUserNum,  SimpleOpenNI.SKEL_RIGHT_HAND,  SimpleOpenNI.SKEL_TORSO, "/rhandToTorso");
    //hands and opposite foot
    sendOSC_jointDistance(trackUserNum,  SimpleOpenNI.SKEL_LEFT_HAND,  SimpleOpenNI.SKEL_RIGHT_FOOT, "/lhandToRfoot");
    sendOSC_jointDistance(trackUserNum,  SimpleOpenNI.SKEL_RIGHT_HAND,  SimpleOpenNI.SKEL_LEFT_FOOT, "/rhandToLfoot");
    //hands and head
    sendOSC_jointDistance(trackUserNum,  SimpleOpenNI.SKEL_LEFT_HAND,  SimpleOpenNI.SKEL_HEAD, "/lhandToHead");
    sendOSC_jointDistance(trackUserNum,  SimpleOpenNI.SKEL_RIGHT_HAND,  SimpleOpenNI.SKEL_HEAD, "/rhandToHead");
  }

  sendOSC_int(remoteLocation, "/userId", trackUserNum);
  //send joints out as OSC messages, only specific joints (default is ALL joints)
            //real world -> getSpecificUserJoints()
            //projective -> getSpecificUserJoints_ScreenMode()
         
  //send skeleton as OSC based upon joint array and individual modes
  if (trackJointArray.length > 0) {  
    sendOSC_skeleton(trackUserNum, trackJointArray);   
  }
}

/**
 * Sends a user joints from a PVector array out as OSC messages
 *
 * @author Jon Bellona
 * @param int the usersID
 * @param PVector joint array
 */
void sendOSC_skeleton(int userId, int[] trackJoints) {
  //initialize our joint container
  PVector tempJoint = new PVector();
  DropdownList d;
  
  for (int i=0; i < trackJoints.length; i++) {
    
    switch(trackJoints[i]) {
      case 1:
        d = cp5.get(DropdownList.class, jointNames[0] + "-mode");
        tempJoint = getJointMode(userId, SimpleOpenNI.SKEL_HEAD, int(d.getValue()));
        sendOSC_joint(tempJoint, userId, oscURI_head);
        break;
      case 2:
        d = cp5.get(DropdownList.class, jointNames[1] + "-mode");
        tempJoint = getJointMode(userId, SimpleOpenNI.SKEL_NECK, int(d.getValue()));
        sendOSC_joint(tempJoint, userId, oscURI_neck);
        break;
      case 3:
        d = cp5.get(DropdownList.class, jointNames[2] + "-mode");
        tempJoint = getJointMode(userId, SimpleOpenNI.SKEL_TORSO, int(d.getValue()));
        sendOSC_joint(tempJoint, userId, oscURI_torso);
        break;
      case 6:
        d = cp5.get(DropdownList.class, "left_shoulder-mode");
        tempJoint = getJointMode(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, int(d.getValue()));
        sendOSC_joint(tempJoint, userId, oscURI_left_shoulder);
        break;
      case 7:
        d = cp5.get(DropdownList.class, "left_elbow-mode");
        tempJoint = getJointMode(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, int(d.getValue()));
        sendOSC_joint(tempJoint, userId, oscURI_left_elbow);
        break;
      case 9:
        d = cp5.get(DropdownList.class, "left_hand-mode");
        tempJoint = getJointMode(userId, SimpleOpenNI.SKEL_LEFT_HAND, int(d.getValue()));
        sendOSC_joint(tempJoint, userId, oscURI_left_hand);
        break;
      case 12:
        d = cp5.get(DropdownList.class, "right_shoulder-mode");
        tempJoint = getJointMode(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, int(d.getValue()));
        sendOSC_joint(tempJoint, userId, oscURI_right_shoulder);
        break;
      case 13:
        d = cp5.get(DropdownList.class, "right_elbow-mode");
        tempJoint = getJointMode(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, int(d.getValue()));
        sendOSC_joint(tempJoint, userId, oscURI_right_elbow);
        break;
      case 15:
        d = cp5.get(DropdownList.class, "right_hand-mode");
        tempJoint = getJointMode(userId, SimpleOpenNI.SKEL_RIGHT_HAND, int(d.getValue()));
        sendOSC_joint(tempJoint, userId, oscURI_right_hand);
        break;
      case 17:
        d = cp5.get(DropdownList.class, "left_hip-mode");
        tempJoint = getJointMode(userId, SimpleOpenNI.SKEL_LEFT_HIP, int(d.getValue()));
        sendOSC_joint(tempJoint, userId, oscURI_left_hip);
        break;
      case 18:
        d = cp5.get(DropdownList.class, "left_knee-mode");
        tempJoint = getJointMode(userId, SimpleOpenNI.SKEL_LEFT_KNEE, int(d.getValue()));
        sendOSC_joint(tempJoint, userId, oscURI_left_knee);
        break;
      case 20:
        d = cp5.get(DropdownList.class, "left_foot-mode");
        tempJoint = getJointMode(userId, SimpleOpenNI.SKEL_LEFT_FOOT, int(d.getValue()));
        sendOSC_joint(tempJoint, userId, oscURI_left_foot);
        break;
      case 21:
        d = cp5.get(DropdownList.class, "right_hip-mode");
        tempJoint = getJointMode(userId, SimpleOpenNI.SKEL_RIGHT_HIP, int(d.getValue()));
        sendOSC_joint(tempJoint, userId, oscURI_right_hip);
        break;
      case 22:
        d = cp5.get(DropdownList.class, "right_knee-mode");
        tempJoint = getJointMode(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, int(d.getValue()));
        sendOSC_joint(tempJoint, userId, oscURI_right_knee);
        break;
      case 24:
        d = cp5.get(DropdownList.class, "right_foot-mode");
        tempJoint = getJointMode(userId, SimpleOpenNI.SKEL_RIGHT_FOOT, int(d.getValue()));
        sendOSC_joint(tempJoint, userId, oscURI_right_foot);
        break;
    }
  } //end for loop
}

/**
 * return joint based upon the individual tracking mode
 */
PVector getJointMode(int userId, int jointID, int mode) {
  PVector tempJoint = new PVector();
  
  switch(mode) {
    case 0:
      kinect.getJointPositionSkeleton(userId,jointID,tempJoint);
      break; 
    case 1:
      tempJoint = convertJoint(userId, jointID);
      break;
    case 2:
      tempJoint = convertJointBodyMode(userId, jointID);
      break;
  }
  
  return tempJoint;
}

/**
 * send the PVector joint as separate /x/y/z osc messages
 */
void sendOSC_joint(PVector joint, int userId, String address) {
  float[] jointPositions = { 0, 0, 0 };
  if (joint != null && joint.x != 0) {
    jointPositions[0] = joint.x; 
    jointPositions[1] = joint.y;
    jointPositions[2] = joint.z;
  }
  sendOSC_floatArray(remoteLocation, address, jointPositions);
  //v.1.0.0 (multi skeleton support) was...
  //sendOSC_floatArray(remoteLocation,  "/" + userId + address, jointPositions);
}


/**
 * send a simple OSC integer message.
 */
void sendOSC_int (NetAddress remoteLoc, String url, int messInt) {
  OscMessage simpleMessage = new OscMessage(url);
  simpleMessage.add(messInt);
  oscP5.send(simpleMessage, remoteLoc);
}

/**
 * send a simple OSC float message.
 */
void sendOSC_float (NetAddress remoteLoc, String url, float messF) {
  OscMessage simpleMessage = new OscMessage(url);
  simpleMessage.add(messF);
  oscP5.send(simpleMessage, remoteLoc);
}

/**
 * send a simple OSC PVector message (bundle of floats).
 */
void sendOSC_PVector (NetAddress remoteLoc, String url, PVector messPV) {
  float[] jointPositions = messPV.array(); //return PVector as float array
  OscBundle bundle = new OscBundle();
  OscMessage message = new OscMessage("/placeholder");
  String[] pvdimen = { "/x", "/y", "/z" };
  for (int i=0; i<jointPositions.length; i++){
    message.clear();
    message.setAddrPattern(url + pvdimen[i]);
    message.add(jointPositions[i]);
    bundle.add(message);
  }
  oscP5.send(bundle, remoteLoc);
  //easiest way to send all coords as packed message with breakouts is
  //float[] jointPositions = messPV.array(); //return PVector as float array
  //OscMessage message = new OscMessage(url);
  //message.add(jointPositions);
  //oscP5.send(message, remoteLoc);
}

/**
 * send a simple OSC PVector message (bundle of floats).
 */
void sendOSC_floatArray (NetAddress remoteLoc, String url, float[] jointPositions) {
  OscBundle bundle = new OscBundle();
  OscMessage message = new OscMessage("/placeholder");
  String[] pvdimen = { "/x", "/y", "/z" };
  for (int i=0; i<jointPositions.length; i++){
    message.clear();
    message.setAddrPattern(url + pvdimen[i]);
    message.add(jointPositions[i]);
    bundle.add(message);
  }
  oscP5.send(bundle, remoteLoc);
}


/*
 * Send the relative distance between two joints, in mm, as OSC
 * OSC format: /distance_hands float
 *
 * example: sendOSC_jointDistance(trackUserNum, SimpleOpenNI.SKEL_LEFT_HAND, SimpleOpenNI.SKEL_RIGHT_FOOT, "/lefthand_to_rightfoot");
 *
 * @author Jon Bellona <jon@deecerecords.com>
 * @param int userID     The number of the tracking Skeleton
 * @param int jointIDA   eg. SimpleOpenNI.SKEL_LEFT_HAND
 * @param int jointIDB   eg. SimpleOpenNI.SKEL_RIGHT_HAND
 * @param String url     The OSC /routing_url
 * @requires oscP5 library
 * @requires user must set output port to variable "NetAddress myRemoteLocation;"
 */
void sendOSC_jointDistance (int userId, int jointA, int jointB, String url) {
  
  PVector jointA_pv = new PVector();
  PVector jointB_pv = new PVector();
 
  kinect.getJointPositionSkeleton(userId, jointA, jointA_pv);
  kinect.getJointPositionSkeleton(userId, jointB, jointB_pv);

  //calculate difference
  PVector differenceVector = PVector.sub(jointA_pv, jointB_pv);
  
  //calculate distance and direction of difference Vector
  float magnitude = differenceVector.mag();
  differenceVector.normalize();
  
  // create the OSC message
  OscMessage relDist = new OscMessage(url);  // f
  relDist.add(magnitude);
  oscP5.send(relDist, remoteLocation); 
}
