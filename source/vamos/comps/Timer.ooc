import vamos/[Component, Entity]

Timer: class extends Component {
	
	callback: Func
	interval:Double = 10.0
	running := false
	_counter:Double = 0.0
	_looping := false
	
	init: func (=interval, =callback) {
		name = "timer"
	}
	init: func~start(=interval, =callback) {
		name = "timer"
		start()
	}
	
	update: func (dt: Double) {
		if (running) {
			_counter += dt
			if (_counter > interval) {
				callback()
				if (_looping) {
					_counter -= interval
				} else {
					running = false
				}
			}
		}
	}
	
	start: func {
		running = true
		_looping = false
	}
	
	start: func ~withInterval (interval: Double) {
		this interval = interval
		start()
	}
	
	loop: func {
		running = true
		_looping = true
	}
	
	loop: func ~withInterval (interval: Double) {
		this interval = interval
		loop()
	}
	
	pause: func {
		running = false
	}
	
	resume: func {
		running = true
	}
	
	stop: func {
		running = false
		_counter = 0
		_looping = false
	}
}