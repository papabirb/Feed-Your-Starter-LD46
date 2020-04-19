extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var splash = $Story

# Called when the node enters the scene tree for the first time.
func _ready():
	self.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	var _game = get_tree().change_scene("res://Main.tscn")


func _on_Story_finished():
	self.disabled = false
	self.visible = true
