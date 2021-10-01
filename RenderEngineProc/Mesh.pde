import java.util.Vector;

public class Mesh
{
    public Vector<Triangle3D> tris;

    public Mesh(Triangle3D[] tris)
    {
         this.tris = new Vector<Triangle3D>();
         for (int i = 0; i < tris.length; i++)
         {
            Triangle3D tri = tris[i];
            this.tris.add(new Triangle3D(tri));
         }
    }
    public Mesh(ArrayList<Triangle3D> tris)
    {
         this.tris = new Vector<Triangle3D>();
         for (int i = 0; i < tris.size(); i++)
         {
            Triangle3D tri = tris.get(i);
            this.tris.add(new Triangle3D(tri));
         }
    }
}
