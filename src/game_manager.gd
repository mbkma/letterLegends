class_name GameManager
extends Node2D

@onready var board = $Board
@onready var player1 = $Player1
@onready var player2 = $Player2
@onready var letter_bag = $LetterBag  # Reference to the LetterBag instance

func _ready() -> void:
	distribute_tiles()

# Function to distribute tiles to the players
func distribute_tiles():
	# Distribute 7 tiles to each player
	for i in range(7):
		var letter = letter_bag.pick_tile()
		if letter.size() > 0:
			player1.give_tile(letter[0], letter[1])
		var letter2 = letter_bag.pick_tile()
		if letter2.size() > 0:
			player2.give_tile(letter2[0], letter2[1])

	print(player1.letters_in_hand)

# Function to validate and score the word placed on the board
func validate_and_score():
	var placed_letters = {}  # Store letters and positions
	for child in board.letter_container.get_children():
		placed_letters[board.tilemap.local_to_map(child.global_position)] = child.letter

	var formed_word = ""
	for pos in placed_letters.keys():
		formed_word += placed_letters[pos]

	if is_valid_word(formed_word):
		calculate_score(placed_letters)
	else:
		print("Invalid word!")

# Simple word dictionary for validation (you can replace it with an actual word list)
func is_valid_word(word: String) -> bool:
	var dictionary = ["HAUS", "BROT", "MÜLL", "FENSTER", "ÄPFEL", "SCHÖN"]  # Example words
	return word in dictionary

# Function to calculate the score of a word
func calculate_score(placed_letters):
	var total_score = 0
	for pos in placed_letters.keys():
		var letter = placed_letters[pos]
		for l in letter_bag.german_letters:
			if l[0] == letter:
				total_score += l[1]
	print("Score: ", total_score)
