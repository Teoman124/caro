extends Node
# QuestManager.gd (Autoload)

signal quest_accepted(quest_id: String)
signal quest_completed(quest_id: String)

var active_quests: Dictionary = {} # quest_id -> true
var completed_quests: Array[String] = []

func accept_quest(quest_id: String) -> void:
	if quest_id in active_quests or quest_id in completed_quests:
		return # Quest bestaat al of is al klaar
	
	active_quests[quest_id] = true
	print("Quest geaccepteerd: ", quest_id)
	quest_accepted.emit(quest_id)

func complete_quest(quest_id: String) -> void:
	if quest_id in active_quests:
		active_quests.erase(quest_id)
		completed_quests.append(quest_id)
		print("Quest voltooid: ", quest_id)
		quest_completed.emit(quest_id)
