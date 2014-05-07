/*
 * SimpleOpenNI user events
 * @since simple-openni version 0.26 (auto-calibration)
 * @credit Max Rheiner / Interaction Design / zhdk / http://iad.zhdk.ch/
 * Below are Max's functions.
 */

/**
 * when new user identified, start calibrating
 */
//void onNewUser(int userId) {
//  println("onNewUser - userId: " + userId);
//  println("  start pose detection");
//  
//  if(autoCalib)
//    kinect.requestCalibrationSkeleton(userId,true);
//  else    
//    kinect.startPoseDetection("Psi",userId);
//}
void onNewUser(SimpleOpenNI curContext,int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  kinect.startTrackingSkeleton(userId);
}

/**
 * when new user is lost, print confirmation to the screen
 */
void onLostUser(int userId) {
  println("onLostUser - userId: " + userId);
}

/**
 * when calibrating starts, print confirmation to the screen
 */
void onStartCalibration(int userId) {
  println("onStartCalibration - userId: " + userId);
}

/**
 * if calibrating succeeds, start tracking
 * if calibrating fails, request Psi pose
 */
//void onEndCalibration(int userId, boolean successfull) {
//  println("onEndCalibration - userId: " + userId + ", successfull: " + successfull);
//  if (successfull) { 
//    println("  User calibrated !!!");
//    kinect.startTrackingSkeleton(userId); 
//    trackUserNum = userId;
//  } 
//  else { 
//    println("  Failed to calibrate user !!!");
//    println("  Start pose detection");
//    kinect.startPoseDetection("Psi",userId);
//  }
//}

/**
 * calibrating via pose
 */
//void onStartPose(String pose,int userId) {
//  println("onStartdPose - userId: " + userId + ", pose: " + pose);
//  println(" stop pose detection");
//  kinect.stopPoseDetection(userId); 
//  kinect.requestCalibrationSkeleton(userId, true);
//}

/**
 * when calibrating via pose ends, print confirmation to the screen
 */
void onEndPose(String pose,int userId) {
  println("onEndPose - userId: " + userId + ", pose: " + pose);
}

/**
 * draw the skeleton with the selected joints
 */
void drawSkeleton(int userId) {
  strokeWeight(3);

  // to get the 3d joint data
  drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
  
  drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);  

  strokeWeight(1); 
}

/**
 * draw a limb (line) between the selected joints
 */
void drawLimb(int userId,int jointType1,int jointType2) {
  PVector jointPos1 = new PVector();
  PVector jointPos2 = new PVector();
  float  confidence;
  
  // draw the joint position
  confidence = kinect.getJointPositionSkeleton(userId,jointType1,jointPos1);
  confidence = kinect.getJointPositionSkeleton(userId,jointType2,jointPos2);

  stroke(255,0,0,confidence * 200 + 55);
  line(jointPos1.x,jointPos1.y,jointPos1.z,
       jointPos2.x,jointPos2.y,jointPos2.z);
  
  drawJointOrientation(userId,jointType1,jointPos1,50);
}

/**
 * show joints with three short lines, drawn with 3D orientation
 */
void drawJointOrientation(int userId,int jointType,PVector pos,float length) {
  // draw the joint orientation  
  PMatrix3D  orientation = new PMatrix3D();
  float confidence = kinect.getJointOrientationSkeleton(userId,jointType,orientation);
  if(confidence < 0.001f) 
    // nothing to draw, orientation data is useless
    return;
    
  pushMatrix();
    translate(pos.x,pos.y,pos.z);
    
    // set the local coordsys
    applyMatrix(orientation);
    
    // coordsys lines are 100mm long
    // x - r
    stroke(255,0,0,confidence * 200 + 55);
    line(0,0,0,
         length,0,0);
    // y - g
    stroke(0,255,0,confidence * 200 + 55);
    line(0,0,0,
         0,length,0);
    // z - b    
    stroke(0,0,255,confidence * 200 + 55);
    line(0,0,0,
         0,0,length);
  popMatrix();
}


void getBodyDirection(int userId,PVector centerPoint,PVector dir)
{
  PVector jointL = new PVector();
  PVector jointH = new PVector();
  PVector jointR = new PVector();
  float  confidence;
  
  // draw the joint position
  confidence = kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_SHOULDER,jointL);
  confidence = kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_HEAD,jointH);
  confidence = kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_SHOULDER,jointR);
  
  // take the neck as the center point
  confidence = kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,centerPoint);
  
  /*  // manually calc the centerPoint
  PVector shoulderDist = PVector.sub(jointL,jointR);
  centerPoint.set(PVector.mult(shoulderDist,.5));
  centerPoint.add(jointR);
  */
  
  PVector up = new PVector();
  PVector left = new PVector();
  
  up.set(PVector.sub(jointH,centerPoint));
  left.set(PVector.sub(jointR,centerPoint));
  
  dir.set(up.cross(left));
  dir.normalize();
}
