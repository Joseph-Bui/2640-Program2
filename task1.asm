#Name: CS 2640.02 Joseph Bui
#Date: 04/16/23
#Objectives:
# -Create and print a user menu
# -Include a main label, a looping label, and an exit label
# -Include a way for the user to keep getting letter grades or to quit
# -Include error handling if the user inputs an incorrect response

.data
menu: .asciiz "\n\n---------------MAIN MENU--------------- \n(1)Get Letter Grade \n(2)Exit Program\n\nEnter '1' or '2' for your selection: "
getInt: .asciiz "\nPlease enter a score as an integer value: "
newScore: .asciiz "\nWould you like to enter a new score?\n(Y)Yes (N)No \n\nEnter 'Y' or 'N' for your selection: "
error: .asciiz "\nInvalid input! Please select a valid choice.\n"
space: .asciiz "\n---------------------------------------\n"
exitMessage: .asciiz "\nThe program will now exit."

invalidGrade: .asciiz "Invalid grade. Please enter another score."
gradeA: .asciiz "The grade is: A"
gradeB: .asciiz "The grade is: B"
gradeC: .asciiz "The grade is: C"
gradeD: .asciiz "The grade is: D"
gradeF: .asciiz "The grade is: F"


.text
main:
	#print out the menu for the user
	li $v0, 4
	la $a0, menu
	syscall

	#obtain and store user input in $t0
	li $v0, 5
	syscall
	move $t0, $v0
	
	#branch to loop or exit based on user choice
	beq $t0, 1, loop
	beq $t0, 2, exit
	
	#print message if choice is invalid and jump back to main
	li $v0, 4
	la $a0, error
	syscall
	j main
	
loop:
	#print out break line
	li $v0, 4
	la $a0, space
	syscall 
	
	#ask the user for a grade as a decimal integer
	li $v0, 4
	la $a0, getInt
	syscall
	
	#store the user input in $s0
	li $v0, 5
	syscall
	move $s0, $v0
	
	#branch based on the decimal grade
	blt $s0, 0, invalid
	blt $s0, 60, F
	blt $s0, 70, D
	blt $s0, 80, C
	blt $s0, 90, B
	bge $s0, 90, A
	
invalid:
	#print out error message an jump back to loop
	li $v0, 4
	la $a0, invalidGrade
	syscall
	j loop
F:
	#print message grade is less than 60
	li $v0, 4
	la $a0, gradeF
	syscall
	j NEWSCORE

D:
	#print message grade is less than 70
	li $v0, 4
	la $a0, gradeD
	syscall
	j NEWSCORE
	
C:
	#print message grade is less than 80
	li $v0, 4
	la $a0, gradeC
	syscall
	j NEWSCORE
	
B:
	#print message grade is less than 90
	li $v0, 4
	la $a0, gradeB
	syscall
	j NEWSCORE
	
A:
	#print message grade is less than or equal to 100
	li $v0, 4
	la $a0, gradeA
	syscall
	
NEWSCORE:
	#print out break line
	li $v0, 4
	la $a0, space
	syscall 
	
	#print message to prompt user for input
	li $v0, 4
	la $a0, newScore
	syscall
	
	#read user input and store it into $s1
	li $v0, 12
	syscall
	move $s1, $v0
	
	#jump to loop or main based on the value in $s1
	beq $s1, 89, loop
	beq $s1, 78, main
	
	#print error message if input is invalid
	li $v0, 4
	la $a0, error
	syscall
	
	#jump back to NEWSCORE if input is invalid
	j NEWSCORE

	
	
exit:
	#print exit message
	li $v0, 4
	la $a0, exitMessage
	syscall
	
	li $v0, 10
	syscall
