extends CharacterBody2D

@export var speed = 100
@export var jumpSpeed = 250
@export var maxHealth = 10

var currentHealth
var isMoving = false
var changeMove = 100
var isBurrowed = false
var isBurrowing = false

const GRAVITY = 400.0
@onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	currentHealth = maxHealth
	$Area2D/BossHealth.max_value = maxHealth
	$Area2D/BossHealth.value = currentHealth
	pass # Replace with function body.

func _process(_delta):
	
	if(isMoving == false && isBurrowing == false):
		changeMove = 100
		
		var randomDirection = randf_range(1,30)
		if(randomDirection >= 1 and randomDirection <= 8):
			velocity.x = -speed
			isMoving = true
			$AnimatedSprite2D.play("default")
			$AnimatedSprite2D.flip_h = true
		elif(randomDirection >= 9 and randomDirection <= 16):
			velocity.x = speed
			isMoving = true
			$AnimatedSprite2D.play("default")
			$AnimatedSprite2D.flip_h = false
		elif(randomDirection >= 17 and randomDirection <= 24):
			velocity.x = 0
			isMoving = true
			$AnimatedSprite2D.stop()
		else:
			if(isBurrowed == false):
				velocity.x = 0
				isBurrowing = true
				$BurrowArea/BurrowCollision.set_deferred("disabled", false)
				$AnimatedSprite2D.play("burrow")
				await get_tree().create_timer(1.6).timeout
				position.y += 200
				speed = 300
				isBurrowed = true
				isBurrowing = false
				$AnimatedSprite2D.stop()
				$BurrowArea/BurrowCollision.set_deferred("disabled", true)
			else:
				velocity.x = 0
				position.y -= 200
				isBurrowed = false
				speed = 100
				$AnimatedSprite2D.stop()
				isMoving = true
	
		move_and_slide()
	else:
		move_and_slide()
		changeMove -= 1
		if(changeMove == 0):
			isMoving = false

func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		body.changeHealth(-5)
	pass # Replace with function body.

func changeHealth(changeValue, node):
	$Area2D/BossHealth.visible = true
	currentHealth += changeValue
	$Area2D/BossHealth.value = currentHealth
	self.modulate = Color8(255,0,0)
	if(currentHealth <= 0):
		hide()
		node.killedBoss()
		$CollisionShape2D.set_deferred("disabled", true)
		self.queue_free()
	await get_tree().create_timer(0.5).timeout 
	self.modulate = Color8(255,255,255,255)
		
