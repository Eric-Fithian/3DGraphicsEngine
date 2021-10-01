public class Vec3D
{
    public float x, y, z;

    public Vec3D(float x, float y, float z)
    {
        this.x = x;
        this.y = y;
        this.z = z;
    }
    public Vec3D(Vec3D p)
    {
      this.x = p.x;
      this.y = p.y;
      this.z = p.z;
    }
    public void Normalize()
    {
      float l = (float) Math.sqrt(this.x*this.x + this.y*this.y + this.z*this.z);
      this.x /= l;
      this.y /= l;
      this.z /= l;
    }
    public void MultiplyMatrixVector(Mat4x4 m)
  {
    float ox = x;
    float oy = y;
    float oz = z;
    ox = x * m.m[0][0] + y * m.m[1][0] + z * m.m[2][0] + m.m[3][0];
    oy = x * m.m[0][1] + y * m.m[1][1] + z * m.m[2][1] + m.m[3][1];
    oz = x * m.m[0][2] + y * m.m[1][2] + z * m.m[2][2] + m.m[3][2];
    float w = x * m.m[0][3] + y * m.m[1][3] + z * m.m[2][3] + m.m[3][3];
    //System.out.println("After Multiplication x: " + o.x + ", y:" + o.y + ", z:" + o.z);
    if (w != 0)
    {
        ox /= w;
        oy /= w;
        oz /= w;
    }
    x = ox;
    y = oy;
    z = oz;
  }
}
