#BERKE START
extends Node2D

func _ready():
	InteractManager.register_interactable(self)

func _exit_tree():
	InteractManager.unregister_interactable(self)

# Bu func etkileşime girildiğinde çağrılıyor
func interact():
	print("Player interacted with ", get_parent().name)
#BERKE END
