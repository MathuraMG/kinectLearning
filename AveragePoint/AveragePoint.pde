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
  int[] depth = kinect2.getRawDepth();
  float sumX = 0;
  float sumY = 0;
  float sumZ = 0;
  float noPixels = 0;
  PImage color_img = kinect2.getRegisteredImage();
  
  background(0);
  stroke(255);
  strokeWeight(2);
  int skip = 1;
  //pushMatrix();
  //translate(width/2, height/2, -1000);
  //beginShape(POINTS);
  for (int x = 0; x<kinect2.depthWidth; x+=skip) {
    for (int y = 0; y<kinect2.depthHeight; y+=skip) {
      int index = x + y*kinect2.depthWidth;
      //PVector point = depthToPointCloudPos(x, y, depth[index]);
      if (depth[index]<800 && depth[index]> 500) {
        color_img.pixels[index] = color(255,0,0);
        sumX += x;
        sumY += y;
        noPixels ++;
      }
      else{
         color_img.pixels[index] = color(0,0,0);
      }
    }
  }
  image(color_img, 0, 0);
    //stroke(255,0,0);

  //endShape();
    fill(20,145,200);
  ellipse(sumX/noPixels, sumY/noPixels,100,100);

  //popMatrix();
  //ellipse(sumX/noPixels, sumY/noPixels,100,100);
}

PVector depthToPointCloudPos(int x, int y, float depthValue) {
  PVector point = new PVector();
  point.z = (depthValue);// / (1.0f); // Convert from mm to meters
  point.x = (x - CameraParams.cx) * point.z / CameraParams.fx;
  point.y = (y - CameraParams.cy) * point.z / CameraParams.fy;
  return point;
}