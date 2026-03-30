extends Node


func get_real_time_string() -> String:
	var datetime = Time.get_time_dict_from_system()
	var hour = datetime["hour"]
	var minute = datetime["minute"]
	
	var am_pm = "AM"
	if hour >= 12:
		am_pm = "PM"
	if hour > 12:
		hour -= 12
	if hour == 0:
		hour = 12
	
	return "%02d:%02d%s" % [hour,minute,am_pm]
