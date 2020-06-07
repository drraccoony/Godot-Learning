extends Area2D
const MOVE_SPEED = 125.0
const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180
const PLAYER_OFFSET = 8
signal destroyed

# Define variables we're gonna use.
var can_shoot = true
var shot_scene = preload("res://scenes/shot.tscn")

func _process(delta):
	var input_dir = Vector2()
	# Handle input. We're using hardcoded keys for now.
	if Input.is_key_pressed(KEY_W):
		input_dir.y -= 1.0
	if Input.is_key_pressed(KEY_S):
		input_dir.y += 1.0
	if Input.is_key_pressed(KEY_A):
		input_dir.x -= 1.0
	if Input.is_key_pressed(KEY_D):
		input_dir.x += 1.0

	position += (delta * MOVE_SPEED) * input_dir

	# Handle firing bullets
	if Input.is_key_pressed(KEY_SPACE) and can_shoot:
		var stage_node = get_parent()
		var shot_instance = shot_scene.instance()
		shot_instance.position = position
		stage_node.add_child(shot_instance)
		can_shoot = false
		get_node("reload_timer").start()

	# Stop the player from going off-screen
	if position.x < 0.0 + PLAYER_OFFSET:
		position.x = 0.0 + PLAYER_OFFSET
	elif position.x > SCREEN_WIDTH - PLAYER_OFFSET:
		position.x = SCREEN_WIDTH - PLAYER_OFFSET
	if position.y < 0.0 + PLAYER_OFFSET:
		position.y = 0.0 + PLAYER_OFFSET
	elif position.y > SCREEN_HEIGHT - PLAYER_OFFSET:
		position.y = SCREEN_HEIGHT - PLAYER_OFFSET

# Handle the firing rate with a timer.
func _on_reload_timer_timeout():
	can_shoot = true

func _on_player_area_entered(area):
	if area.is_in_group("asteroid"):
		emit_signal("destroyed");
		queue_free()
