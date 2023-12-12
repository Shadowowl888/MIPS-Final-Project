# Date: 12/6/23
# Author: Devin Khun, Sidney Nguyen, Andrew Tarng
# Course: CS 2640
# Program: MIPS Hangman Final Project
# Description: This is a simple Hangman game that chooses a
# random word from a word bank. It then prompts the user to
# guess a letter. If the letter is in the word, then it will
# appear in the blanks. If the letter is not in the word, then
# it will deduct a point from the player's score.
# The player will then be prompted if they want to play another round.
# At the end of the game, the player's total score is displayed.

.data
### word bank ###
word0:		.asciiz	"laptop"
word1:		.asciiz	"server"
word2:		.asciiz	"router"
word3:		.asciiz	"socket"
word4:		.asciiz "bitmap"
word5:		.asciiz "binary"
word6:		.asciiz "decode"
word7:		.asciiz "encode"
word8:		.asciiz	"domain"
word9:		.asciiz	"driver"
word10:		.asciiz	"google"
word11:		.asciiz "hacker"
word12:		.asciiz "online"

word_bank:		.word	word0, word1, word2, word3, word4, word5, word6, word7, word8, word9, word10, word11, word12

#length of word
length:	.word	13

#guessed letters word
guessed_letter:	.space	32

#string table
newline:		.asciiz "\n"
.:		.asciiz ".\n"
welcome_msg:	.asciiz "Welcome to Hangman! \n"
goodbye: 	.asciiz "\nGoodbye! Thanks for playing!"
correct:	.asciiz "Correct! "
incorrect:	.asciiz "Incorrect! "
word_is_msg:	.asciiz "Guess the following word using only lower-case characters "
guess_msg: .asciiz"Guess a letter?\n"
correct_word_msg:	.asciiz "\nThe correct word was:\n"
play_again_msg:	.asciiz "Play again (y/n)?\n"
round_over_msg:	.asciiz "Round over. Your last guess was:\n"
zero_points_msg:	.asciiz "You earned 0 points that round.\n"
score_msg:	.asciiz ". The score is "
final_score_msg:	.asciiz "Your final score is "
hangman1_msg:	.asciiz "\n+---+\n|   |\n|   O\n|\n|\n|\n+---\n"
hangman2_msg:	.asciiz "\n+---+\n|   |\n|   O\n|   |\n|\n|\n+---\n"
hangman3_msg:	.asciiz "\n+---+\n|   |\n|   O\n|  -|\n|  \n|\n+---\n"
hangman4_msg:	.asciiz "\n+---+\n|   |\n|   O\n|  -|-\n|  \n|\n+---\n"
hangman5_msg:	.asciiz "\n+---+\n|   |\n|   O\n|  -|-\n|  /\n|\n+---\n"
hangman6_msg:	.asciiz "\n+---+\n|   |\n|   O\n|  -|-\n| /  \\ \n|\n+---\n"

.text
main:
	jal 	random_seed			# seed random function
	lw	$s0, word_bank			# initialize s0 with the first word
	and	$s1, $s1, $0			# initialize s1 to 0 (s1 == player score)
	and	$s2, $s2, $0			# initialize s2 to 0 (s2 == run counter)
	and 	$t3, $t3, $0			# initilize t3 to 0 (t3 == number of incorrect guesses)
	
	#print welcome
	la	$a0, welcome_msg
	jal	print
	
	# while the user hasn't wanted to quit
game_loop:
	#if run counter = 0, skip rand word
	beq	$s2, $0, if_run_eq_zero		# branch if the run counter is 0
	
	jal	get_rand_word			#get a new random word
	move	$s0, $v0			#move to print
	
if_run_eq_zero:
	
	#get first word from wordbank
	move	$a0, $s0			# store word
	move	$a1, $s0			# get the original word

	
	#play game
	jal	play_game			# plays a round
	
	#increment
	add	$s1, $s1, $v0			# add return value of play_game to player score
	addi	$s2, $s2, 1			
	
	#output post-round info
	la	$a0, correct_word_msg		#load string address into correct register
	jal	print				#print "the correct word was:"
	move	$a0, $s0			#load word into right arg register
	jal	print				#print the word
	la	$a0, newline
	jal	print				# print newline
	
yes_no_prompt:
	la	$a0, play_again_msg			#load the "play again?" string
	jal	print				#print the "play again?" string
	jal	prompt_chararacter_msg			#prompt for a character
	
	beq	$v0, 121, game_loop		# if prompted char is == 'y', return to game loop (play again)
	bne	$v0, 110, yes_no_prompt	# if we didn't get an 'n' either, branch up to prompt again.
	
	# final score is...
	la	$a0, final_score_msg		# load final score is string
	jal	print				# print final score is
	
	#print num
	move	$a0, $s1			# move player score in place to be printed
	jal	print_integer
	
	#goodbye
    la  $a0, goodbye           # say goodbye
    jal print                   # print goodbye
	
	
exit:	li	$v0, 10
	syscall

#using a seed for randomization
random_seed:
	## push
	addi	$sp, $sp, -8				#allocate 8 bytes
	sw	$a0, 0($sp)				#store a0 in stack
	sw	$a1, 4($sp)				#store a1 in stack
	## code ##
	
	addi	$v0, $0, 30				#30 = get time syscall
	syscall
	
	move	$a1, $a0				# use the low ordered time bits.
	addi 	$v0, $0, 40				# 40 = set seed
	and 	$a0, $a0, $0				# set a0 to 0
	syscall
	
	## pop
	lw	$a1, 4($sp)				#put back old a1
	lw	$a0, 0($sp)				#put back old a0
	addi	$sp, $sp, 8				#deallocate
	jr	$ra				#return

#gets random word from word bank
get_rand_word:
	## push
	addi	$sp, $sp, -8
	sw	$a0, 0($sp)
	sw	$a1, 4($sp)

	## code
	addi 	$v0, $0, 42
	and 	$a0, $a0, $0
	lw	$a1, length
	syscall

	mul	$a0, $a0, 4
	lw	$v0, word_bank($a0)

	## pop
	lw	$a1, 4($sp)
	lw	$a0, 0($sp)
	addi	$sp, $sp, 8
	jr	$ra


get_rand:
	## push
	addi	$sp, $sp, -8			# allocate 12 bytes on stack
	sw	$a0, 0($sp)			# store a0
	sw	$a1, 4($sp)			# store a1
	
	## code
	addi 	$v0, $0, 42				# 42 = rand int range syscall
	move	$a1, $a0				# move range to correct register
	and 	$a0, $a0, $0				# set a0 to 0
	syscall						# a0 now contains a rand int within a1 range
	
	move	$v0, $a0
	
	## pop
	lw	$a1, 4($sp)
	lw	$a0, 0($sp)
	addi	$sp, $sp, 8			#deallocate
	jr	$ra				#return


string_length:
	## push
	addi	$sp, $sp, -4			#allocate 4 bytes
	sw	$a0, 0($sp)			# store current a0
	
	## code
	and	$v0, $v0, $0			# set iterator to 0
loop_length:
	lb	$t8, 0($a0)			# get the byte from the string	
	beq	$t8, $0, end_loop		# if nul, quit loop
	
	addi	$a0, $a0, 1			# increment dest address
	addi	$v0, $v0, 1			# increment count
	
	j	loop_length			# jump to top of loop

end_loop:	
	## pop
	lw	$a0, 0($sp)			#load old a0
	addi	$sp, $sp, 4			#deallocate
	jr	$ra				#return


copy_loop:
	lb	$t8, 0($a1)			# get the byte from the source string	
	sb	$t8, 0($a0)			# store byte into dest string
	beq	$t8, $0, end_copy_loop		# if nul, quit loop
		
	addi	$a0, $a0, 1			# increment dest address
	addi	$a1, $a1, 1			# increment source address
	addi	$v0, $v0, 1			# increment count

	j	copy_loop			# jump to top of loop
end_copy_loop:	
	## pop ##
	lw	$a0, 0($sp)			# load old a0
	lw	$a1, 4($sp)			# load old a1
	addi	$sp, $sp, 8			# deallocate
	jr	$ra				#return

play_game:
	## push ##
	addi	$sp, $sp, -24			# allocate 12 bytes
	sw	$ra, 0($sp)			# save return address
	sw	$a0, 4($sp)			# store current a0
	sw	$a1, 8($sp)			# store current a1
	sw	$s0, 12($sp)			# store current s0
	sw	$s1, 16($sp)			# store current s1
	sw	$s2, 20($sp)			# store current s2
	
	## code ##
	jal	string_length				# get length
	move	$s0, $v0			# store length (score) in s0
	move	$s1, $a0			# save the string location
	
	#setup the underscores
	la	$a0, guessed_letter			# get the guessed word buffer
	move	$a1, $s0			# get the word length
	jal	fill_blanks			# fill the word with underscores
	
round_loop:
	# do while score > 0 && underscores_present
	beq	$s0, $0, end_round_loop	# sanity check
		
	#	_status display_
	la	$a0, word_is_msg		# print "the word is ___"
	jal	print
	la	$a0, guessed_letter			# print the guessed word so far
	jal	print
	la	$a0, score_msg			# print score is
	jal	print
	move	$a0, $s0			# print actual score
	jal	print_integer
	la	$a0, .				# print period
	jal	print
	
	#output guess a letter prompt
	la	$a0, guess_msg		
	jal	print				# prints "guess a letter?"
	
	#prompt for char
	jal	prompt_chararacter_msg			# prompt for character
	move	$s2, $v0			# save character entered in v0
	
	
	#see if string contains char
	move	$a0, $s1			# move s1 (the location of the original word) into a0
	move	$a1, $s2			# move the char entered in a1
	jal	string_contains			# see if string contains character
	
	# if string does not contain the char, print no, else print yes and update our guessed word.
	bne	$v0, $0, round_character_found	# if return value != 0, we have success
	
	### if char match not found
	addi	$s0, $s0 -1			# wrong char, subtract 1 from score
	addi	$t3, $t3, 1			# increment number of incorrect guesses by 1
	
	# Check the value of $t3 for specific conditions and print messages
    	beq $t3, 1, print_hangman1   # If $t3 equals 1, jump to print_hangman1
    	beq $t3, 2, print_hangman2   # If $t3 equals 2, jump to print_hangman2
    	beq $t3, 3, print_hangman3   # If $t3 equals 3, jump to print_hangman3
    	beq $t3, 4, print_hangman4   # If $t3 equals 4, jump to print_hangman4
    	beq $t3, 5, print_hangman5   # If $t3 equals 5, jump to print_hangman5
    	beq $t3, 6, print_hangman6   # If $t3 equals 6, jump to print_hangman6
	
	# character not found. display no!
	la	$a0, incorrect				# load incorrect!
	jal	print				# print incorrect!
	beq	$s0, $0, zero_points	# if score == 0, end round now
	
	j	round_loop			# guess again!
round_character_found:
	#char found, print yes and update guessed
	
	# update guessed
	la	$a0, guessed_letter			# load address of guessed buffer
	move	$a1, $s1			# load address of the permuted word
	move	$a2, $s2			# load the character the player just entered
	jal	update_guessed			# updated the guessed buffer with correct letters
	
	# if the guessed buffer contains underscores '_', continue
	la	$a0, guessed_letter			# load guessed address for strcontains
	addi	$a1, $0, 95			# set a1 (the char) to 95 (the ascii value of underscore) for strcontains
	jal	string_contains			# check if guessed still has underscores
	beq	$v0, $0, end_round_loop	# if no underscores left in guess, end round
	
	#print yes
	la	$a0, correct			# load correct!
	jal	print				# print correct!
	


	j	round_loop			# jump to top of loop
print_hangman1:
    # Print hangman1_msg
    li $v0, 4
    la $a0, hangman1_msg
    syscall

    j round_loop  # Jump back to the top of the loop
print_hangman2:
    # Print hangman2_msg
    li $v0, 4
    la $a0, hangman2_msg
    syscall

    j round_loop  # Jump back to the top of the loop
print_hangman3:
    # Print hangman2_msg
    li $v0, 4
    la $a0, hangman3_msg
    syscall

    j round_loop  # Jump back to the top of the loop
print_hangman4:
    # Print hangman2_msg
    li $v0, 4
    la $a0, hangman4_msg
    syscall

    j round_loop  # Jump back to the top of the loop
print_hangman5:
    # Print hangman2_msg
    li $v0, 4
    la $a0, hangman5_msg
    syscall

    j round_loop  # Jump back to the top of the loop
print_hangman6:
    # Print hangman2_msg
    li $v0, 4
    la $a0, hangman6_msg
    syscall

    j round_loop  # Jump back to the top of the loop
    
zero_points:
	la	$a0, zero_points_msg			# load the you earned no points
	jal	print				# print you earned no points
end_round_loop:

	# end of round msg
	la	$a0, round_over_msg			# display round over message
	jal	print
	la	$a0, guessed_letter			# display letters guessed
	jal	print
	
	move	$v0, $s0			# move s0 (score) to v0 (return register)
		
	## pop
	lw	$ra, 0($sp)			# load return address
	lw	$a0, 4($sp)			# load old a0
	lw	$a1, 8($sp)			# load old a1
	lw	$s0, 12($sp)			# load old s0
	lw	$s1, 16($sp)			# load old s1
	lw	$s2, 20($sp)			# load old s2
	addi	$sp, $sp, 24			# deallocate
	jr	$ra				#return

fill_blanks:
	## push
	addi	$sp, $sp, -8			# allocate 8 bytes
	sw	$a0, 0($sp)			# store current a0
	sw	$a1, 4($sp)			# store current a1
	
	## code
	add	$a0, $a0, $a1			# a0 = address of string + length
	addi	$t1, $0, 95			# set t1 = ascii value for '_' underscore
	sb	$0,0($a0)			# set last byte to nul
fill_blanks_loop:
	beq	$a1, $0, end_fill_blanks_loop	# if a1 < 0, we're done.
	addi	$a0, $a0, -1			# decrement buffer position
	addi	$a1, $a1, -1			# decrement length
	sb	$t1, 0($a0)			# store underscore
	j	fill_blanks_loop		# back to start of loop
end_fill_blanks_loop:
	## pop
	lw	$a0, 0($sp)			# load old a0
	lw	$a1, 4($sp)			# load old a1
	addi	$sp, $sp, 8			# deallocate
	jr	$ra				#return

prompt_chararacter_msg:
	## push
	addi	$sp, $sp, -12			# allocate 4 bytes
	sw	$ra, 0($sp)			# store old return address
	sw	$a0, 4($sp)			# store old a0
	sw	$s0, 8($sp)			# store old s0
	## code

	addi $v0, $0, 12			# 4 = print string syscall
	syscall					# v0 now contains a char
	move	$s0, $v0			# temporarily save char
	
	la	$a0, newline
	jal	print				#print newline
	jal	print				#print newline
	
	move	$v0, $s0			# move char back into return register
	
	## pop
	lw	$ra, 0($sp)			# load old return address
	lw	$a0, 4($sp)			# load old a0
	lw	$s0, 8($sp)			# load old s0
	addi	$sp, $sp, 12			# deallocate
	jr	$ra				#return

string_contains:
	## push
	addi	$sp, $sp, -4			# allocate 4 bytes
	sw	$a0, 0($sp)			# store old a0
	
	## code
	and	$v0, $v0, $0			# set $v0 to 0 or false
	
string_contains_loop:
	lb	$t0, 0($a0)				# load char in from string
	beq	$t0, $0, end_string_contains_loop		#if we reach end of string, stop loop
	beq	$t0, $a1, string_character_found		#if char matches the passed in value, branch
	addi	$a0, $a0, 1					# increment string address to continue scanning
	j	string_contains_loop			# jump to top of loop
string_character_found:
	addi	$v0, $0, 1				# if char found, set return value = 1
end_string_contains_loop:
	## pop
	lw	$a0, 0($sp)			# load old a0
	addi	$sp, $sp, 4			# deallocate
	jr	$ra				#return

update_guessed:
	## push
	addi	$sp, $sp, -8			# allocate 4 bytes
	sw	$a0, 0($sp)			# store old a0
	sw	$a1, 4($sp)			# store old a1
	
	## code
update_guessed_loop:
	lb	$t0, 0($a1)				# load char in from string
	beq	$t0, $0, end_update_guessed_loop		#if we reach end of string, stop loop
	bne	$t0, $a2, character_not_found		#if char doesn't match, branch
	sb	$a2, 0($a0)				# store passed in char in desired position.
character_not_found:
	addi	$a0, $a0, 1				#increment guessed buffer
	addi	$a1, $a1, 1				#increment original string pos
	j	update_guessed_loop
end_update_guessed_loop:
	## pop
	lw	$a1, 4($sp)			# load old a1
	lw	$a0, 0($sp)			# load old a0
	addi	$sp, $sp, 8			# deallocate
	jr	$ra				# return

print:
	## code
	addi $v0, $0, 4				# 4 = print string syscall
	syscall

	
	
	
	## pop
	jr	$ra				#return
print_integer:
	## code
	addi $v0, $0, 1				# 1 = print int syscall
	syscall
	
	## pop
	jr	$ra				#return
