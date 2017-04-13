import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

Kinect2 kinect2;

void setup() {
  size(512,424, P3D);
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
}

void draw() {
  background(0);
  PImage img = kinect2.getDepthImage();
  //image(img,0,0);
  int skip = 5;
  for(int x = 0; x<img.width;x+=skip)
  {
    for(int y = 0; y<img.height;y+=skip)
    {
      int index = x+ y*img.width;
      float p_color = brightness(img.pixels[index]);
      fill(p_color);
      pushMatrix();
      translate(x,y,map(p_color,0,255,250,-250));
      rect(0,0,skip,skip);
      popMatrix();
    }
  }
}