extends Node2D

@export var board: Board
@export var letter: String = "A"
@export var value: int = 1  # Point value

var dragging = false
var offset = Vector2.ZERO
var original_position: Vector2  # Stores original position before dragging

func _ready():
	$LetterLabel.text = letter
	$ValueLabel.text = str(value)
	original_position = global_position  # Store initial position

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and is_mouse_over():
			dragging = true
			offset = global_position - get_global_mouse_position()
		elif event.is_released() and dragging:
			dragging = false
			place_tile()

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position() + offset

func place_tile():
	var snapped_pos = board.get_snapped_position(global_position)  # Get snapped position on the board

	# Check if the tile is occupied before placing
	if not board.is_tile_occupied(snapped_pos):
		#move_to_board()  # Move the tile to the board's LetterContainer
		global_position = snapped_pos  # Snap to grid
	else:
		global_position = original_position  # Return to original position if occupied

func is_mouse_over() -> bool:
	var rect = Rect2(global_position - Vector2(12, 12), Vector2(24, 24))  # Adjust based on your letter tile's size
	return rect.has_point(get_global_mouse_position())

func move_to_board():
	if get_parent() != board.letter_container:
		var parent_player = get_parent()  # Store the current parent (player)

		# Remove from player's list and container
		if parent_player.has_method("remove_tile"):
			parent_player.remove_tile(self)

		# Ensure removal before reparenting
		call_deferred("_reparent_to_board")

func _reparent_to_board():
	get_parent().remove_child(self)  # Remove from current parent
	board.letter_container.add_child(self)  # Add to board's letter container
