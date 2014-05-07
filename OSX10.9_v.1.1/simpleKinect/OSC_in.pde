/*
 * incoming OSC messages used to control features of simple-OpenNI user Tracking.
 *
 * @author Jon Bellona
 */
void oscEvent(OscMessage theOscMessage) {
  
  String pattern = theOscMessage.addrPattern();
  String typetag = theOscMessage.typetag();
  
  // print_response(theOscMessage, pattern, typetag);
  // first check if theOscMessage has the address pattern we are looking for.
  // then check the data type.  then set the value.

  // Set the userID for to listen for.  Processing can handle multiple users.  
  // We only care about one.  //comments below establish how OSC messages work inside Processing.
  if (theOscMessage.checkAddrPattern("/trackUser")==true) {
    if (theOscMessage.checkTypetag("i")) {
      int trackUser = theOscMessage.get(0).intValue();
      trackUserNum = trackUser; //save this to a global variable to use inside draw()
    }
  }
  
  // Turn on/off CoM tracking. On by default.
  if (theOscMessage.checkAddrPattern("/trackCoM")==true) {
    if (theOscMessage.checkTypetag("i")) {
      int changeTrackCoM = theOscMessage.get(0).intValue();
      trackCoM = (changeTrackCoM == 1) ? true : false;
      println("trackCoM : " + trackCoM);
    }
  }
  // Turn on/off skeleton tracking.  On by default.
  if (theOscMessage.checkAddrPattern("/trackSkeleton")==true) {
    if (theOscMessage.checkTypetag("i")) {
      int changeTrackSkeleton = theOscMessage.get(0).intValue();
      trackSkeleton = (changeTrackSkeleton == 1) ? true : false;
      println("trackSkeleton : " + trackSkeleton);
    }
  }
  
}


/*
 * Print out any incoming OSC message out to the compiler window.
 */
void print_response(OscMessage theOscMessage, String pattern, String typetag ) {
  println("#######");
  for (int i=0; i< typetag.length(); i++) {
    char type = typetag.charAt(i);
    switch(type) {
      case 'i': 
        println(pattern + ": " + theOscMessage.get(i).intValue());
        break;
      case 'f': 
        println(pattern + ": " + theOscMessage.get(i).floatValue());
        break;
      case 's':
        println(pattern + ": " + theOscMessage.get(i).stringValue());
        break;
    } //end switch
  } //end for
}
