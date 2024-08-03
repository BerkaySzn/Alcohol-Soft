extends StaticBody2D

@export var item:InventoryItem
var player=null


func _on_area_2d_body_entered(body):
	player = body
	collect()
	#await get_tree().create_timer(0.1).timeout
	self.queue_free()


func collect():
	player.collect(item)
