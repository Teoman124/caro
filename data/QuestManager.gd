extends Node
# QuestManager.gd (Autoload)

signal quest_accepted(quest_id: String)
signal objective_updated(quest_id: String, objective_id: String, progress: int)
signal quest_completed(quest_id: String)

var active_quests: Dictionary = {} # quest_id -> QuestResource
var completed_quests: Array[String] = []

func accept_quest(quest: Quest) -> void:
	if quest.quest_id in completed_quests or quest.quest_id in active_quests:
		return
	active_quests[quest.quest_id] = quest
	quest_accepted.emit(quest.quest_id)

func update_objective(quest_id: String, objective_id: String, amount: int = 1) -> void:
	if quest_id not in active_quests:
		return
	var quest = active_quests[quest_id]
	# ... update logica ...
	objective_updated.emit(quest_id, objective_id, amount)
	if quest.is_complete():
		_complete_quest(quest_id)

func _complete_quest(quest_id: String) -> void:
	completed_quests.append(quest_id)
	active_quests.erase(quest_id)
	quest_completed.emit(quest_id)
