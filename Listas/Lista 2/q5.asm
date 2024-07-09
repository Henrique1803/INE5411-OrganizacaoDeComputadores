.data
	in: .asciiz "Digite o número N: "
	out: .asciiz "O fatorial de N é: "
.text
	li $v0, 4
	la $a0, in
	syscall
	li $v0, 5
	syscall
	move $a0, $v0
	
	jal fatorial
	move $t0, $v0
	
	li $v0, 4
	la $a0, out
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	
	j fim
	
fatorial:
	bge $a0, 1, rec
	li $v0, 1
	jr $ra
rec:
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	addi $a0, $a0, -1
	jal fatorial
	# pto de retorno
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	mul $v0, $v0, $a0
	jr $ra
	
fim:
	nop







	
	 