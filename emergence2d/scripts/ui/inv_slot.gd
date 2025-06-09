extends Resource
class_name InvSlot
'''
Represents a single slot in the inventory.
Holds a reference to an item and the amount of that item.
'''

@export var item: invItem
@export var amount: int
