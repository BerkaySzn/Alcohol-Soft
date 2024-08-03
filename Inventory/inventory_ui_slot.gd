extends Button

@onready var bgSprite: Sprite2D =$bg
@onready var container: CenterContainer=$CenterContainer
@onready var inventory = preload("res://Inventory/player_inventory.tres")

var itemStackGui: ItemStackGui
var index: int
	
func insert(isg: ItemStackGui):
	itemStackGui=isg
	bgSprite.frame=1
	container.add_child(itemStackGui)
	
	if !itemStackGui.inventorySlot || inventory.slots[index] == itemStackGui.inventorySlot:
		return
	
	inventory.insertSlot(index, itemStackGui.inventorySlot)
	
func takeItem():
	var item=itemStackGui
	
	container.remove_child(itemStackGui)
	itemStackGui = null
	bgSprite.frame =0 
	
	return item
	

func isEmpty():
	return !itemStackGui
