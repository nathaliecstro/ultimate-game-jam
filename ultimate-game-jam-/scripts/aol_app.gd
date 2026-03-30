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

var max_scroll_length := 0 

func _ready() -> void:
	SoundManager.buddyin_play()
	scroll_bar = scroll.get_v_scroll_bar()
	refresh_timer.timeout.connect(_on_refresh_timer_timeout)
	scroll_bar.changed.connect(self.handle_scrollbar_changed)
	
	# INITIAL STATE: Dahlia sends the very first message
	_dahlia_speaks("heyy!", current_node)

func _on_option_1_pressed():
	SoundManager.send_play()
	_process_player_input("opt1")

func _on_option_2_pressed():
	SoundManager.send_play()
	_process_player_input("opt2")

func _process_player_input(opt_key: String):
	var data = Dialogue.dialogue_tree[current_node]
	var player_text = data[opt_key]

	if data.has("is_end_of_day"):
		var res = InputResponse.instantiate()
		history_rows.add_child(res)
		res.set_text(player_text, "")
		

		current_node = data["next_node"]
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
		await get_tree().create_timer(6.0).timeout
		$".".visible = false 
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

	await get_tree().create_timer(2.0).timeout
	
	self.visible = false
	Dialogue.is_day_over = true
	
	SoundManager.buddyout_play()
	print("AOL Hidden. This is where you will instantiate your mini-game.")
	
	
	
