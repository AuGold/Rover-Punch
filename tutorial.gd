extends Node2D

@export var enemiesToSpawn = 10
var enemiesCreated = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.changeHealth($Player.maxHealth)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(enemiesToSpawn > 0):
		enemiesToSpawn -= 1
		var enemyNode = $ExampleEnemy.duplicate()
		enemyNode.position = Vector2($ExampleEnemy.position.x + (70* enemiesCreated), $ExampleEnemy.position.y)
		add_child(enemyNode)
		enemiesCreated += 1
	
	pass