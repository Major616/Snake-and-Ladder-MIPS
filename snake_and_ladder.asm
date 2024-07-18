.data
newline:    .asciiz "\n"
prompt:     .asciiz "\nEnter your roll (1-6): "
oops:        .asciiz "+===Oops! You hit a snake. ===+\n"
cong:        .asciiz "+=== Congratulations! You climbed a ladder. ===+\n"
congw:      .asciiz "+===Congratulations! You won the game. ===+"
cur:        .asciiz "+===Your current position:  "
inv:         .asciiz "+===Invalid input. Please enter a number between 1 and 6.===+\n"
snake1:     .word 16
snake2:      .word 24
snake3:      .word 37
snake4:      .word 49
ladder1:     .word 8
ladder2:     .word 13
ladder3:     .word 38
ladder4:     .word 43
player_pos: .word 1
err:        .asciiz "+===Oops! Your position exceeds 50. Please roll again.===+\n"



.text
main:
    li $v0, 4           # Print string
    la $a0, prompt
    syscall

    li $v0, 5           # Read integer
    syscall
    move $t0, $v0       # Store the roll in $t0

    # Check for valid input (1-6)
    bgt $t0, 6, invalid_input
    blt $t0, 1, invalid_input
    
    # Store the current position in $t3 before updating
    lw $t3, player_pos   # Load current player position to $t3


    # Update player position
    lw $t1, player_pos   # Load current player position
    add $t1, $t1, $t0    # Add roll to position
    sw $t1, player_pos   # Store the updated position back to memory

    
    # Check if position is 50 (winning position)
    li $t2, 50
    beq $t1, $t2, player_wins

    # Check if position exceeds 50
    li $t2, 50
    bgt $t1, $t2, position_exceeds_50
    
    # Check for snakes and ladders
   lw $t2, snake1
   beq $t1, $t2, hit_snake1

   lw $t2, snake2  
   beq $t1, $t2, hit_snake2

   lw $t2, snake3 
   beq $t1, $t2, hit_snake3

   lw $t2, snake4 
   beq $t1, $t2, hit_snake4

   lw $t2, ladder1
   beq $t1, $t2, climb_ladder1

   lw $t2, ladder2
   beq $t1, $t2, climb_ladder2

   lw $t2, ladder3 
   beq $t1, $t2, climb_ladder3

   lw $t2, ladder4 
   beq $t1, $t2, climb_ladder4
   
   # No snake or ladder
   b no_snake_or_ladder



climb_ladder1:
    # Display ladder message for ladder1
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, cong
    syscall

    # Add 6 to the player's position
    lw $t1, player_pos
    addi $t1, $t1, 6
    sw $t1, player_pos   # Update the player's position

    # Display the new position
    li $v0, 4
    la $a0, cur
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    j main  # Continue the game

climb_ladder2:
    # Display ladder message for ladder2
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, cong
    syscall

    # Add 6 to the player's position
    lw $t1, player_pos
    addi $t1, $t1, 23
    sw $t1, player_pos   # Update the player's position

    # Display the new position
    li $v0, 4
    la $a0, cur
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    j main  # Continue the game

climb_ladder3:
    # Display ladder message for ladder3
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, cong
    syscall

    # Add 6 to the player's position
    lw $t1, player_pos
    addi $t1, $t1, 7
    sw $t1, player_pos   # Update the player's position

    # Display the new position
    li $v0, 4
    la $a0, cur
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    j main  # Continue the game

climb_ladder4:
    # Display ladder message for ladder4
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, cong
    syscall

    # Add 6 to the player's position
    lw $t1, player_pos
    addi $t1, $t1, 5
    sw $t1, player_pos   # Update the player's position

    # Display the new position
    li $v0, 4
    la $a0, cur
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    j main  # Continue the game


no_snake_or_ladder:
    # Check if player reached the final position
    #li $t2, 25
    bne $t1, $t2, not_won

    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, congw
    syscall
    j game_over

not_won:
    # Display current position
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, cur
    syscall
    li $v0, 1
    move $a0, $t1   # Load the current player position into $a0
    syscall
    j main

position_exceeds_50:
   li $v0, 4
   la $a0, newline
   syscall
   li $v0, 4
   la $a0, err
   syscall
   # Set the player's position back to the last valid position
   sw $t3, player_pos
   j main  # Jump back to the beginning of the game to get a new roll

player_wins:
   li $v0, 4
   la $a0, newline
   syscall
   li $v0, 4
   la $a0, congw
   syscall
   j game_over
   
hit_snake1:
    # Display snake message for snake1
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, oops
    syscall

    # Subtract 5 from the player's position
    lw $t1, player_pos
    sub $t1, $t1, 5
    sw $t1, player_pos   # Update the player's position

    # Display the new position
    li $v0, 4
    la $a0, cur
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    j main  # Continue the game

hit_snake2:
    # Display snake message for snake2
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, oops
    syscall

    # Subtract 5 from the player's position
    lw $t1, player_pos
    sub $t1, $t1, 10
    sw $t1, player_pos   # Update the player's position

    # Display the new position
    li $v0, 4
    la $a0, cur
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    j main  # Continue the game

hit_snake3:
    # Display snake message for snake3
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, oops
    syscall

    # Subtract 5 from the player's position
    lw $t1, player_pos
    sub $t1, $t1, 15
    sw $t1, player_pos   # Update the player's position

    # Display the new position
    li $v0, 4
    la $a0, cur
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    j main  # Continue the game

hit_snake4:
    # Display snake message for snake4
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, oops
    syscall

    # Subtract 5 from the player's position
    lw $t1, player_pos
    sub $t1, $t1, 30
    sw $t1, player_pos   # Update the player's position

    # Display the new position
    li $v0, 4
    la $a0, cur
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    j main  # Continue the game
invalid_input:
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, inv
    syscall
    j main

game_over:
    li $v0, 10          # Exit program
    syscall
