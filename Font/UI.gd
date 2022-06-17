extends Control

onready var health_bar = get_node("HealthBar")
onready var gold_text = get_node("GoldText")

func update_health_bar(current_hp):
	health_bar.value = current_hp

func update_gold_text (gold):
	gold_text.text = "Gold: " + str(gold)
	
