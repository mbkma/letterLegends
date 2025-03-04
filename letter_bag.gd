class_name LetterBag
extends Node

# Updated letter distribution for German Scrabble
var german_letters = [
	["A", 1, 5], ["B", 3, 2], ["C", 4, 2], ["D", 1, 4], ["E", 1, 15], ["F", 4, 2],
	["G", 2, 3], ["H", 4, 4], ["I", 1, 6], ["J", 6, 1], ["K", 4, 2], ["L", 2, 3],
	["M", 3, 4], ["N", 1, 9], ["O", 2, 3], ["P", 4, 1], ["Q", 8, 1], ["R", 1, 6],
	["S", 1, 7], ["T", 1, 6], ["U", 1, 6], ["V", 6, 1], ["W", 3, 1], ["X", 8, 1],
	["Y", 8, 1], ["Z", 3, 1], ["Ä", 6, 1], ["Ö", 8, 1], ["Ü", 6, 1], ["ß", 6, 2]
]

var available_tiles = []

# Function to initialize the bag with tiles based on the distribution
func _ready():
	# Fill the available_tiles array based on the letter distribution
	available_tiles.clear()
	for letter in german_letters:
		for i in range(letter[2]):
			available_tiles.append([letter[0], letter[1]])

	# Shuffle the tiles to randomize the distribution
	available_tiles.shuffle()

# Function to pick a tile from the bag
func pick_tile() -> Array:
	if available_tiles.size() > 0:
		return available_tiles.pop_back()
	else:
		return []  # Return an empty array if no tiles are left

# Function to add a tile back to the bag (in case of a tile being returned)
func return_tile(letter: String, points: int):
	available_tiles.append([letter, points])
	available_tiles.shuffle()  # Optional: shuffle again after returning a tile
