/*
 * Miscellaneous Kinect functions used throughout
 * @author Jon Bellona
 */

/**
 * position the camera angle for Processing's view
 */
void updateCamera() {
  translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);
  translate(0,0,-800);  // set rotation center of scene 1000 infront of camera
}

/**
 * Draw point cloud so we can see ourselves.
 */
void drawDepthMap() {
 int[]   depthMap = kinect.depthMap();
  int     steps   = 15;  // to speed up the drawing, draw every third point
  int     index;
  PVector realWorldPoint;

  stroke(100); 
  strokeWeight(1);
  for(int y=0;y < kinect.depthHeight();y+=steps)
  {
    for(int x=0;x < kinect.depthWidth();x+=steps)
    {
      index = x + y * kinect.depthWidth();
      if(depthMap[index] > 0)
      { 
        // draw the projected point
        realWorldPoint = kinect.depthMapRealWorld()[index];
        point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);
      }
    } 
  }  
}

/**
 * loop through kinect map and draw point cloud
 * drawing every 90 steps to speed up CPU
 */
void drawPointCloud() {
  PVector[] depthPoints = kinect.depthMapRealWorld();
  
  for (int i=0; i< depthPoints.length; i+=90) {
    PVector currentPoint = depthPoints[i];
    stroke(255);
    point(currentPoint.x, currentPoint.y, currentPoint.z);
  } //end for loop depthPoints
}


/**
 * Checks if the given value exists in the array
 */   
boolean in_strArray (String needle, String[] haystack) {

  // discuss at: http://phpjs.org/functions/in_array    
  for (int i = 0; i < haystack.length; i++) {
    if (haystack[i].equals(needle) == true) {
        return true;
    }
  }
  return false;
}

/**
 * Checks if the given value exists in the array
 */   
boolean in_intArray (int needle, int[] haystack) {

  // discuss at: http://phpjs.org/functions/in_array    
  for (int i = 0; i < haystack.length; i++) {
    if (haystack[i] == needle) {
        return true;
    }
  }
  return false;
}

/**
 * print text to the 3D screen
 */
void textToScreen(String message, int posX, int posY, int posZ) {
//  pushMatrix();
    fill(255,255,255,200);
    translate(posX,posY,posZ); //-75, -100, -300 for box size 250
    rotateX(rotX);
    text(message, 0, 0);
    rotateX(rotX);
//  popMatrix();
}
