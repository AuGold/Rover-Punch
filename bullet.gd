extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	move_and_slide()
	pass

func _on_area_2d_body_entered(body):
	if(body.name == "TileMap"):
		$CollisionPolygon2D.set_deferred("disabled", true)
		hide()
		self.queue_free()
	else:
		for group in body.get_groups():
			if(group == "Enemy"):
				$CollisionPolygon2D.set_deferred("disabled", true)
				body.changeHealth(-5)
				hide()
				self.queue_free()
