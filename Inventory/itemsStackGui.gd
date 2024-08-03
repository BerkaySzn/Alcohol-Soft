extends Panel

class_name ItemStackGui

@onready var item_visual: Sprite2D =$item_display
@onready var amount_text: Label = $Label

var inventorySlot: InventorySlot

func update():
	if !inventorySlot || !inventorySlot.item: return
	
	item_visual.visible = true
	item_visual.texture = inventorySlot.item.texture
	if inventorySlot.amount>1:
		amount_text.visible = true
	amount_text.text = str(inventorySlot.amount)
