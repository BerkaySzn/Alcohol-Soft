extends Button

@onready var bgSprite: Sprite2D = $bg
@onready var container: CenterContainer = $CenterContainer
@onready var inventory = preload("res://Inventory/chest_inventory.tres")

var itemStackGui: ItemStackGui
var index: int

func insert(isg: ItemStackGui):
	itemStackGui = isg
	if bgSprite.hframes * bgSprite.vframes > 1:
		bgSprite.frame = 1
	else:
		bgSprite.frame = 0
	container.add_child(itemStackGui)
	
	if !itemStackGui.inventorySlot or inventory.slots[index] == itemStackGui.inventorySlot:
		return
	
	inventory.insertSlot(index, itemStackGui.inventorySlot)

func takeItem() -> ItemStackGui:
	var item = itemStackGui
	container.remove_child(itemStackGui)
	itemStackGui = null
	bgSprite.frame = 0
	return item

func is_empty() -> bool:
	return itemStackGui == null
