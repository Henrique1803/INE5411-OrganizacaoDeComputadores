.data
	vetor: .word 0 0 0 0 0 0
.text
	la $s0, vetor
	li $t0, 0
	mul $t1, $t0, 4
	add $t1, $t1, $s0
	li $t2, 1
	sw $t2, 0($t1)
	
	addi $t0, $t0, 1
	mul $t1, $t0, 4
	add $t1, $t1, $s0
	li $t2, 3
	sw $t2, 0($t1)
	
	addi $t0, $t0, 1
	mul $t1, $t0, 4
	add $t1, $t1, $s0
	li $t2, 2
	sw $t2, 0($t1)