extends Node2D

@export var board: Board

func _ready() -> void:
	#print(self.to_local(global_position))
	print(board.get_snapped_position(position))
