# chest.gd
extends Area2D

@export var chest_inventory: Inventory
@onready var chest_inventory_ui = $chest_inventory_ui  # UI node should be defined here

var is_open: bool = false
var player_inventory: Inventory  # Reference to player's inventory

func _ready():
	connect("body_entered", Callable(self, "_on_area_2d_body_entered"))
	connect("body_exited", Callable(self, "_on_area_2d_body_exited"))
	chest_inventory_ui.connect("item_dropped", Callable(self, "_on_chest_inventory_ui_item_dropped"))

func _on_area_2d_body_entered(_body):
	# Logic to open chest and show UI
	is_open = true
	chest_inventory_ui.show()

func _on_area_2d_body_exited(_body):
	# Logic to close chest and hide UI
	is_open = false
	chest_inventory_ui.hide()

func _on_chest_inventory_ui_item_dropped(item, amount):
# Logic to handle item dropped from player inventory to chest
	if player_inventory.remove_item(item, amount):
		chest_inventory.add_item(item, amount)
		update_ui()


func update_ui():
	# Update both player and chest inventory UIs
	player_inventory.update_ui()
	chest_inventory_ui.update_ui()



