extends Node2D

# Variabelen voor questbeheer
var quest_id = "quest_001" # ID van de quest
var current_quest_stage = 0 # Huidige fase van de quest

# Referentie naar de speler (verander dit naar je eigen speler-nodenaam)
var player: Node2D = null

# Referentie naar de dialoogbeheerder (verander dit naar je eigen dialoogscript)
var dialogue_manager: Node = null

func _ready():
	# Verkrijg de spelerreferentie (bijv. via een parent of een naam)
	player = get_tree().get_nodes_in_group("Players")[0]
	# Verkrijg de dialoogbeheerder (bijv. via een singleton of een parent)
	dialogue_manager = get_node("/Data/DialogueManager")

func _on_area_2d_area_entered(area: Area2D) -> void:
	# Controleer of het ingeslagen object de speler is
	if area == player:
		# Controleer of de interactie-toets wordt ingedrukt
		if Input.is_action_pressed("interact"):
			# Toon dialoog op basis van de huidige quest-fase
			show_dialogue_based_on_quest()

func show_dialogue_based_on_quest():
	match current_quest_stage:
		0:
			# Dialoog voor de eerste fase
			dialogue_manager.show_dialogue("Welkom, reiziger! Kun jij mijn stad helpen verdedigen?")
			current_quest_stage = 1 # Verhoog de fase na het tonen van de dialoog
		1:
			# Dialoog voor de tweede fase (bijv. na het voltooien van een taak)
			dialogue_manager.show_dialogue("Dankjewel! Je hebt mijn stad behoed. Wat is jouw naam?")
			current_quest_stage = 2
