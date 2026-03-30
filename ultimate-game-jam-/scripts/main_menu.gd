extends MarginContainer

const game_scene = preload("res://scenes/aol_app.tscn")

@onready var selector_1 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/selector
@onready var selector_2 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/selector

var current_selection = 0 

func _ready():
	_set_current_selection(0)

func _process(delta):
	if (Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("down")) and current_selection < 1:
		current_selection += 1 
		_set_current_selection(current_selection)
	elif (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("up")) and current_selection > 0:
		current_selection -= 1 
		_set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		_handle_selection(current_selection)

func _handle_selection(current_selection):
	if current_selection == 0:
		get_parent().add_child(game_scene.instantiate())
		queue_free()
	elif current_selection == 1:
		get_tree().quit()

func _set_current_selection(current_selection):
	selector_1.text = ""
	selector_2.text = ""
	if current_selection == 0:
		selector_1.text = ">"
	elif current_selection == 1:
		selector_2.text = ">"
		
