extends CharacterBody2D
#by Mürsel
@export var inv: Inventory 
@onready var inventory_ui = $InventoryUI
@onready var chest_inventory_ui = $ChestInventoryUI
var current_chest: Area2D = null
#by Mürsel End
const speed = 200.0

var player_state 
@onready var anim = $AnimatedSprite2D



func _physics_process(delta):
	#by berkay start
	var dir = Input.get_vector("left", "right", "up", "down")
	
	if dir.x == 0 and dir.y == 0:
		player_state = "idle"
	elif dir.x != 0 or dir.y != 0:
		player_state = "walk"
	
	velocity = speed * dir
	#by berkay end
	move_and_slide()
	
	play_anim(dir)
#by Mürsel
	check_chest_interaction()

func collect(item):
	inv.insert(item)
	
func check_chest_interaction():
	if current_chest and Input.is_action_just_pressed("ui_accept"):
		if chest_inventory_ui.is_open:
			close_chest()
		else:
			open_chest(current_chest)
			
func _on_Area2D_body_entered(body):
		if body.is_in_group("chest"):  # Envanteri kontrol etmek için grup kontrolü
			current_chest = body
		# Ek bir işlev çağırarak chest ile etkileşimi yönetebilirsiniz, eğer gerekliyse

func _on_Area2D_body_exited(body):
	if body == current_chest:
		current_chest = null
		close_chest()
func open_chest(chest):
	if chest:
		chest_inventory_ui.open()
		chest_inventory_ui.chest_inventory = chest.chest_inventory
		chest_inventory_ui.update_slots()

func close_chest():
	chest_inventory_ui.close()

# Ekstra işlev: Chest'teki item'ı player'ın envanterine taşıma
func transfer_item_to_chest(item: InventoryItem, amount: int = 1):
	if current_chest and inv:
		current_chest.chest_inventory
#by Mürsel End

func play_anim(dir):
	if player_state == "idle":
		anim.play("idle")
	elif player_state == "walk":
		if dir.y == -1:
			anim.play("n_walk")
		if dir.x == 1:
			anim.play("e_walk")
		if dir.y == 1:
			anim.play("s_walk")
		if dir.x == -1:
			anim.play("w_walk")

		if dir.x > 0.5 and dir.y < -0.5:
			anim.play("ne_walk")
		if dir.x > 0.5 and dir.y > 0.5:
			anim.play("se_walk")
		if dir.x < -0.5 and dir.y > 0.5:
			anim.play("sw_walk")
		if dir.x < -0.5 and dir.y < -0.5:
			anim.play("nw_walk")
