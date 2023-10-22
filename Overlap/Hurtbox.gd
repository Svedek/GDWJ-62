extends Area2D

signal on_damaged(damage:int)


func take_damage(damage:int):
	emit_signal("on_damaged", damage)
