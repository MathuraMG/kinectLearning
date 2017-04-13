
import java.nio.*;
import org.openkinect.processing.*;

// Kinect Library object
Kinect2 kinect2;

// Angle for rotation
float a = 3.1;

//change render mode between openGL and CPU
int renderMode = 1;

//openGL object and shader
PGL     pgl;
PShader sh;

//VBO buffer location in the GPU
int vertexVboId;



void setup() {

  // Rendering in P3D
  size(1600, 1200, P3D);

  kinect2 = new Kinect2(this);
  kinect2.initDepth();  
  kinect2.initRegistered();
  kinect2.initDevice();
}


void draw() {
  background(0);
  PImage color_img = kinect2.getRegisteredImage();
  //image(color_img, 0, 0);
  pushMatrix();
  translate(width/4, height/2, -1000);
  //rotateY(a);
  int[] depth = kinect2.getRawDepth();
  int skip = 2;
  strokeWeight(2);
  //background(0);


  beginShape(POINTS);
  println(kinect2.depthWidth, kinect2.depthHeight);
  for (int x = 0; x < kinect2.depthWidth; x+=skip) {
    for (int y = 0; y < kinect2.depthHeight; y+=skip) {
      int offset = x + y * kinect2.depthWidth;

      //calculte the x, y, z camera position based on the depth information
      PVector point = depthToPointCloudPos(x, y, depth[offset]);
      if (depth[offset]<1000) {
        stroke(255);
        vertex(point.x, point.y, point.z);
        stroke(red(color_img.pixels[offset]), green(color_img.pixels[offset]), blue(color_img.pixels[offset]));
        vertex(point.x, point.y - 100- kinect2.depthHeight, point.z);
        stroke(brightness(color_img.pixels[offset]));
        vertex(point.x + kinect2.depthWidth +200, point.y - 100- kinect2.depthHeight, point.z);
        stroke(255 - red(color_img.pixels[offset]), 255 - green(color_img.pixels[offset]), 255 - blue(color_img.pixels[offset]));
        vertex(point.x + kinect2.depthWidth +200, point.y, point.z);
      }
    }
  }
  endShape();
  a+=0.0015;
  popMatrix();
}



//calculte the xyz camera position based on the depth data
PVector depthToPointCloudPos(int x, int y, float depthValue) {
  PVector point = new PVector();
  point.z = (depthValue);// / (1.0f); // Convert from mm to meters
  point.x = (x - CameraParams.cx) * point.z / CameraParams.fx;
  point.y = (y - CameraParams.cy) * point.z / CameraParams.fy;
  return point;
}