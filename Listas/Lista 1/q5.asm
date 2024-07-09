.data
	a: .word 0
	b: .word 0
	input_a: .asciiz "digite a: "
	input_b: .asciiz "digite b: "
	input_c: .asciiz "digite c: "
.text
	li $v0, 4 	#impressão de string
	la $a0, input_a
	syscall
	
	li $v0, 5	#leitura de int
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, input_b
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	li $v0, 4
	la $a0, input_c
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	beq $t0, 1, case1
	beq $t0, 2, case2
	j default
	
case1:	addi $t1, $t2, 1
	j fim
case2:	addi $t1, $t2, 2
	j fim
default:
	move $t1, $t2
	j fim
fim:	nop