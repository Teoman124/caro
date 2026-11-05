# quest.gd
class_name Quest
extends Resource

@export var quest_id: String = ""
@export var title: String = ""
@export var description: String = ""
@export var objectives: Array[QuestObjective] = []

func is_complete() -> bool:
	for objective in objectives:
		if not objective.is_complete():
			return false
	return true
