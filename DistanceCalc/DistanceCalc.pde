//GETS THE LENGHT OF BLUE OBJECTS


import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

Kinect2 kinect2;

void setup() {
  size(512, 424, P3D);
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initRegistered();
  kinect2.initDevice();
}

void draw() {
  int[] depth  = kinect2.getRawDepth();
  int leftMostX = 424;
  int rightMostX = 0;
  float noPixels = 0;
  PImage color_img = kinect2.getRegisteredImage();
  PVector leftMost = new PVector(0,0,0);
  PVector rightMost = new PVector(0,0,0);

  background(0);
  stroke(255);
  strokeWeight(2);
  int skip = 1;

  for (int x = 0; x<kinect2.depthWidth; x+=skip) {
    for (int y = 0; y<kinect2.depthHeight; y+=skip) {
      int index = x + y*kinect2.depthWidth;
      //PVector point = depthToPointCloudPos(x, y, depth[index]);
      if ((depth[index]<1000 && depth[index]> 500)&&(blue(color_img.pixels[index])>150 && red(color_img.pixels[index]) <58 && green(color_img.pixels[index]) <128)) {
        color_img.pixels[index] = color(255, 0, 0);
        //calculate the left most point here
        if(x<leftMostX){
          leftMostX = x;
          leftMost = depthToPointCloudPos(x,y,depth[index]);
        }
        if(x>rightMostX){
          rightMostX = x;
          rightMost = depthToPointCloudPos(x,y,depth[index]);
        }
      } else {
        color_img.pixels[index] = color(0, 0, 0);
      }
    }
  }
  image(color_img, 0, 0);

  //popMatrix();
  rect(leftMostX,0,10,412);
  rect(rightMostX,0,10,412);
  println((rightMost.x - leftMost.x)/25.4 + "inches");
}

PVector depthToPointCloudPos(int x, int y, float depthValue) {
  PVector point = new PVector();
  point.z = (depthValue);// / (1.0f); // Convert from mm to meters
  point.x = (x - CameraParams.cx) * point.z / CameraParams.fx;
  point.y = (y - CameraParams.cy) * point.z / CameraParams.fy;
  return point;
}