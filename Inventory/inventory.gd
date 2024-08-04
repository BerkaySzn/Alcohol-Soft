extends Resource

class_name Inventory

signal update

@export var slots: Array[InventorySlot]

func _ready():
	pass

func insert(item: InventoryItem, amount: int = 1):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	var remaining_amount = amount  # Eklenmek istenen miktar

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

	emit_signal("update")

func removeItemAtIndex(index: int):
	slots[index] = InventorySlot.new()
	emit_signal("update")

func insertSlot(index: int, inventorySlot: InventorySlot):
	var oldIndex: int = slots.find(inventorySlot)
	if oldIndex != -1:
		removeItemAtIndex(oldIndex)
	
	slots[index] = inventorySlot
	emit_signal("update")

func transfer_item(target_inventory: Inventory, item: InventoryItem, amount: int = 1):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	var remaining_amount = amount

	for slot in itemslots:
		if slot.amount > 0:
			var amount_to_transfer = min(slot.amount, remaining_amount)
			target_inventory.insert(item, amount_to_transfer)
			slot.amount -= amount_to_transfer
			remaining_amount -= amount_to_transfer
			if remaining_amount == 0:
				break
	
	# Temizle eğer slot boşsa
	for i in range(slots.size()):
		if slots[i].amount == 0:
			removeItemAtIndex(i)
	
	emit_signal("update")

func update_ui():
	# Logic to update inventory UI
	for slot in slots:
		if slot:
			slot.update_ui()
