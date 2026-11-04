# dialogue_box.gd
extends CanvasLayer

@onready var speaker_label: Label = $Panel/VBoxContainer/SpeakerLabel
@onready var text_label: Label = $Panel/VBoxContainer/TextLabel

func _ready():
	hide()
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_line_shown.connect(_on_line_shown)
	DialogueManager.dialogue_finished.connect(_on_dialogue_finished)

func _on_dialogue_started():
	show()

func _on_line_shown(speaker: String, text: String):
	speaker_label.text = speaker
	text_label.text = text

func _on_dialogue_finished():
	hide()

func _unhandled_input(event: InputEvent):
	if not visible:
		return
	if event.is_action_pressed("interact"):
		DialogueManager.advance()
		get_viewport().set_input_as_handled()
