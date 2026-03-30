extends Control

@onready var option1 = $"aol window/MarginContainer/Rows/InputArea/MarginContainer/ChoiceContainer/Option1"
@onready var option2 = $"aol window/MarginContainer/Rows/InputArea/MarginContainer/ChoiceContainer/Option2"
@onready var choice_container = $"aol window/MarginContainer/Rows/InputArea/MarginContainer/ChoiceContainer"
@onready var refresh_timer = $"aol window/MarginContainer/Rows/InputArea/MarginContainer/ChoiceContainer/RefreshTimer"

const InputResponse = preload("res://scenes/input_response.tscn")

@onready var history_rows = $"aol window/MarginContainer/Rows/chatBox/Scroll/HistoryRows"
@onready var scroll = $"aol window/MarginContainer/Rows/chatBox/Scroll"
@onready var scroll_bar = scroll.get_v_scroll_bar()
@onready var current_node = "day1_start"
@onready var dahliachat = $cutiedahliachat

var max_scroll_length := 0 

func _ready() -> void:
	$"aol window".visible = false 
	await get_tree().create_timer(3.0).timeout
	SoundManager.buddyin_play()
	scroll_bar = scroll.get_v_scroll_bar()
	$"aol window".visible = true
	dahliachat.visible = true
	refresh_timer.timeout.connect(_on_refresh_timer_timeout)
	scroll_bar.changed.connect(self.handle_scrollbar_changed)
	
	# INITIAL STATE: Dahlia sends the very first message
	_dahlia_speaks("heyy!", current_node)

func _on_option_1_pressed():
	var data = Dialogue.dialogue_tree[current_node]
	
	if data.has("is_game_end"):
		get_tree().reload_current_scene()
	else:
		SoundManager.send_play()
		_process_player_input("opt1")

func _on_option_2_pressed():
	var data = Dialogue.dialogue_tree[current_node]
	
	if data.has("is_game_end"):
		get_tree().quit()
	else:
		SoundManager.send_play()
		_process_player_input("opt2")

func _process_player_input(opt_key: String):
	var data = Dialogue.dialogue_tree[current_node]
	var player_text = data[opt_key]

	if data.has("is_end_of_day"):
		var res = InputResponse.instantiate()
		history_rows.add_child(res)
		res.set_text(player_text, "")

		_handle_day_transition()
	else:
		var next_key = "next1" if opt_key == "opt1" else "next2"
		current_node = data[next_key]
		_dahlia_speaks(player_text, current_node)

func _dahlia_speaks(player_text: String, node_to_read: String):
	choice_container.visible = false
	var data = Dialogue.dialogue_tree[node_to_read]
	
	var res = InputResponse.instantiate()
	history_rows.add_child(res)
	res.set_text(player_text, data["dahlia_says"])
	
	if not data.has("is_game_end"):
		refresh_timer.start(3.0)

func _on_refresh_timer_timeout():
	_update_button_labels()
	choice_container.visible = true 

func _update_button_labels():
	var data = Dialogue.dialogue_tree[current_node]
	if data.has("is_game_end"):
		choice_container.visible = false
		await get_tree().create_timer(3.0).timeout
		option1.text = "Restart"
		option2.text = "Exit"
		choice_container.visible = true
		choice_container.queue_sort()
	else:
		option1.text = data["opt1"]
		option2.text = data["opt2"]
		choice_container.queue_sort()

func handle_scrollbar_changed():
	if max_scroll_length != scroll_bar.max_value:
		max_scroll_length = scroll_bar.max_value
		scroll.scroll_vertical = max_scroll_length 

func _handle_day_transition():
	choice_container.visible = false
	Dialogue.is_day_over = true
	$"aol window".visible = false
	SoundManager.buddyout_play()
	
	var data = Dialogue.dialogue_tree[current_node]
	var day_num = data["next_day"]
	var next_chat_node = data["next_node"]
	dahliachat.disabled = true 
	_launch_garden(day_num,next_chat_node)

func _launch_garden(day_num,next_node):
	var garden_path = "res://scenes/desktop_garden_" + str(day_num) + ".tscn"
	var garden = load(garden_path).instantiate()
	$GardenContainer.add_child(garden)
	
	await garden.plant_watered 
	
	garden.queue_free()
	_run_transition(day_num,next_node)

func _run_transition(day_num,next_node):
	var data = Dialogue.dialogue_tree[current_node]
	
	$Black_Screen.visible = true 
	$Black_Screen/Label.text = data["quote"]
	
	await get_tree().create_timer(5.0).timeout
	current_node = next_node
	_start_aol_day()

func _start_aol_day():
	if dahliachat.disabled:
		dahliachat.disabled = false 
	if has_node("Black_Screen"):
		$Black_Screen.visible = false 
	$"aol window".visible = true 
	SoundManager.buddyin_play()
	Dialogue.is_day_over = false 
	_dahlia_speaks("hi", current_node)
	
	var data = Dialogue.dialogue_tree[current_node]
	if data.has("is_game_end"):
		_update_button_labels()
		choice_container.visible = true
	
func _on_exit_pressed():
	$"aol window".visible = false
	dahliachat.visible = true

func _on_cutiedahliachat_pressed():
	if !$"aol window".visible:
		$"aol window".visible = true
		

	
