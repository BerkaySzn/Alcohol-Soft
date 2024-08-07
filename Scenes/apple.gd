extends Node2D

@onready var interaction_area = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self,"apple_interact")
	
func apple_interact():
	print(self.name)
