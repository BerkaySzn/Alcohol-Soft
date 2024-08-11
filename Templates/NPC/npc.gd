extends CharacterBody2D
@onready var interaction_area = $InteractionArea

const speed = 30
var current_state = IDLE

var dir = Vector2.RIGHT
var start_pos

var is_roaming = true
var is_chatting = false

var player
var player_in_chat_zone = false

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready():
	randomize()
	start_pos = position
	interaction_area.interact = Callable(self,"npc_interaction")
	
func _process(delta):
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("idle")
	elif current_state == 2 and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.play("w_walk")
		if dir.x == 1:
			$AnimatedSprite2D.play("e_walk")
		if dir.y == -1:
			$AnimatedSprite2D.play("n_walk")
		if dir.y == 1:
			$AnimatedSprite2D.play("s_walk")
			
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move(delta)

func choose(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	if !is_chatting:
		position += dir * speed * delta
		
			
		
func npc_interaction():
	$Dialogue.start()
	is_roaming = false
	is_chatting = true
	$AnimatedSprite2D.play("idle")
	#if player_in_chat_zone == false:
		#player_in_chat_zone = true
	#else:
		#player_in_chat_zone = false
	#
	
	


func _on_timer_timeout():
	$Timer.wait_time = choose([2, 3, 4])
	current_state = choose([IDLE, NEW_DIR, MOVE])
	





func _on_dialogue_dialogue_finished():
	is_roaming = true
	is_chatting = false
