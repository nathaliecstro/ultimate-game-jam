extends Control

@onready var progressBar = $window/TextureProgressBar
@onready var waterButton = $window/water
@onready var inspopanel = $Inspo
@onready var window = $window
@onready var gardenbutton = $my_desktop_garden

signal plant_watered


func _on_water_pressed():
	progressBar.value += 10
	
	if progressBar.value >= 100:
		_show_inspo_quote()

func _show_inspo_quote():
	waterButton.disabled = true
	inspopanel.visible = true 
	SoundManager.victory_play()

func _on_exit_pressed():
	window.visible = false 
	gardenbutton.visible = true 

func _on_exit_inspo_pressed():
	inspopanel.visible = false 
	
	if progressBar.value >= 100:
		plant_watered.emit()

func _on_my_desktop_garden_pressed():
	if !window.visible:
		window.visible = true 
