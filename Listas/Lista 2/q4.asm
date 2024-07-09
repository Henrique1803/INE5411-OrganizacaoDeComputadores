.data
	in_1: .asciiz "\n Digite o valor do primeiro número: "
	in_2: .asciiz "\n Digite o valor do segundo número: "
	out: .asciiz "\n O resultado da soma é: "
.text
	jal soma
	move $t0, $v0
	li $v0, 4
	la $a0, out
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	j fim

soma:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal leitura
	add $v0, $v0, $v1
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

leitura:
	li $v0, 4
	la $a0, in_1
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, in_2
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	
	move $v0, $t0
	move $v1, $t1
	jr $ra

fim:
	nop
	