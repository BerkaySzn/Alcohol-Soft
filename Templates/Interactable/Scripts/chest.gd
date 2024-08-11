extends StaticBody2D

signal toggle_inventory(external_inventory_owner)

@onready var interaction_area = $InteractionArea

@export var inventory_data: InventoryData

func _ready():
	interaction_area.interact = Callable(self,"open_chest")
	
func open_chest():
	toggle_inventory.emit(self)
	print(inventory_data.slot_datas[0].item_data.name)
	
