extends Node
# npc.gd

@export var npc_name: String = "NPC"
@export var dialogue_lines: Array[DialogueLine] = []
@export var quest_to_give: Quest = null

var _current_line_index: int = 0
var _player: Node2D = null

func _ready():
	_player = get_tree().get_first_node_in_group("player")
	DialogueManager.dialogue_finished.connect(_on_dialogue_finished)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area == _player and Input.is_action_just_pressed("interact"):
		_start_dialogue()

func _start_dialogue():
	if dialogue_lines.is_empty():
		return
	_current_line_index = 0
	DialogueManager.show_dialogue(dialogue_lines[_current_line_index])

func _on_dialogue_finished(event: String):
	# Ga naar de volgende regel in de dialoog
	_current_line_index += 1
	if _current_line_index < dialogue_lines.size():
		DialogueManager.show_dialogue(dialogue_lines[_current_line_index])
	else:
		# Dialoog is klaar, check of er een quest-event was
		if event == "accept_quest" and quest_to_give != null:
			QuestManager.accept_quest(quest_to_give)
