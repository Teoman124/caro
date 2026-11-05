extends Node
# DialogueManager.gd

signal dialogue_started
signal dialogue_line_shown(speaker: String, text: String)
signal dialogue_finished

var _current_lines: Array = []
var _current_index: int = 0
var is_active: bool = false

func start_dialogue(lines: Array) -> void:
	# lines is een Array van Dictionaries: {"speaker": "...", "text": "..."}
	if lines.is_empty():
		return
	_current_lines = lines
	_current_index = 0
	is_active = true
	dialogue_started.emit()
	_show_current_line()

func advance() -> void:
	if not is_active:
		return
	_current_index += 1
	if _current_index >= _current_lines.size():
		_end_dialogue()
	else:
		_show_current_line()

func _show_current_line() -> void:
	var line = _current_lines[_current_index]
	dialogue_line_shown.emit(line.get("speaker", ""), line.get("text", ""))

func _end_dialogue() -> void:
	is_active = false
	_current_lines = []
	_current_index = 0
	dialogue_finished.emit()
