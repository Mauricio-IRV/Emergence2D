extends Resource
class_name Inv 
@export var slots: Array[InvSlot]
signal  update 
func insert (item:invItem):
	var itemSlots = slots.filter (func (slot): return slot.item == item)
	if !itemSlots.is_empty():
		itemSlots[0].amount += 1
	else:
		var emptySlots = slots.filter (func (slot): return slot.item == null) 
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
			
	update.emit()
