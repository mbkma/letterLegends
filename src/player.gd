class_name Player
extends Node2D

@export var game_manager: Node2D
@onready var tile_container = $TileContainer

var letters_in_hand = []
var tile_spacing = 40  # Space between tiles

func give_tile(letter: String, value: int):
	var tile_scene = preload("res://src/letter_tile.tscn").instantiate()
	tile_scene.letter = letter
	tile_scene.value = value
	tile_scene.board = game_manager.board

	# Calculate a free position
	var tile_count = tile_container.get_child_count()
	tile_scene.global_position = global_position + Vector2(tile_count * tile_spacing, 0)

	tile_container.add_child(tile_scene)
	letters_in_hand.append(tile_scene)

func remove_tile(tile):
	if tile in letters_in_hand:
		letters_in_hand.erase(tile)
