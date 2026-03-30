extends Label


func _ready() -> void:
	_update_clock()
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 30.0
	timer.timeout.connect(_update_clock)
	timer.start()
	
func _update_clock():
	text = GlobalTime.get_real_time_string()
