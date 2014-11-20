package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class Bullet extends Entity
{
  public function new(x:Int, y:Int)
  {
    super(x, y);
    graphic = new Image("graphics/bullet.png");
    setHitbox(10, 10);
    type = "bullet";
  }

  public override function update()
  {
    super.update();
  }

  public function destroy()
  {
    // Here we could place specific destroy-behavior for the Bullet.
    scene.remove(this);
  }
}
