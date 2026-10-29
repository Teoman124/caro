extends Node
# DialogueManager.gd

signal dialogue_finished(event: String)

func show_dialogue(line: DialogueLine) -> void:
	# Voor nu: print naar output. Later vervang je dit door je UI.
	print("[%s]: %s" % [line.speaker_name, line.text])
	
	if line.event != "":
		dialogue_finished.emit(line.event)
