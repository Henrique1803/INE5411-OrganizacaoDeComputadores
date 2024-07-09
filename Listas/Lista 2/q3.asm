.data
	input_base: .asciiz "digite a base: "
	input_exp: .asciiz "digite o expoente: "
	output: .asciiz "\nresultado: "
.text
	li $v0, 4
	la $a0, input_base
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, input_exp
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	
	move $a0, $t0
	move $a1, $t1
	jal pow
	move $t0, $v0
	li $v0, 4
	la $a0, output
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	j fim

pow:	
	li $t0, 1
	li $t1, 0
loop:
	bge $t1, $a1, fim_loop
	mul $t0, $t0, $a0
	addi $t1, $t1, 1
	j loop
fim_loop:
	move $v0, $t0
	jr $ra
	
fim:	nop
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	