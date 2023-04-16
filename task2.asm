#Name: CS 2640.02 Joseph Bui
#Date: 04/16/23
#Objectives:
# -Ask the user for two inputs 'x' and 'y'
# -Calculate 'x' to the power of 'y'
# -Output the answer to the user
# -Include a main label, loop label, and exit label
# -Include a loop counter

.data
prompt: .asciiz "This program asks the user to input a value for 'x' and 'y'.\nThen, it finds the value of x to the power of y.\nFor example, 2 to the power of 3 is 8.\n"
x: .asciiz "\nEnter a number for 'x': "
y: .asciiz "\nEnter a number for 'y': "
value: .asciiz "\n'x' to the power of 'y' is: "

.text
main:
	#print out the prompt for this program
	li $v0, 4
	la $a0, prompt
	syscall
	
	#ask the user for 'x' value
	li $v0, 4
	la $a0, x
	syscall
	
	#save the value of x in $s0
	li $v0, 5
	syscall
	move $s0, $v0
	
	#ask the user for 'y' value
	li $v0, 4
	la $a0, y
	syscall
	
	#save the value of y in $s1
	li $v0, 5
	syscall
	move $s1, $v0
	
	#create a loop counter
	move $t7, $zero
	
	#load $s3 with an initial value of 1
	li $s3, 1
	
loop:
	#multiply x by x
	mul $s3, $s0, $s3
	
	#increment the loop counter
	addi $t7, $t7, 1
	
	#check if the loop counter is equal to 'y'
	beq $t7, $s1, print
	
	j loop
	
print:
	#print out label for the answer
	li $v0, 4
	la $a0, value
	syscall 
	
	#print out the answer
	li $v0, 1
	move $a0, $s3
	syscall
	
exit:
	li $v0, 10
	syscall
