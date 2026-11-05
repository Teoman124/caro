extends npc_script

var times_talked: int = 0

func _start_dialogue():
	times_talked += 1
	
	var current_text := ""
	
	match times_talked:
		1:
			current_text = "Oh, hallo lieverd! Wat fijn dat je er bent. Kun je mij een plezier doen?"
			# Geef de quest direct na het eerste gesprek
			QuestManager.accept_quest("quest_001")
		2:
			current_text = "Ben je al bij de visser geweest? Hij heeft vast wel een taak voor je."
		_:
			current_text = "Blijf vooral even gezellig hangen, hoor."
	
	var lines := [
		{"speaker": npc_name, "text": current_text}
	]
	DialogueManager.start_dialogue(lines)
