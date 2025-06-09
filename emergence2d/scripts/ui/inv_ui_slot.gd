extends Panel

'''
Handles updating a slot instance
'''

# UI elements for displaying the item and its amount
@onready var item_visual:Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label  = $CenterContainer/Panel/Label 

# Updates current slot with a given inventory slot resource
func update(slot:InvSlot):
	if !slot.item:
		item_visual.visible =  false  
		amount_text.visible = false 
	else:
		item_visual.visible = true
		item_visual.texture =slot.item.texture
		amount_text.visible = true 
		amount_text.text = str(slot.amount)
