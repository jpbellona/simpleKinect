 /**
 * ALL custom user Tracking for the Kinect done inside this tab.
 *
 * @author Jon Bellona
 * @link http://jpbellona.com 
 */

/**
 * Run all kinect user tracking from inside this function
 *
 * Checks for user ids and skeleton tracking, then outputs skeleton data over OSC ports
 *
 * called from inside void draw()
 * @global boolean trackSkeleton
 * @global boolean trackCoM
 * @global NetworkAddress myRemoteLocation
 * @global NetworkAddress myRemoteLocation_max
 */
void updateTracking() {
  
  int userCount = kinect.getNumberOfUsers();   //our test for num# of users
 
  if (userCount > 0) {  
    if (trackCoM) {
      trackAllUsersCenterOfMass();
    }
    
    //v.1.1 show more to user have on by default.
    if(drawPointCloud) {
      drawPointCloud();
    }
    
    if (trackSkeleton) {
      // send skeleton data if it's available
      // default tracking is 1, changed onEndCalibration(), sets trackUserNum var
      if(kinect.isTrackingSkeleton(trackUserNum)) {
        drawSkeleton(trackUserNum); //@see OpenNIuserEvents
        
        //generate all of our OSC messages dealing with user skeletons
        sendOSC_tracking(trackUserNum); //@see OSC_output
        
      } //isTrackingSkeleton
      else {
        failsafe_isNotTrackingSkeleton(); //@see otherFunctions
      }
   
    } //if trackSkeleton
  } //end userCount
}

/**
 * Get all available users CoM positions, and output as OSC messages
 *
 * @author Jon Bellona
 */
 
 void trackAllUsersCenterOfMass() {
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  
  OscBundle CoM = new OscBundle();
  OscMessage userCoM = new OscMessage("/CoM/numUsers");
  userCoM.add(int(userList.size()));
  CoM.add(userCoM);
  int[] userIds = new int[int(userList.size())];
  
  for (int i=0; i<userList.size(); i++) {
    int userId = userList.get(i);
    PVector position = new PVector();
    kinect.getCoM(userId, position);
    
    userIds[i] = userId; 
    
    userCoM.clear();
    userCoM.setAddrPattern("/CoM/" + userId);  // fff
    userCoM.add(new float[] {position.x, position.y, position.z});
    CoM.add(userCoM); 
   
    //draw box at user's CoM
    //only if user is on screen.
    if((position.x != 0) && (position.y != 0) && (position.z != 0)) {
      pushMatrix();
        translate(position.x,position.y,position.z);
        fill(0,0,255,255);
        box(250, 250, 250);
        textToScreen(str(userId), -75, -100, -200);
      popMatrix();
    }
    
  } //end for loop on userList
  
  userCoM.clear();
  userCoM.setAddrPattern("/CoM/userIds"); 
  userCoM.add(userIds);
  CoM.add(userCoM);
  
  //send the bundled OSC messages 
  oscP5.send(CoM, remoteLocation);
 }
 
 

/**
 * Failsafe function. IF user isn't being tracked but we can see her/him on screen.
 *
 * This is a custom function for someone to script. Does nothing currently.
 * If we aren't tracking a skeleton, but we have a userID.
 * @author Jon Bellona
 */
 void failsafe_isNotTrackingSkeleton() {
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  
  for (int i=0; i<userList.size(); i++) {
    int userId = userList.get(i);
    PVector position = new PVector();
    kinect.getCoM(userId, position);
  }
 }
