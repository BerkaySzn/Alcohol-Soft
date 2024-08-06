extends Node2D

func _ready():
	InteractManager.register_interactable(self)

func _exit_tree():
	InteractManager.unregister_interactable(self)

# Bu func etkileşime girildiğinde çağrılıyor
func interact():
	print("Interactable.gd Interacted with ", self.name)
