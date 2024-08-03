extends Resource

class_name Inventory

signal update

@export var slots: Array[InventorySlot]


func insert(item: InventoryItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	var remaining_amount = 1  # Eklenmek istenen miktar

	for slot in itemslots:
		if slot.amount < 10:
			var space_in_slot = 10 - slot.amount
			var amount_to_add = min(remaining_amount, space_in_slot)
			slot.amount += amount_to_add
			remaining_amount -= amount_to_add
			if remaining_amount == 0:
				break

	if remaining_amount > 0:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		for slot in emptyslots:
			if remaining_amount > 0:
				var amount_to_add = min(remaining_amount, 10)
				slot.item = item
				slot.amount = amount_to_add
				remaining_amount -= amount_to_add
			else:
				break

	update.emit()
	
func removeItemAtIndex(index: int):
	slots[index] = InventorySlot.new()
	
func insertSlot(index: int, inventorySlot: InventorySlot):
	var oldIndex: int = slots.find(inventorySlot)
	removeItemAtIndex(oldIndex)
	
	slots[index] = inventorySlot
