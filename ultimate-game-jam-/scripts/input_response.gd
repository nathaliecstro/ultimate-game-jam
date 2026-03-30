extends VBoxContainer

@onready var delay_timer = $Delay_Timer

var my_blue = "#0000fe"
var my_red = "#fd0000"

func set_text(input: String, response: String):
	
	if not is_node_ready(): await ready
	
	$InputHistory.text = "[color=" + my_blue + "]" + "xXsugarDestroyerPRXx: " + " [/color]" + input
	$Response.text = "[color=" + my_red + "]" + "cutiedahlia78: " + " [/color]" + response
	$Response.visible_ratio = 0.0
	
	delay_timer.start(3)
	await delay_timer.timeout
	$Response.visible_ratio = 1
	SoundManager.rcv_play()
	
	
