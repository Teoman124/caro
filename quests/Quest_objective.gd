# quest_objective.gd
class_name QuestObjective
extends Resource

@export var objective_id: String = ""
@export var description: String = ""
@export var required_amount: int = 1
@export var current_amount: int = 0

func is_complete() -> bool:
	return current_amount >= required_amount
