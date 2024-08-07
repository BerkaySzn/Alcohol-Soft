extends CharacterBody2D
const speed = 200.0

var player_state 
@onready var anim = $AnimatedSprite2D
#BERKE START
func _ready():
	InteractManager.player = self # Oyuncuyu InteractManager'a atama
	print("Player.gd is ready and has access to InteractManager")
	
#func _process(delta):
#	if Input.is_action_just_pressed("ui_interact"):
#		InteractManager.check_for_interaction()

func _input(event):
	if event.is_action_pressed("ui_interact"):
		InteractManager.check_for_interaction()
		#print("player")
#BERKE END
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
