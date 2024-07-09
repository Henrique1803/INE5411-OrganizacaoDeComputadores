.data
	input: .asciiz " digite uma string com até 7 dígitos:\n"
	output: .asciiz "\n número de letras 'a' digitadas: "
	str: .space 8
.text
	li $v0, 4
	la $a0, input
	syscall
	
	li $v0, 8
	la $a0, str
	li $a1, 8
	syscall
	
	la $t0, str
	li $t1, 0	#contador
loop:	
	lb $t2, 0($t0)
	li $t3, 'a'
	li $t4, '\0'	#termino da string
	beq $t2, $t4, sair
	bne $t2, $t3, else 
	addi $t1, $t1, 1
else:
	addi $t0, $t0, 1
	j loop
sair:
	li $v0, 4
	la $a0, output
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	
	