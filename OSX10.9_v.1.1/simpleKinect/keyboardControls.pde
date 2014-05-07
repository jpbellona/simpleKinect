/*
 * Keyboard events used to control Processing view of the pixel arrays
 * @credit Max Rheiner / Interaction Design / zhdk / http://iad.zhdk.ch/
 * Below are his functions.  Mine are for toggling features for user tracking.
 */

void keyPressed() {
  
  switch(key) {
    case ' ':
      kinect.setMirror(!kinect.mirror());
      break;
    case 'C':
      trackCoM = !trackCoM;
      println("trackCoM is " + trackCoM);
      break;
    case 'S':
      trackSkeleton = !trackSkeleton;
      println("trackSkeleton is " + trackSkeleton);
      break;
//    case 'D':
//      drawDepthImage = !drawDepthImage;
//      drawPointCloud = !drawPointCloud;
//      println("drawPointCloud is " + drawPointCloud);
//      println("drawDepthImage is " + drawDepthImage);
//      break;
    case 'D':
      sendDistances = !sendDistances;
      println("sendDistances is " + sendDistances);
      break;
    case 'P':
      drawPointCloud = !drawPointCloud;
//      drawDepthImage = !drawDepthImage;
      println("drawPointCloud is " + drawPointCloud);
//      println("drawDepthImage is " + drawDepthImage);
      break;
    case '1':
      trackUserNum = 1;
      println("trackUserNum is " + trackUserNum);
      break;
    case '2':
      trackUserNum = 2;
      println("trackUserNum is " + trackUserNum);
      break;
    case '3':
      trackUserNum = 3;
      println("trackUserNum is " + trackUserNum);
      break;
    case '4':
      trackUserNum = 4;
      println("trackUserNum is " + trackUserNum);
      break;
    case 'k': //connect to Kyma (requires an OSC message to setup connection)
      sendOSC_float(remoteLocation, "/osc/respond_to", 3333);
      sendOSC_float(remoteLocation, "/tests", 0);
      println("kyma handshake");
      break;
    case 'j':
      println(trackJointArray);
      break;
  }
    
  switch(keyCode) {
    case LEFT:
      rotY += 0.1f;
      println("rotY: " + rotY);
      break;
    case RIGHT:
      // zoom out
      rotY -= 0.1f;
      println("rotY: " + rotY);
      break;
    case UP:
      if(keyEvent.isShiftDown()) {
        zoomF += 0.01f;
        println("zoomF: " + zoomF);
      }
      else {
        rotX += 0.1f;
        println("rotX: " + rotX);
      }
      break;
    case DOWN:
      if(keyEvent.isShiftDown()) {
        zoomF -= 0.01f;
        println("zoomF: " + zoomF);
        if(zoomF < 0.01) {
          zoomF = 0.01;
          println("zoomF: " + zoomF);
        }
      } else {
        rotX -= 0.1f;
        println("rotX: " + rotX);
      }
      break;
   } //end keyCode
}
