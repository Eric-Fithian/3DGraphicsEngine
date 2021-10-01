import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.Collections;

//3D Cube points
Vec3D p1 = new Vec3D(0f, 0f, 0f);
Vec3D p2 = new Vec3D(0f, 1f, 0f);
Vec3D p3 = new Vec3D(1f, 1f, 0f);
Vec3D p4 = new Vec3D(1f, 0f, 0f);
Vec3D p5 = new Vec3D(0f, 0f, 1f);
Vec3D p6 = new Vec3D(0f, 1f, 1f);
Vec3D p7 = new Vec3D(1f, 1f, 1f);
Vec3D p8 = new Vec3D(1f, 0f, 1f);

//South
Triangle3D t1 = new Triangle3D(p1,p2,p3);
Triangle3D t2 = new Triangle3D(p1,p3,p4);

//East
Triangle3D t3 = new Triangle3D(p4,p3,p7);
Triangle3D t4 = new Triangle3D(p4,p7,p8);

//North
Triangle3D t5 = new Triangle3D(p8,p7,p6);
Triangle3D t6 = new Triangle3D(p8,p6,p5);

//West
Triangle3D t7 = new Triangle3D(p5,p6,p2);
Triangle3D t8 = new Triangle3D(p5,p2,p1);
 //<>//
//Top
Triangle3D t9 = new Triangle3D(p2,p6,p7);
Triangle3D t10 = new Triangle3D(p2,p7,p3);

//Bottom
Triangle3D t11 = new Triangle3D(p1,p4,p8);
Triangle3D t12 = new Triangle3D(p1,p8,p5);

//Triangle3D[] tris = {new Triangle3D(t1),new Triangle3D(t2),new Triangle3D(t3),new Triangle3D(t4),new Triangle3D(t5),new Triangle3D(t6),new Triangle3D(t7),new Triangle3D(t8),new Triangle3D(t9),new Triangle3D(t10),new Triangle3D(t11),new Triangle3D(t12)};
Triangle3D[] tris = {t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12};

Mesh meshCube = new Mesh(tris);
Mesh mesh;

//Projection Matrix
float fNear = 0.1;
float fFar = 1000.0;
float fFov = 40.0;
//float fAspectRatio = 1440f/2560f;
float fFovRad = 1f / (float) Math.tan(fFov * 0.5f / 180.0f * 3.14159f);

Mat4x4 matProj = new Mat4x4();

float fTheta = 0f;

//File Names
String humanoid = "humanoid_tri.obj.txt";
String outrage = "OUTRAGE_LOGO.obj";
String sofLiberty = "LibertStatue.obj";
String polyBeach = "polybeach.obj";
String amg = "AMG.obj";

Vec3D vCamera = new Vec3D(0,0,0);

void setup() //<>//
{
    fullScreen();
    background(0, 0, 0);

    //Projection Matrix
    matProj.m[0][0] = displayHeight/ (float) displayWidth * fFovRad;
    matProj.m[1][1] = fFovRad;
    matProj.m[2][2] = fFar / (fFar - fNear);
    matProj.m[3][2] = (-fFar * fNear) / (fFar - fNear);
    matProj.m[2][3] = 1;
    matProj.m[3][3] = 0;
    //mesh = ReadFile(amg);
    //mesh = ReadFile(sofLiberty);
    //mesh = ReadFile(humanoid);
    //mesh = ReadFile(outrage);
    //mesh = ReadFile(polyBeach);
}

void draw()
{
  clear();
  fTheta = (float) millis()/1300;
  //fTheta += 0.01;
  //outrage
  //DrawMesh(mesh, 4, fTheta, fTheta, fTheta, 0, 0, 4);
  //Statue of Liberty
  //DrawMesh(mesh, 1.7, 3.14159, fTheta, 0, 0, 1, 5);
  //Humanoid
  //DrawMesh(mesh, 0.5, fTheta, fTheta, fTheta, 0, 0, 30);
  //PolyBeach
  //DrawMesh(mesh, 0.1, 3.14159+0.4,fTheta,0, 0,1.5,8);
  //Cube
  DrawMesh(meshCube, 1, fTheta/2, fTheta*2, fTheta, 0, 0, 5);
  //AMG Car
  //DrawMesh(mesh, 1.7, 3.14159, fTheta, 0, 0, 1, 15);
}



void DrawTriangle(Triangle3D tri)
{
  //stroke(255);
  //line(tri.pts[0].x, tri.pts[0].y, tri.pts[1].x, tri.pts[1].y);
  //line(tri.pts[1].x, tri.pts[1].y, tri.pts[2].x, tri.pts[2].y);
  //line(tri.pts[2].x, tri.pts[2].y, tri.pts[0].x, tri.pts[0].y);
  fill(tri.light);
  stroke(tri.light);
  triangle(tri.pts[0].x, tri.pts[0].y, tri.pts[1].x, tri.pts[1].y, tri.pts[2].x, tri.pts[2].y);
}

void DrawMesh(Mesh mesh, float scale, float xrot, float yrot, float zrot, float x, float y, float z)
{
  ArrayList<Triangle3D> triList = new ArrayList<Triangle3D>();
  for (int i = 0; i < mesh.tris.size(); i++)
    {
        Triangle3D tri = new Triangle3D(mesh.tris.get(i));
        
        //Scale Triangle
        tri.ScaleTriangle(scale);
        
        //Rotate Triangle
        tri.RotateTriangleX(xrot);
        tri.RotateTriangleY(yrot);
        tri.RotateTriangleZ(zrot);
        
        //Translate x,y,z
        tri.TranslateTriangle(x, y, z);
        
        
        
        //Normal Calculations
        Vec3D normal = new Vec3D(0,0,0);
        Vec3D line1 = new Vec3D(0,0,0);
        Vec3D line2 = new Vec3D(0,0,0);
        
        line1.x = tri.pts[1].x - tri.pts[0].x;
        line1.y = tri.pts[1].y - tri.pts[0].y;
        line1.z = tri.pts[1].z - tri.pts[0].z;
        
        line2.x = tri.pts[2].x - tri.pts[0].x;
        line2.y = tri.pts[2].y - tri.pts[0].y;
        line2.z = tri.pts[2].z - tri.pts[0].z;
        
        normal.x = line1.y * line2.z - line1.z * line2.y;
        normal.y = line1.z * line2.x - line1.x * line2.z;
        normal.z = line1.x * line2.y - line1.y * line2.x;
        
        normal.Normalize();

        if (
        normal.x * (tri.pts[0].x - vCamera.x) + 
        normal.y * (tri.pts[0].y - vCamera.y) + 
        normal.z * (tri.pts[0].z - vCamera.z) < 0f)
        {
          tri.RecalcZavg();
          
          //Illumination
          Vec3D light_direction = new Vec3D(0,0,-1);
          light_direction.Normalize();
          
          float dp = normal.x * light_direction.x + normal.y * light_direction.y + normal.z * light_direction.z;
          
          //Project Verticies
          tri.TransformTriangle(matProj);
          //tri.ProjectTriangle(fNear, fFar, fFov, displayWidth, displayHeight);
        
          //Scale into view
          tri.ScaleToViewTriangle(1f, displayWidth, displayHeight);
          
          tri.light = dp*255f;
          
          
          
          triList.add(tri);
        }
    }
    Collections.sort(triList);
    for (Triangle3D tri : triList)
    {
      //PrintTriangle(tri);
      DrawTriangle(tri);
      System.out.println("zavg: " + tri.zavg);
    }
    
}

//Triangle3D TranslateTriangle(Triangle3D t, float x, float y, float z)
//{
//  Triangle3D tri = new Triangle3D(t);
//  tri.pts[0].x += x;
//  tri.pts[1].x += x;
//  tri.pts[2].x += x;
//  tri.pts[0].y += y;
//  tri.pts[1].y += y;
//  tri.pts[2].y += y;
//  tri.pts[0].z += z;
//  tri.pts[1].z += z;
//  tri.pts[2].z += z;
//  return tri;
//}
  
//Triangle3D ScaleTriangle(Triangle3D t, float scale)
//{
//  Mat4x4 m = new Mat4x4();
//  m.m[0][0] = scale;
//  m.m[1][1] = scale;
//  m.m[2][2] = scale;
  
//  Triangle3D tri = TransformTriangle(t, m);
//  return tri;
//}

//Triangle3D RotateTriangleX(Triangle3D t, float fTheta)
//{
//  //X Rotation Matrix
//  Mat4x4 m = new Mat4x4();
//  m.m[0][0] = 1f;
//  m.m[1][1] = (float) cos(fTheta);
//  m.m[1][2] = (float) sin(fTheta);
//  m.m[2][1] = (float) -sin(fTheta);
//  m.m[2][2] = (float) cos(fTheta);
//  m.m[3][3] = 1f;
  
//  Triangle3D tri = TransformTriangle(t, m);
//  return tri;
//}

//Triangle3D RotateTriangleY(Triangle3D t, float fTheta)
//{
//  //Y Rotation Matrix
//  Mat4x4 m = new Mat4x4();
//  m.m[0][0] = (float) cos(fTheta);
//  m.m[1][1] = 1f;
//  m.m[0][2] = (float) sin(fTheta);
//  m.m[2][0] = (float) -sin(fTheta);
//  m.m[2][2] = (float) cos(fTheta);
//  m.m[3][3] = 1;
  
//  Triangle3D tri = TransformTriangle(t, m);
//  return tri;
//}

//Triangle3D RotateTriangleZ(Triangle3D t, float fTheta)
//{
//  //Z Rotation Matrix
//  Mat4x4 m = new Mat4x4();
//  m.m[0][0] = (float) cos(fTheta);
//  m.m[0][1] = (float) sin(fTheta);
//  m.m[1][0] = (float) -sin(fTheta);
//  m.m[1][1] = (float) cos(fTheta);
//  m.m[2][2] = 1f;
//  m.m[3][3] = 1f;
  
//  Triangle3D tri = TransformTriangle(t, m);
//  return tri;
//}
  
//Triangle3D ScaleToViewTriangle(Triangle3D tri)
//{
//        //Scale into view
//        tri.pts[0].x += 1.0f;
//        tri.pts[0].y += 1.0f;
//        tri.pts[1].x += 1.0f;
//        tri.pts[1].y += 1.0f;
//        tri.pts[2].x += 1.0f;
//        tri.pts[2].y += 1.0f;
        
//        float scale = 0.5;
//        tri.pts[0].x *= scale * (float) displayWidth;
//        tri.pts[0].y *= scale * (float) displayHeight;
//        tri.pts[1].x *= scale * (float) displayWidth;
//        tri.pts[1].y *= scale * (float) displayHeight;
//        tri.pts[2].x *= scale * (float) displayWidth;
//        tri.pts[2].y *= scale * (float) displayHeight;
        
//        return tri;
//}

//Triangle3D TransformTriangle(Triangle3D tri, Mat4x4 m)
//{
//  Vec3D p1 = MultiplyMatrixVector(tri.pts[0], m);
//  Vec3D p2 = MultiplyMatrixVector(tri.pts[1], m);
//  Vec3D p3 = MultiplyMatrixVector(tri.pts[2], m);
//  Triangle3D o = new Triangle3D(p1,p2,p3);
//  return o;
//}

//Vec3D MultiplyMatrixVector(Vec3D i, Mat4x4 m)
//{
//  Vec3D o = new Vec3D(0,0,0);
//  o.x = i.x * m.m[0][0] + i.y * m.m[1][0] + i.z * m.m[2][0] + m.m[3][0];
//  o.y = i.x * m.m[0][1] + i.y * m.m[1][1] + i.z * m.m[2][1] + m.m[3][1];
//  o.z = i.x * m.m[0][2] + i.y * m.m[1][2] + i.z * m.m[2][2] + m.m[3][2];
//  float w = i.x * m.m[0][3] + i.y * m.m[1][3] + i.z * m.m[2][3] + m.m[3][3];
//  //System.out.println("After Multiplication x: " + o.x + ", y:" + o.y + ", z:" + o.z);
//  if (w != 0)
//  {
//      o.x /= w;
//      o.y /= w;
//      o.z /= w;
//  }
  
//  return o;
//}

Mesh ReadFile(String file)
{
  ArrayList<Vec3D> pts = new ArrayList<>();
  ArrayList<Triangle3D> tris = new ArrayList<Triangle3D>();
  
  String[] lines = loadStrings(file);
  for (int i = 0; i < lines.length-1; i++)
  {
    if (!lines[i].equals(""))
    {
      System.out.println(lines[i]);
      String str = lines[i];
      String[] split = str.split("\\s+");
      if (split.length > 0 && split[0].equals("v"))
      {
        float x = Float.parseFloat(split[1]);
        float y = Float.parseFloat(split[2]);
        float z = Float.parseFloat(split[3]);
        
        pts.add(new Vec3D(x,y,z));
      }
      if (split.length > 0 && split[0].equals("f"))
      {
        if (split.length == 4)
        {
          if (split[1].contains("/"))
          {
            System.out.println("Before Split: " + split[1]);
            split[1] = split[1].substring(0, split[1].indexOf("/"));
            split[2] = split[2].substring(0, split[2].indexOf("/"));
            split[3] = split[3].substring(0, split[3].indexOf("/"));
            System.out.println("After Split: " + split[1]);
          }
          int i1 = Integer.valueOf(split[1])-1;
          int i2 = Integer.valueOf(split[2])-1; 
          int i3 = Integer.valueOf(split[3])-1; 
          
          tris.add(new Triangle3D(pts.get(i1), pts.get(i2), pts.get(i3)));
          PrintTriangle(new Triangle3D(pts.get(i1), pts.get(i2), pts.get(i3)));
        }
        if (split.length == 5)
        {
          if (split[1].contains("/"))
          {
            split[1] = split[1].substring(0, split[1].indexOf("/"));
            split[2] = split[2].substring(0, split[2].indexOf("/"));
            split[3] = split[3].substring(0, split[3].indexOf("/"));
            split[4] = split[4].substring(0, split[4].indexOf("/"));
          }
          int i1 = Integer.valueOf(split[1])-1;
          int i2 = Integer.valueOf(split[2])-1; 
          int i3 = Integer.valueOf(split[3])-1;
          int i4 = Integer.valueOf(split[4])-1;
          
          tris.add(new Triangle3D(pts.get(i1), pts.get(i2), pts.get(i3)));
          PrintTriangle(new Triangle3D(pts.get(i1), pts.get(i2), pts.get(i3)));
          tris.add(new Triangle3D(pts.get(i1), pts.get(i3), pts.get(i4)));
          PrintTriangle(new Triangle3D(pts.get(i1), pts.get(i3), pts.get(i4)));
        }
      }
    }
  }
  return new Mesh(tris);
}

void PrintTriangle(Triangle3D tri)
{
  System.out.println("Triangle: " + 
        tri.pts[0].x + "," + tri.pts[0].y + "," + tri.pts[0].z + "\t\t" + 
        tri.pts[1].x + "," + tri.pts[1].y + "," + tri.pts[1].z + "\t\t" + 
        tri.pts[2].x + "," + tri.pts[2].y + "," + tri.pts[2].z);
}

void PrintMatrix(float[][] m)
{
  for (int r = 0; r < m.length; r++)
  {
    String row = "";
    for (int c = 0; c < m[0].length; c++)
    {
      row += m[r][c] + "\t";
    }
    System.out.println(row);
  }
}
