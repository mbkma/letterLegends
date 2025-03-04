class_name Board
extends Node2D

@onready var tilemap_layer : TileMapLayer = $TileMapLayer  # Reference to your TileMapLayer node
@onready var letter_container = $LetterContainer  # Holds letter tiles on the board

@export var offset := Vector2(5, -10)

# Converts a world position to the nearest tile
func get_snapped_position(world_pos: Vector2) -> Vector2:
	print(world_pos)
	# Get the tile coordinates in the TileMapLayer (grid coordinates)
	var tile_coords = tilemap_layer.local_to_map(world_pos)
	# Convert the tile coordinates back to the center position in world space
	var snapped_pos = tilemap_layer.map_to_local(tile_coords)

	var res =  snapped_pos + offset
	print(res)
	return res

# Checks if a tile is occupied (by comparing positions)
func is_tile_occupied(world_pos: Vector2) -> bool:
	for child in letter_container.get_children():
		# Check if another tile is occupying the snapped position
		if child.global_position == get_snapped_position(world_pos):
			return true  # Tile is already occupied
	return false
