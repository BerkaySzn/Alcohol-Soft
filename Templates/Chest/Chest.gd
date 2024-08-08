extends Node2D

@onready var interaction_area = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self,"open_chest")
	
func open_chest():
	print(self.name ," opened")
