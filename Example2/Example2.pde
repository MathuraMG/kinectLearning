// Daniel Shiffman
// All features test

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*; //<>//

Kinect2 kinect2;

void setup() {
  size(512, 424, P2D);

  kinect2 = new Kinect2(this);
  kinect2.initVideo();
  kinect2.initDepth();
  kinect2.initIR();
  kinect2.initRegistered();
  // Start all data
  kinect2.initDevice();
}


void draw() {
  background(0);
  //image(kinect2.getVideoImage(), 0, 0, kinect2.colorWidth*0.267, kinect2.colorHeight*0.267);
  //image(kinect2.getDepthImage(), kinect2.depthWidth, 0);
  //image(kinect2.getIrImage(), 0, kinect2.depthHeight);
  PImage img = kinect2.getRegisteredImage();
  image(img, 0, 0);
  int index = mouseX+ mouseY*kinect2.depthWidth;
  float p_color = red(img.pixels[index]);
  
  text("Framerate: " + (int)(frameRate), 10, 585);
  text("mousePosition: " + (int)(mouseX) + "," + (int)(mouseY), 10, 400);
  println(red(img.pixels[index]),green(img.pixels[index]),blue(img.pixels[index]));
  fill(red(img.pixels[index]),green(img.pixels[index]),blue(img.pixels[index]));
  rect(300, 385, 100, 30);
}