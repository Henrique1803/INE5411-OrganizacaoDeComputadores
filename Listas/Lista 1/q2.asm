.text
	li $t0, 1
	li $t1, 5
	
laco:
	beq $t0, $t1, fim
	add $t2, $t2, $t0
	addi $t0, $t0, 1
	j laco
fim:
	nop
