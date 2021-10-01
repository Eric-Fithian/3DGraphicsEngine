public class Triangle3D implements Comparable<Triangle3D> {
    
    public Vec3D[] pts = new Vec3D[3];
    public float light;
    public float zavg;

    public Triangle3D(Vec3D p1, Vec3D p2, Vec3D p3)
    {
        pts[0] = p1;
        pts[1] = p2;
        pts[2] = p3;
        zavg = (float) (p1.z+p2.z+p3.z)/3f;
        light = 255;
    }
    public Triangle3D(Triangle3D tri)
    {
      this.pts[0] = new Vec3D(tri.pts[0]);
      this.pts[1] = new Vec3D(tri.pts[1]);
      this.pts[2] = new Vec3D(tri.pts[2]);
      this.zavg = tri.zavg;
      this.light = tri.light;
    }
    public void RecalcZavg()
    {
      zavg = (float) (pts[0].z+pts[1].z+pts[2].z)/3f;
    }
    @Override
    public int compareTo(Triangle3D other)
    {
      Float z1 = this.zavg;
      Float z2 = other.zavg;
      return z2.compareTo(z1);
    }
    public void TransformTriangle(Mat4x4 m)
    {
      pts[0].MultiplyMatrixVector(m);
      pts[1].MultiplyMatrixVector(m);
      pts[2].MultiplyMatrixVector(m);
    }
    public void ScaleToViewTriangle(float offset, float w, float h)
    {
      //Scale into view
      pts[0].x += offset;
      pts[0].y += offset;
      pts[1].x += offset;
      pts[1].y += offset;
      pts[2].x += offset;
      pts[2].y += offset;
      
      //display width, display height
      float scale = 0.5;
      pts[0].x *= scale * (float) w;
      pts[0].y *= scale * (float) h;
      pts[1].x *= scale * (float) w;
      pts[1].y *= scale * (float) h;
      pts[2].x *= scale * (float) w;
      pts[2].y *= scale * (float) h;
    }
    public void RotateTriangleX(float fTheta)
    {
      //X Rotation Matrix
      Mat4x4 m = new Mat4x4();
      m.m[0][0] = 1f;
      m.m[1][1] = (float) cos(fTheta);
      m.m[1][2] = (float) sin(fTheta);
      m.m[2][1] = (float) -sin(fTheta);
      m.m[2][2] = (float) cos(fTheta);
      m.m[3][3] = 1f;
      
      TransformTriangle(m);
    }
    public void RotateTriangleY(float fTheta)
    {
      //Y Rotation Matrix
      Mat4x4 m = new Mat4x4();
      m.m[0][0] = (float) cos(fTheta);
      m.m[1][1] = 1f;
      m.m[0][2] = (float) sin(fTheta);
      m.m[2][0] = (float) -sin(fTheta);
      m.m[2][2] = (float) cos(fTheta);
      m.m[3][3] = 1;
      
      TransformTriangle(m);
    }
    public void RotateTriangleZ(float fTheta)
    {
      //Z Rotation Matrix
      Mat4x4 m = new Mat4x4();
      m.m[0][0] = (float) cos(fTheta);
      m.m[0][1] = (float) sin(fTheta);
      m.m[1][0] = (float) -sin(fTheta);
      m.m[1][1] = (float) cos(fTheta);
      m.m[2][2] = 1f;
      m.m[3][3] = 1f;
      
      TransformTriangle(m);
    }
    public void ScaleTriangle(float scale)
    {
      Mat4x4 m = new Mat4x4();
      m.m[0][0] = scale;
      m.m[1][1] = scale;
      m.m[2][2] = scale;
      
      TransformTriangle(m);
    }
    public void TranslateTriangle(float x, float y, float z)
    {
      pts[0].x += x;
      pts[1].x += x;
      pts[2].x += x;
      pts[0].y += y;
      pts[1].y += y;
      pts[2].y += y;
      pts[0].z += z;
      pts[1].z += z;
      pts[2].z += z;
    }
    public void ProjectTriangle(float fNear, float fFar, float fFov, float displayW, float displayH)
    {
      float fAspectRatio = displayH/displayW;
      float fFovRad = 1f / (float) Math.tan(fFov * 0.5f / 180.0f * 3.14159f);
      //Projection Matrix
      Mat4x4 matProj = new Mat4x4();
      matProj.m[0][0] = fAspectRatio * fFovRad;
      matProj.m[1][1] = fFovRad;
      matProj.m[2][2] = fFar / (fFar - fNear);
      matProj.m[3][2] = (-fFar * fNear) / (fFar - fNear);
      matProj.m[2][3] = 1;
      matProj.m[3][3] = 0;
      
      TransformTriangle(matProj);
    }
}
