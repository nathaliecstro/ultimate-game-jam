extends Control 

@onready var progressBar = $window/TextureProgressBar
@onready var waterButton = $window/water
@onready var inspopanel = $Inspo
@onready var window = $window
@onready var gardenButton = $my_desktop_garden

signal plant_watered

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
	if !gardenButton.visible: 
		gardenButton.visible = true 

func _on_exit_inspo_pressed():
	inspopanel.visible = false 
	
	if progressBar.value >= 100:
		plant_watered.emit()

func _on_my_desktop_garden_pressed():
	if !window.visible:
		window.visible = true 
