package scenes;

import com.haxepunk.Scene;
import entities.Player;
import entities.Bullet;


class GameScene extends Scene
{

    public function new()
    {
        super();
    }

    public override function begin()
    {
        add(new Player(30, 50));
        add(new Bullet(500, 50));
    }

}
