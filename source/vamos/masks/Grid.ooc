import vamos/[Entity, Mask]
import vamos/masks/Hitbox

Grid: class extends Mask {
	
	data: UInt*
	width, height: UInt // size in pixels
	w, h: UInt  // size in tiles
	tileW, tileH: UInt
	
	init: func (=w, =h, =tileW, =tileH) {
		width = w * tileW
		height = h * tileH
	}
	
	get: inline func(x, y:UInt) -> UInt {
		(x < w && y < h) ? data[x + y*w] : 0
	}
	set: inline func(x, y, val:UInt) {
		if (x < w && y < h)
			data[x + y*w] = val
	}
	
	check: func (other:Mask) -> Bool {
		return match (other class) {
			case Hitbox => checkHitbox(other as Hitbox)
			case => false
		}
	}
	
	checkHitbox: func (box:Hitbox) -> Bool {
		if (!data) return false
		left:Int = box entity x + box x - entity x
		top:Int = box entity y + box y - entity y
		right:Int = (left + box width - 1) / tileW
		bottom:Int = (top + box height - 1) / tileH
		left /= tileW
		top /= tileH
		
		for (x in left..right+1)
			for (y in top..bottom+1)
				if (get(x, y)) return true
		false
	}
	
}