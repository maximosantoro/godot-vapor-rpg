extends Area2D

onready var timer = $Timer
onready var collision_shape = $CollisionShape2D
const HitEffect = preload("res://effects/HitEffect.tscn")

var inv = false setget set_inv

signal inv_started
signal inv_ended

func set_inv(value):
	inv = value
	if inv == true:
		emit_signal("inv_started")
	else:
		emit_signal("inv_ended")

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position
	
func start_inv(duration):
	self.inv = true
	timer.start(duration)

func _on_Timer_timeout():
	self.inv = false

func _on_Hurtbox_inv_started():
	collision_shape.set_deferred("disabled", false)

func _on_Hurtbox_inv_ended():
	monitorable = true

