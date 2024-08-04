extends CharacterBody2D
#by Mürsel
@export var inv: Inventory 
#by Mürsel End
const speed = 100.0

var player_state



func _physics_process(delta):
	var dir = Input.get_vector("left", "right", "up", "down")
	
	if dir.x == 0 and dir.y == 0:
		player_state = "idle"
	elif dir.x != 0 or dir.y != 0:
		player_state = "walk"
	
	velocity = speed * dir
	
	move_and_slide()
#by Mürsel
func collect(item):
	inv.insert(item)
#by Mürsel End
