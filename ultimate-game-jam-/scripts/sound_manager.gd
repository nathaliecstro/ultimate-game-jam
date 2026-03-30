extends Node

var send_player = AudioStreamPlayer.new()
var buddy_in_player = AudioStreamPlayer.new()
var buddy_out_player = AudioStreamPlayer.new()
var rcv_player = AudioStreamPlayer.new()
var victory_player = AudioStreamPlayer.new()

func _ready():
	add_child(send_player)
	add_child(buddy_in_player)
	add_child(buddy_out_player)
	add_child(rcv_player)
	add_child(victory_player)
	
	send_player.stream = load("res://assets/sounds/aimsend.wav")
	buddy_in_player.stream = load("res://assets/sounds/buddyin.wav")
	buddy_out_player.stream = load("res://assets/sounds/buddyout (1).wav")
	rcv_player.stream = load("res://assets/sounds/aimrcv.wav")
	victory_player.stream = load("res://assets/sounds/fairy sound.wav")

func send_play():
	if send_player.stream:
		send_player.play()

func buddyin_play():
	if buddy_in_player.stream:
		buddy_in_player.play()

func buddyout_play():
	if buddy_out_player.stream:
		buddy_out_player.play()
	
func rcv_play():
	if rcv_player.stream and !Dialogue.is_day_over:
		rcv_player.play()

func victory_play():
	if victory_player.stream:
		victory_player.play()
