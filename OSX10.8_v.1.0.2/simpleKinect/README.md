
[simpleKinect][4]
=======

simpleKinect is an interface application for sending data from the Microsoft Kinect to any OSC-enabled application. The application attempts to improve upon similar software by offering more openni features and more user control. 

The interface was built with Processing, utilizing the libraries: controlP5, oscP5, and simple-openni. Because I used open-source tools, and because the nature of the project is to stimulate creativity, simpleKinect is free to use.


Features
--------------------------------------------
* Auto-calibration.
* Specify OSC output IP and Port in real time.
* Send CoM (Center of Mass) coordinate of all users inside the space, regardless of skeleton calibration.
* Send skeleton data (single user), on a joint-by-joint basis, as specified by the user.
* Manually switch between users for skeleton tracking.
* Individually select between three joint modes (world, screen, and body) for sending data.
* Individually determine the OSC output url for any joint.
* Save/load application settings.
* Send distances between joints (sent in millimeters). [default is on]


Kinect Driver Installation 
--------------------------------------------
In the off chance that you do not already have Kinect drivers installed, you will need to install them on your computer. The process, once lengthy, has been simplified into two steps. See below.


How to install:

1. The easiest method to install Kinect drivers is to follow the install directions on the simple-openni Processing library site. (Important! You do not need to install the actual SimpleOpenNI library nor Processing. You only need to install the Kinect drivers.)

	  [https://code.google.com/p/simple-openni/wiki/Installation][2]<br>

	For those running OSX 10.8.x, I found these instructions extremely helpful... [http://decyborg.wordpress.com/2013/01/19/kinect-on-os-x-10-8-and-processing/][3]<br><br>

2. Once Kinect drivers have been downloaded and installed, you're done. Open up simpleKinect, and get to work!


[FAQ][5]
----------------------------------------
Visit [jpbellona.com][5] for simpleKinect's [FAQ page][5].

License
----------------------------------------
All files are covered under the GPL v3 license.

simpleKinect, Copyright (C) 2013 [Jon Bellona][1] <[http://jpbellona.com/][1]>

	Released under the GNU General Public License, Version 3.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	  http://www.gnu.org/licenses/gpl.html

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.


[1]: http://jpbellona.com/  "Jon Bellona"
[2]: https://code.google.com/p/simple-openni/wiki/Installation  "simple-openni"
[3]: http://decyborg.wordpress.com/2013/01/19/kinect-on-os-x-10-8-and-processing/ "install kinect drivers"
[4]: http://jpbellona.com/kinect/ "simpleKinect on jpbellona"
[5]: http://deecerecords.com/kinect/simplekinect-faq "simpleKinect FAQ"