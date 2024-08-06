extends Node

var player: Node2D
var interactable_objects: Array = []

# Etkileşim yapılacak nesneleri kaydet
func register_interactable(interactable: Node2D):
	interactable_objects.append(interactable)

# Etkileşim yapılacak nesneleri kaldır
func unregister_interactable(interactable: Node2D):
	interactable_objects.erase(interactable)

func _input(event):
	if event.is_action_pressed("ui_interact"):
		check_for_interaction()

func check_for_interaction():
	for interactable in interactable_objects:
		if player and player.global_position.distance_to(interactable.global_position) < 50: # Mesafe kontrolü
			#interactable.interact()
			print("manager")
