package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import entities.Bullet;

class Player extends Entity
{
    public function new(x:Int, y:Int)
    {
      // create a new spritemap (image, frameWidth, frameHeight)
      sprite = new Spritemap("graphics/player.png", 16, 16);
      // define animations by passing frames in an array
      sprite.add("idle", [0]);
      // we set a speed to the walk animation
      sprite.add("walk", [1, 2, 3, 2], 12);
      // tell the sprite to play the idle animation
      sprite.play("idle");

      // apply the sprite to our graphic object so we can see the player
      graphic = sprite;

      // defines left and right as arrow keys and WASD controls
      Input.define("left", [Key.LEFT, Key.A]);
      Input.define("right", [Key.RIGHT, Key.D]);

      velocity = 0;
        // Here I set the hitbox width/height with the setHitbox function.
      setHitbox(50, 50);

      // Here I do the same thing by just assigning Player's properties.
      width = 50;
      height = 50;
      super(x,y);
    }

    public override function update()
    {
      handleInput();

      move();

      setAnimations();

      //checkCollisions();

      var e:Entity = collide("bullet", x, y);
      if (e != null)
      {
        var b:Bullet = cast(e, Bullet);
        b.destroy();
      }

      super.update();
    }

    private function handleInput()
    {
      acceleration = 0;

      if (Input.check("left"))
      {
        acceleration = -1;
      }

      if (Input.check("right"))
      {
        acceleration = 1;
      }
    }

    private function move()
    {
      velocity += acceleration;
      if (Math.abs(velocity) > 5)
      {
        velocity = 5 * HXP.sign(velocity);
      }

      if (velocity < 0)
      {
        velocity = Math.min(velocity + 0.4, 0);
      }
      else if (velocity > 0)
      {
        velocity = Math.max(velocity - 0.4, 0);
      }

      moveBy(velocity, 0);
    }

    private function checkCollisions()
    {
      var e:Entity = collide("bullet", x, y);
      if (e != null)
      {
        var b:Bullet = cast(e, Bullet);
        b.destroy();
      }
    }

    private function setAnimations()
    {
      if (velocity == 0)
      {
        // we are stopped, set animation to idle
        sprite.play("idle");
      }
      else
      {
        // we are moving, set animation to walk
        sprite.play("walk");

        // this will flip our sprite based on direction
        if (velocity < 0) // left
        {
          sprite.flipped = true;
        }
        else // right
        {
          sprite.flipped = false;
        }
      }
    }

    private var velocity:Float;
    private var sprite:Spritemap;
    private var acceleration:Float;
}
