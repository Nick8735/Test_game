class_name Bullet
extends RigidDynamicBody2D

var disabled = false

func _ready():
	($Timer as Timer).start()


func disable():
	if disabled:
		return

	($AnimationPlayer as AnimationPlayer).play("shutdown")
	disabled = true
