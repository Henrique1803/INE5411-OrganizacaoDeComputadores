.text
	li $t0, 4
	li $t1, 10
	move $a0, $t0
	move $a1, $t1
	jal calc
	move $t2, $v0
	li $v0, 1
	move $a0, $t2
	syscall
	j fim
	
calc:
	add $v0, $a0, $a1
	jr $ra
	
fim:	nop