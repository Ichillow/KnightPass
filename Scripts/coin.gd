extends Area2D


#ONREADY
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ui = $"../UI"


func _ready() -> void:
	animation_player.play("coin")

func _on_body_entered(body:Node2D) -> void:
	if body.name == "player" :
		ui.add_coin(1)
		queue_free()
