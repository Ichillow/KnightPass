extends CanvasLayer


@onready var label_coin: Label = $Label_coins

var current_coins = 0


func add_coin(amount: int) -> void:
	current_coins += amount
	label_coin.text = "X" + str(current_coins)