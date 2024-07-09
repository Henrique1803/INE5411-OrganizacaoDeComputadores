.data #dados que ser�o utilizados no programa
	a: .word 0
	b: .word 0
	c: .word 0
	d: .word 75
	e: .word 15
	string: .asciiz "Digite o valor de b: "
	string_result: .asciiz "O resultado de c �: "

.text #�rea de instru��es que ser�o utilizados no programa
	la $s0, a 		# carrega o endere�o de a no reg $s0
	la $s1, b 		# carrega o endere�o de b no reg $s1
	la $s2, c  		# salva o end de c em $s2
	la $s3, d 		# salva o end de d em $s3
	la $s4, e 		# salva o end de e em $s4
	
	li $v0, 4 		# seta a opera��o de impress�o de string
	la $a0, string 		# passa o end da string (ponteiro para string) para $a0
	syscall 		# faz a impress�o da string
	
	li $v0, 5		# seta a opera��o de leitura de int via console
	syscall			# faz a leitura via console
	move $t0, $v0		# passa o conte�do lido armazenado em $v0 para $t0
	sw $t0, 0($s1) 		# pasas o conte�do de $t0 para ser armazenado em b
	
	addi $t1, $t0, 35 	# adiciona em $t1 o resultado de b + 35
	sw $t1, 0($s0) 		# salva o resultado da opera��o em a
	
	lw $t2, 0($s3) 		# carrega o conte�do de d em $t2
	lw $t3, 0($s4) 		# carrega o conte�do de e em $t3
	
	sub $t4, $t2, $t1 	# faz a sub de d - a e salva em $t4
	add $t4, $t4, $t3 	# faz a soma de (d-a) + e e salva em $t4
	sw $t4, 0($s2) 		# salva o resultado da opera��o em c
	
	li $v0, 4		# seta a opera��o de impress�o de string
	la $a0, string_result	# carrega o end de string_result para $a0
	syscall 		# imprime string_result no console
	
	li $v0, 1		# seta a opera��o de impress�o de int
	move $a0, $t4		# passa o conte�do de $t4 (resultado da opera��o) para $a0
	syscall			#imprime o resultado final salvo em c		