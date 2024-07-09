.data #dados que serão utilizados no programa
	a: .word 0
	b: .word 20
	c: .word 0
	d: .word 75
	e: .word 15

.text #área de instruções que serão utilizados no programa
	la $s0, a 		#carrega o endereço de a no reg $s0
	la $s1, b 		#carrega o endereço de b no reg $s1
	la $s2, c  		#salva o end de c em $s2
	la $s3, d 		#salva o end de d em $s3
	la $s4, e 		#salva o end de e em $s4
	
	lw $t0, 0($s1)  	#carrega o conteúdo de b em $t0
	addi $t1, $t0, 35 	#adiciona em $t1 o resultado de $t0 + 35
	sw $t1, 0($s0) 		#salva o resultado da operação em a
	
	lw $t2, 0($s3) 		#carrega o conteúdo de d em $t2
	lw $t3, 0($s4) 		#carrega o conteúdo de e em $t3
	
	sub $t4, $t2, $t1 	#faz a sub de d - a e salva em $t4
	add $t4, $t4, $t3 	#faz a soma de (d-a) + e e salva em $t4
	sw $t4, 0($s2) 		#salva o resultado da operação em c
	
	
	
	