# npc.gd
extends Node2D
class_name npc_script

@export var npc_name: String = "NPC"
@export_multiline var dialogue_text: String = "Hallo reiziger!"

@onready var area: Area2D = $Area2D

var _player_in_range: bool = false

func _ready():
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		_player_in_range = true

func _on_body_exited(body: Node2D):
	if body.is_in_group("player"):
		_player_in_range = false

func _unhandled_input(event: InputEvent):
	if not _player_in_range:
		return
	if DialogueManager.is_active:
		return
	if event.is_action_pressed("interact"):
		_start_dialogue()
		get_viewport().set_input_as_handled()

func _start_dialogue():
	var lines := [
		{"speaker": npc_name, "text": dialogue_text}
	]
	DialogueManager.start_dialogue(lines)
