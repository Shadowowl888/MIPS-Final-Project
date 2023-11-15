.data
wordbank: .asciiz "APPLE ORANGE BANANA GRAPES MANGO"
genre_prompt: .asciiz "Choose a genre: 1. Fruits 2. Colors 3. Countries\n"
word_prompt: .asciiz "Guess the word: "
guess_prompt: .asciiz "Guess a letter: "
incorrect_guess_message: .asciiz "Incorrect guess! Try again.\n"
correct_guess_message: .asciiz "Correct guess!\n"
display: .space 100  # Adjust the size based on the maximum word length
invalid_choice_message: .asciiz "Invalid choice. Exiting.\n"

.text
main:
    # Print genre prompt
    li $v0, 4
    la $a0, genre_prompt
    syscall

    # Read user input for genre
    li $v0, 5
    syscall
    move $t0, $v0  # $t0 stores the user's genre choice

    # Select wordbank based on genre choice
    la $t1, wordbank
    beq $t0, 1, fruits
    beq $t0, 2, colors
    beq $t0, 3, countries
    j invalid_choice

fruits:
    j get_word

colors:
    la $t1, wordbank + 6  # skip "APPLE "
    j get_word

countries:
    la $t1, wordbank + 19  # skip "APPLE ORANGE BANANA "
    j get_word

get_word:
    # Select a random word from the wordbank
    li $v0, 42  # syscall for generating a random number
    li $a1, 100  # upper bound for random number (adjust as needed)
    syscall
    move $t2, $v0  # $t2 stores the random index

    # Find the selected word in the wordbank
    find_word:
        lb $t3, 0($t1)
        beq $t3, 32, word_found  # check for space (word delimiter)
        addi $t1, $t1, 1
        j find_word

    word_found:
        # $t1 now points to the beginning of the selected word
        # Initialize hangman game
        j hangman_game

invalid_choice:
    li $v0, 4
    la $a0, invalid_choice_message
    syscall

exit:
    li $v0, 10
    syscall

hangman_game:
    # Initialize hangman variables
    li $t3, 0          # Incorrect guess counter
    li $t4, 7          # Maximum allowed incorrect guesses
    li $t5, 0          # Index to track the current word character

    # Initialize guessed word display
    li $v0, 11
    la $a0, '_'
    li $t6, 0          # Index to track the display string
    la $t7, display    # Load the address of the display string
    fill_display:
        sb $a0, ($t7)  # Fill the display with underscores
        addi $t7, $t7, 1
        addi $t6, $t6, 1
        blt $t6, $t2, fill_display  # Repeat until the entire word is covered
    sb $zero, ($t7)  # Null-terminate the display string

    guess_loop:
        # Print the current state of the word
        li $v0, 4
        la $a0, display
        syscall

        # Prompt the user to guess a letter
        li $v0, 4
        la $a0, guess_prompt
        syscall

        # Read user input for guess
        li $v0, 12  # syscall for reading a single character
        syscall
        move $t8, $v0  # $t8 stores the user's guess

        # Check if the guessed letter is in the word
        li $t9, 0  # Flag to check if the letter is in the word
        check_letter:
            lb $t0, 0($t1)
            beq $t0, 32, end_check  # Check for space (word delimiter)
            beq $t0, $t8, letter_found
            addi $t1, $t1, 1
            j check_letter

        letter_found:
            sb $t8, display($t5)  # Update the display with the correct letter
            li $t9, 1  # Set the flag to indicate the letter is found
            j end_check

        end_check:
        beqz $t9, incorrect_guess  # If the letter is not found, go to incorrect_guess

        # Check if the entire word has been guessed
        addi $t5, $t5, 1
        beq $t5, $t2, correct_guess  # If the entire word is guessed, go to correct_guess

        j guess_loop

    incorrect_guess:
        # Update incorrect guess counter
        addi $t3, $t3, 1

        # Print incorrect guess message
        li $v0, 4
        la $a0, incorrect_guess_message
        syscall

        # Check if the maximum allowed incorrect guesses are reached
        bge $t3, $t4, game_over

        j guess_loop

    correct_guess:
        # Print correct guess message
        li $v0, 4
        la $a0, correct_guess_message
        syscall

        j game_over

    game_over:
        # Print the final state of the word
        li $v0, 4
        la $a0, display
        syscall

        # (Add any additional game-over messages or actions here)

        j exit
