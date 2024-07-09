.data
	input: .asciiz " digite uma string com até 7 dígitos:\n"
	output: .asciiz "\n string digitada e armazenada na memória: "
	str: .space 8
.text
	li $v0, 4
	la $a0, input
	syscall
	
	li $v0, 8
	la $a0, str
	li $a1, 8
	syscall
	
	li $v0, 4
	la $a0, output
	syscall
	
	li $v0, 4
	la $a0, str
	syscall
	
	