/**
 * Functions related to joint PVectors and PVector conversion
 */

/*
 * Return the relative distance between two joints, in mm
 *
 * @author Jon Bellona <jon@deecerecords.com>
 * @param int userID     The number of the tracking Skeleton
 * @param int jointIDA   eg. SimpleOpenNI.SKEL_LEFT_HAND
 * @param int jointIDB   eg. SimpleOpenNI.SKEL_RIGHT_HAND
 * @return float jointDistance  The distance between joints in mm
 */
float getJointDistance (int userId, int jointA, int jointB) {
  
  PVector jointA_pv = new PVector();
  PVector jointB_pv = new PVector();
 
  kinect.getJointPositionSkeleton(userId, jointA, jointA_pv);
  kinect.getJointPositionSkeleton(userId, jointB, jointB_pv);

  //calculate difference
  PVector differenceVector = PVector.sub(jointA_pv, jointB_pv);
  
  //calculate distance and direction of difference Vector
  float jointDistance = differenceVector.mag();
  differenceVector.normalize();

  return jointDistance;
}

//the integers corresponding to the OpenNI joint
  //1. SimpleOpenNI.SKEL_HEAD
  //2. SimpleOpenNI.SKEL_NECK
  //3. SimpleOpenNI.SKEL_TORSO
  //5. SimpleOpenNI.SKEL_LEFT_COLLAR  - no bueno
  //6. SimpleOpenNI.SKEL_LEFT_SHOULDER
  //7. SimpleOpenNI.SKEL_LEFT_ELBOW
  //9. SimpleOpenNI.SKEL_LEFT_HAND
  //10. SimpleOpenNI.SKEL_LEFT_FINGERTIP  - no bueno
  //11. SimpleOpenNI.SKEL_RIGHT_COLLAR  - no bueno
  //12. SimpleOpenNI.SKEL_RIGHT_SHOULDER
  //13. SimpleOpenNI.SKEL_RIGHT_ELBOW
  //15. SimpleOpenNI.SKEL_RIGHT_HAND
  //16. SimpleOpenNI.SKEL_RIGHT_FINGERTIP  - no bueno
  //17. SimpleOpenNI.SKEL_LEFT_HIP
  //18. SimpleOpenNI.SKEL_LEFT_KNEE
  //19. SimpleOpenNI.SKEL_LEFT_ANKLE - no bueno
  //20. SimpleOpenNI.SKEL_LEFT_FOOT
  //21. SimpleOpenNI.SKEL_RIGHT_HIP
  //22. SimpleOpenNI.SKEL_RIGHT_KNEE
  //23. SimpleOpenNI.SKEL_RIGHT_ANKLE  - no bueno
  //24. SimpleOpenNI.SKEL_RIGHT_FOOT


/**
 * Gets a user joints as PVectors and returns the PVector array
 *
 * @author Jon Bellona
 * @param int user's ID
 * @return PVector[] - array of user joints
 */
PVector[] getUserJoints(int userId) {
  //initialize our joint containers
  PVector[] joints = new PVector[15];
  for (int i = 0; i < joints.length; i++) {
    joints[i] = new PVector(); 
  }
   
  // get the 3D joint data 
  // orientation is screen based, orientation has imageMode(CENTER), so values are between -1 and +1.
  // i.e. x:(-width and width) y:(-height and height), z is real world depth based (0-8000)
  
  //this is where you should turn on/off joint collection
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_HEAD,joints[0]);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,joints[1]);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_TORSO, joints[2]);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_SHOULDER,joints[3]);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_ELBOW,joints[4]);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,joints[5]);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_SHOULDER,joints[6]);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_ELBOW,joints[7]);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HAND,joints[8]);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HIP,joints[9]);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_KNEE,joints[10]);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_FOOT,joints[11]);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HIP,joints[12]);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_KNEE,joints[13]);
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_FOOT,joints[14]);
  
  return joints;
}

/**
 * Returns all user joints as PVectors in Screen Mode
 *
 * @author Jon Bellona
 * @param int user's ID
 * @return PVector[] - array of user joints
 */
PVector[] getUserJoints_ScreenMode(int userId) {
  //initialize our joint containers
  PVector[] joints = new PVector[15];
  for (int i = 0; i < joints.length; i++) {
    joints[i] = new PVector(); 
  }
  
  //this is where you should turn on/off joint collection
  joints[0] = convertJoint(userId, SimpleOpenNI.SKEL_HEAD);
  joints[1] = convertJoint(userId, SimpleOpenNI.SKEL_NECK);
  joints[2] = convertJoint(userId, SimpleOpenNI.SKEL_TORSO);
  joints[3] = convertJoint(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  joints[4] = convertJoint(userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
  joints[5] = convertJoint(userId, SimpleOpenNI.SKEL_LEFT_HAND);
  joints[6] = convertJoint(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  joints[7] = convertJoint(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  joints[8] = convertJoint(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
  joints[9] = convertJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP);
  joints[10] = convertJoint(userId, SimpleOpenNI.SKEL_LEFT_KNEE);
  joints[11] = convertJoint(userId, SimpleOpenNI.SKEL_LEFT_FOOT);
  joints[12] = convertJoint(userId, SimpleOpenNI.SKEL_RIGHT_HIP);
  joints[13] = convertJoint(userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
  joints[14] = convertJoint(userId, SimpleOpenNI.SKEL_RIGHT_FOOT);
  
  return joints;
}

/**
 * Returns all user joints as PVectors in Body Mode
 *
 * @author Jon Bellona
 * @param int user's ID
 * @return PVector[] - array of user joints
 */
PVector[] getUserJoints_BodyMode(int userId) {
  //initialize our joint containers
  PVector[] joints = new PVector[15];
  for (int i = 0; i < joints.length; i++) {
    joints[i] = new PVector(); 
  }
  
  //this is where you should turn on/off joint collection
  joints[0] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_HEAD);
  joints[1] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_NECK);
  joints[2] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_TORSO);
  joints[3] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  joints[4] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
  joints[5] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_LEFT_HAND);
  joints[6] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  joints[7] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  joints[8] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
  joints[9] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_LEFT_HIP);
  joints[10] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_LEFT_KNEE);
  joints[11] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_LEFT_FOOT);
  joints[12] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_RIGHT_HIP);
  joints[13] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
  joints[14] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_RIGHT_FOOT);
  
  return joints;
}

/**
 * Converts a joint from real world to projective PVector
 *
 * @return PVector joint
 */
PVector convertJoint(int userId, int jointID) {
  PVector joint = new PVector();
  float confidence = kinect.getJointPositionSkeleton(userId, jointID, joint);
  if(confidence < 0.5) {
    PVector empty = new PVector();
    return empty;
  }
  PVector convertedJoint = new PVector();
  kinect.convertRealWorldToProjective(joint, convertedJoint);
  //println("x: " + convertedJoint.x + ", y: " + convertedJoint.y + ", z: " + convertedJoint.z);
  
  return convertedJoint;
}

/**
 * Converts a joint from real world to a PVector relative to CoM (Center of Mass)
 *
 * @return PVector joint
 */
PVector convertJointBodyMode(int userId, int jointID) {
  PVector joint = new PVector();
  float confidence = kinect.getJointPositionSkeleton(userId, jointID, joint);
  if(confidence < 0.5) {
    PVector empty = new PVector();
    return empty;
  }
  PVector torso = new PVector();
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_TORSO, torso);

  joint.x = joint.x - torso.x;
  joint.y = joint.y - torso.y;
  joint.z = joint.z - torso.z;

  return joint;
}

/**********************************************************/
/************** User Control -- Getting Joints ************/
/**********************************************************/

/**
 * Get only selected skeleton joints and return as a PVector array 
 * (to increase CPU for sending via OSC messages). 
 * User can turn on/off which joints to send.
 *
 * @author Jon Bellona
 * @param int user's ID
 * @param int[] the joints to track
 * @return PVector[] joints
 */
PVector[] getSpecificUserJoints(int userId, int[] trackJoints) {
  //initialize our joint containers
  PVector[] joints = new PVector[15];
  for (int i = 0; i < joints.length; i++) {
    joints[i] = new PVector(); 
  }
   
  //collect only the joints specified by trackJoints array
  //case numbers dependent upon the OpenNI framework, but then saved into an ordered array
  for (int i=0; i < trackJoints.length; i++) {
    
    switch(trackJoints[i]) {
      case 1:
        kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_HEAD,joints[0]);
        break;
      case 2:
        kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,joints[1]);
        break;
      case 3:
        kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_TORSO, joints[2]);
        break;
      case 6:
        kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_SHOULDER,joints[3]);
        break;
      case 7:
        kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_ELBOW,joints[4]);
        break;
      case 9:
        kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,joints[5]);
        break;
      case 12:
        kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_SHOULDER,joints[6]);
        break;
      case 13:
        kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_ELBOW,joints[7]);
        break;
      case 15:
        kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HAND,joints[8]);
        break;
      case 17:
        kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HIP,joints[9]);
        break;
      case 18:
        kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_KNEE,joints[10]);
        break;
      case 20:
        kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_FOOT,joints[11]);
        break;
      case 21:
        kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HIP,joints[12]);
        break;
      case 22:
        kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_KNEE,joints[13]);
        break;
      case 24:
        kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_FOOT,joints[14]);
        break;
    }
  } //end for loop, joint collection array
  
  return joints;
}


/**
 * Return an array of selected skeleton joints as Projective/Screen PVectors 
 * (to increase CPU of OSC messages. User toggles which joints to send)
 *
 * @author Jon Bellona
 * @param int user's ID
 * @param int[] the joints to track
 * @return PVector[] array of user joints
 */
PVector[] getSpecificUserJoints_ScreenMode(int userId, int[] trackJoints) {
  //initialize our joint containers
  PVector[] joints = new PVector[15];
  for (int i = 0; i < joints.length; i++) {
    joints[i] = new PVector(); 
  }
   
  //collect only the joints specified by trackJoints array
  //case numbers dependent upon the OpenNI framework, but then saved into an ordered array
  for (int i=0; i < trackJoints.length; i++) {
    
    switch(trackJoints[i]) {
      case 1:
        joints[0] = convertJoint(userId, SimpleOpenNI.SKEL_HEAD);
        break;
      case 2:
        joints[1] = convertJoint(userId, SimpleOpenNI.SKEL_NECK);
        break;
      case 3:
        joints[2] = convertJoint(userId, SimpleOpenNI.SKEL_TORSO);
        break;
      case 6:
        joints[3] = convertJoint(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
        break;
      case 7:
        joints[4] = convertJoint(userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
        break;
      case 9:
        joints[5] = convertJoint(userId, SimpleOpenNI.SKEL_LEFT_HAND);
        break;
      case 12:
        joints[6] = convertJoint(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
        break;
      case 13:
        joints[7] = convertJoint(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
        break;
      case 15:
        joints[8] = convertJoint(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
        break;
      case 17:
        joints[9] = convertJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP);
        break;
      case 18:
        joints[10] = convertJoint(userId, SimpleOpenNI.SKEL_LEFT_KNEE);
        break;
      case 20:
        joints[11] = convertJoint(userId, SimpleOpenNI.SKEL_LEFT_FOOT);
        break;
      case 21:
        joints[12] = convertJoint(userId, SimpleOpenNI.SKEL_RIGHT_HIP);
        break;
      case 22:
        joints[13] = convertJoint(userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
        break;
      case 24:
        joints[14] = convertJoint(userId, SimpleOpenNI.SKEL_RIGHT_FOOT);
        break;
    }
  } //end for loop, joint collection array
 
  return joints;
}


/**
 * Return an array of selected skeleton joints as PVectors relative to torso/CoM (Center of Mass) 
 * (to increase CPU of OSC messages. User toggles which joints to send)
 *
 * @author Jon Bellona
 * @param int user's ID
 * @param int[] the joints to track
 * @return PVector[] array of user joints
 */
PVector[] getSpecificUserJoints_BodyMode(int userId, int[] trackJoints) {
  //initialize our joint containers
  PVector[] joints = new PVector[15];
  for (int i = 0; i < joints.length; i++) {
    joints[i] = new PVector(); 
  }
   
  //collect only the joints specified by trackJoints array
  //case numbers dependent upon the OpenNI framework, but then saved into an ordered array
  for (int i=0; i < trackJoints.length; i++) {
    
    switch(trackJoints[i]) {
      case 1:
        joints[0] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_HEAD);
        break;
      case 2:
        joints[1] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_NECK);
        break;
      case 3:
        joints[2] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_TORSO);
        break;
      case 6:
        joints[3] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
        break;
      case 7:
        joints[4] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
        break;
      case 9:
        joints[5] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_LEFT_HAND);
        break;
      case 12:
        joints[6] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
        break;
      case 13:
        joints[7] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
        break;
      case 15:
        joints[8] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
        break;
      case 17:
        joints[9] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_LEFT_HIP);
        break;
      case 18:
        joints[10] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_LEFT_KNEE);
        break;
      case 20:
        joints[11] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_LEFT_FOOT);
        break;
      case 21:
        joints[12] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_RIGHT_HIP);
        break;
      case 22:
        joints[13] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
        break;
      case 24:
        joints[14] = convertJointBodyMode(userId, SimpleOpenNI.SKEL_RIGHT_FOOT);
        break;
    }
  } //end for loop, joint collection array
 
  return joints;
}

/**********************************************************/
/************** User Control -- Sending Joints ************/
/**********************************************************/

/**
 * Returns the OpenNI joint ID based upon an uppercase String.
 */ 
int getJointID(String the_joint) {
  int jointID = 0;
  if (the_joint.equals("SKEL_HEAD") == true) {
    jointID = 1;
  } else if (the_joint.equals("SKEL_NECK") == true) {
    jointID = 2;
  } else if (the_joint.equals("SKEL_TORSO") == true) {
    jointID = 3;
  } else if (the_joint.equals("SKEL_LEFT_SHOULDER") == true) {
    jointID = 6;
  } else if (the_joint.equals("SKEL_LEFT_ELBOW") == true) {
    jointID = 7;
  } else if (the_joint.equals("SKEL_LEFT_HAND") == true) {
    jointID = 9;
  } else if (the_joint.equals("SKEL_RIGHT_SHOULDER") == true) {
    jointID = 12;
  } else if (the_joint.equals("SKEL_RIGHT_ELBOW") == true) {
    jointID = 13;
  } else if (the_joint.equals("SKEL_RIGHT_HAND") == true) {
    jointID = 15;
  } else if (the_joint.equals("SKEL_LEFT_HIP") == true) {
    jointID = 17;
  } else if (the_joint.equals("SKEL_LEFT_KNEE") == true) {
    jointID = 18;
  } else if (the_joint.equals("SKEL_LEFT_FOOT") == true) {
    jointID = 20;
  } else if (the_joint.equals("SKEL_RIGHT_HIP") == true) {
    jointID = 21;
  } else if (the_joint.equals("SKEL_RIGHT_KNEE") == true) {
    jointID = 22;
  } else if (the_joint.equals("SKEL_RIGHT_FOOT") == true) {
    jointID = 24;
  }  
  
 // if (jointID != 0 ) {
    return jointID;
  //}
}

/**
 * Add the joint to our trackJointArray.  
 *
 * jointIDs existing in the trackJointArray, 
 * ensure that the joint coordinates will be sent out as OSC messages.
 *
 * @author Jon Bellona
 */
void addJointID(int jointID) {
 // for (int i=0;i<trackJointArray.length;i++) {
 //   println( trackJointArray[i] );
 // }
  
  //append and then sort the array.
  trackJointArray = append(trackJointArray, jointID);
  trackJointArray = sort(trackJointArray);
  println(trackJointArray);
}

/**
 * Remove the joint from our trackJointArray.  
 *
 * jointIDs existing in the trackJointArray, 
 * ensure that the joint coordinates will be sent out as OSC messages.
 *
 * @author Jon Bellona
 */
void removeJointID(int jointID) {
 for (int i=0;i<trackJointArray.length;i++) {
    int currentJointID = trackJointArray[i];
    
    if (jointID == currentJointID) {
      //jointID matches.  shorten array
      if ((trackJointArray.length >= 1)) {
        if (i == 0) {
          trackJointArray = subset(trackJointArray, 1);
        }
        else if (i == trackJointArray.length - 1) {
          trackJointArray = shorten(trackJointArray);
        }
        //take two subset arrays (minus your jointID)  
        //concat the arrays as trackJointArray[]
        else {
          int[] firstHalf = subset(trackJointArray, 0, i);
          int[] secondHalf = subset(trackJointArray, (i+1), (trackJointArray.length-(i+1)));
          trackJointArray = concat(firstHalf, secondHalf);
        }
      }
    }
  } // for loop 
}
