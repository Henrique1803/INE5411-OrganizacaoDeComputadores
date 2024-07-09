.data 
	A: .word 10
	B: .word 15
	C: .word 20
	D: .word 25
	E: .word 30
	F: .word 35
	G: .word 0 0 0 0
	H: .word 0 0 0 0
	
.text
	la $s0, A
	la $s1, B
	la $s2, C
	la $s3, D
	la $s4, E
	la $s5, F
	la $s6, G
	la $s7, H
	
	lw $t0, 0($s0) #A
	lw $t1, 0($s1) #B
	lw $t2, 0($s2) #C
	lw $t3, 0($s3) #D
	lw $t4, 0($s4) #E
	lw $t5, 0($s5) #F
# a)
	add $t6, $t1, $t2
	sub $t6, $t0, $t6
	add $t6, $t6, $t5
	sw $t6, 0($s6) #10
	
# b)
	sub $t6, $t0, $t1
	sub $t7, $t1, $t2
	mul $t6, $t6, $t7
	sub $t6, $t4, $t6
	sw $t6, 4($s6) #5
	
# c)
	lw $t6, 4($s6)
	sub $t6, $t6, $t2
	sw $t6, 8($s6) #-15

# d)
	lw $t6, 8($s6)
	lw $t7, 0($s6)
	add $t6, $t6, $t7
	sw $t6, 12($s6) #-5

# e)
	sub $t6, $t1, $t2
	sw $t6, 0($s7) #-5
# f)
	add $t6, $t0, $t2
	sw $t6, 0($s7) #30

	
	
	
	
	
	
	
	
	
	
	