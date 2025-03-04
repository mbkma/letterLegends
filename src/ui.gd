class_name UI
extends Control

@export var game_manager: GameManager


func _on_submit_button_pressed() -> void:
	game_manager.validate_and_score()


func _on_pass_button_pressed() -> void:
	game_manager.next_turn()
