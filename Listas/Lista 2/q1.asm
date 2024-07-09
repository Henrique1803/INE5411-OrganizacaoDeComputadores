.data
	F: .word 0
	G: .word 0
	H: .word 0
	I: .word 0
	J: .word 0
	input_g: .asciiz "digite g: "
	input_h: .asciiz "digite h: "
	input_i: .asciiz "digite i: "
	input_j: .asciiz "digite j: "
	output: .asciiz "f = "
.text
	li $v0, 4
	la $a0, input_g
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, input_h
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	
	li $v0, 4
	la $a0, input_i
	syscall
	li $v0, 5
	syscall
	move $t2, $v0
	
	li $v0, 4
	la $a0, input_j
	syscall
	li $v0, 5
	syscall
	move $t3, $v0
	
	la $s0, G
	la $s1, H
	la $s2, I
	la $s3, J
	
	sw $t0, 0($s0)
	sw $t1, 0($s1)
	sw $t2, 0($s2)
	sw $t3, 0($s3)
	
	move $a0, $t0
	move $a1, $t1
	move $a2, $t2
	move $a3, $t3
	jal calcula
	j fim
	
calcula:
	add $t0, $a0, $a1
	add $t1, $a2, $a3
	sub $t0, $t0, $t1
	
	li $v0, 4
	la $a0, output
	syscall
        li $v0, 1              
        move $a0, $t0         
        syscall                
	
	la $t1, F
	sw $t0, 0($t1)
	jr $ra
	
fim:
	nop
	