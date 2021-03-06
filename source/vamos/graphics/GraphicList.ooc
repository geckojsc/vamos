import structs/ArrayList
import vamos/[Graphic, Entity]
import vamos/display/Screen

GraphicList: class extends Graphic {

	graphics: ArrayList<Graphic>
	
	init: func (=graphics)
	
	init: func ~arr (arr:Graphic[]) {
		init(arr as ArrayList<Graphic>)
	}
	
	init: func ~empty {
		init(ArrayList<Graphic> new())
	}
	
	
	update: func (dt: Float) {
		for (graphic in graphics) graphic update(dt)
	}
	
	draw: func (screen:Screen, entity: Entity, x, y: Float) {
		for (graphic in graphics) graphic draw(screen, entity, x+graphic x, y+graphic y)
	}
	
	add: func (graphic: Graphic) {
		graphics add(graphic)
		if (!active) active = graphic active
		if (!visible) visible = graphic visible
	}
	
	remove: func (graphic: Graphic) {
		graphics remove(graphic)
		updateVisible()
		updateActive()
	}
	
	removeAt: func (index: Int) {
		if (index >= graphics size) return
		graphics removeAt(index)
		updateVisible()
		updateActive()
	}
	
	removeAll: func {
		graphics clear()
		visible = false
		active = false
	}
	
	/** private */
	updateVisible: func {
		visible = false
		for (graphic in graphics) {
			if (graphic visible) {
				visible = true
				return
			}
		}
	}
	
	/** private */
	updateActive: func {
		active = false
		for (graphic in graphics) {
			if (graphic active) {
				active = true
				return
			}
		}
	}
}