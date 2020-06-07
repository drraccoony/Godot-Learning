extends Sprite

signal delete()
var speed = rand_range(100,500)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed * delta
	
	if position.y > 200:
		emit_signal("delete");
	

func _on_icon_delete():
	queue_free()
