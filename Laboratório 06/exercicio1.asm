.data
	string_input_n: .asciiz "insira o tamanho dos vetores N: "
	string_input_a: .asciiz "digite os valores do vetor A: \n"
	string_input_b: .asciiz "digite os valores do vetor B: \n"
	string_output_a: .asciiz "\nM�dia de A: "
	string_output_b: .asciiz "\nM�dia de B: "
	.align 2  
	A: .float
	.align 2
	B: .float
.text
	li $v0, 4	 	   # seta a opera��o de impress�o de string
	la $a0, string_input_n	   # passa um ponteiro que aponta para string_input_n para $a0
	syscall
	
	li $v0, 5	 	   # seta a opera��o de leitura de inteiro 
	syscall
	move $s0, $v0		   # salva em $s0
	
	li $v0, 4	 	   # seta a opera��o de impress�o de string
	la $a0, string_input_a	   # passa um ponteiro que aponta para string_input_a para $a0
	syscall
	
	la $s1, A		   # endere�o de A
	move $t1, $s1
	li $t0, 0		   # contador do loop
laco_A:
	bge $t0, $s0, fim_laco_A
	
	li $v0, 6	 	   # seta a opera��o de leitura de float 
	syscall			   # salva por padr�o em $f0	
	
	s.s $f0, 0($t1)
	addi $t1, $t1, 4
	addi $t0, $t0, 1
	
	j laco_A
	
fim_laco_A:
	
	li $v0, 4	 	   # seta a opera��o de impress�o de string
	la $a0, string_input_b	   # passa um ponteiro que aponta para string_input_b para $a0
	syscall
	
	la $s2, B		   # endere�o de B
	move $t1, $s2		   # move pra $t1 o endere�o de B
	mul $t2, $s0, 4		   # faz o c�lculo do endere�o do vetor B com base no vetor A
	add $t1, $t1, $t2
	move $s2, $t1		   # passa o endere�o do vetor B calculado atrav�s o tamanho do vetor
	li $t0, 0		   # contador do loop
laco_B:
	bge $t0, $s0, fim_laco_B
	
	li $v0, 6	 	   # seta a opera��o de leitura de float 
	syscall			   # salva por padr�o em $f0	
	
	s.s $f0, 0($t1)
	addi $t1, $t1, 4
	addi $t0, $t0, 1
	
	j laco_B
	
fim_laco_B:

	li $t0, 0		   # Seta em $t0 o valor de 0, que ser� usado como contador
	move $a0, $s1	           # Passa o endere�o de A como argumento da fun��o
	move $a1, $s0		   # Passa o valor de N para a fun��o
	jal media		   # Chama a fun��o media
	mov.s $f0, $f2		   # Move o valor retornado da m�dia de A para $f0
	sub.s $f2, $f2, $f2	   # Seta o $f2 o valor 0
	
	li $t0, 0	 	   # Seta em $t0 o valor de 0, que ser� usado como contador
	
	move $a0, $s2	           # Passa o endere�o de B como argumento da fun��o
	jal media		   # Chama a fun��o media
	mov.s $f1, $f2		   # Move o valor retornado da m�dia de B para $f1
	
	j exit
	
media:
	# retorno em $f2
	beq $t0, $a1, fim_media
	
	l.s $f3, 0($a0)		  # Carega o elemento ai para $f3
	add.s $f2, $f2, $f3
	
	addi $a0, $a0, 4
	addi $t0, $t0, 1
	
	j media

fim_media:
	mtc1 $a1, $f4        	# Move o valor inteiro de $a1 para $f4
        cvt.s.w $f4, $f4    	# Converte o valor de inteiro para float

	div.s $f2, $f2, $f4
	
	jr $ra			# termina a fun��o de media
	
exit:
	li $v0, 4	 	   # seta a opera��o de impress�o de string
	la $a0, string_output_a	   # passa um ponteiro que aponta para string_output_a para $a0
	syscall
	
	li $v0, 2	 	   # seta a opera��o de impress�o de float
	mov.s $f12, $f0	          
	syscall
	
	li $v0, 4	 	   # seta a opera��o de impress�o de string
	la $a0, string_output_b	   # passa um ponteiro que aponta para string_output_b para $a0
	syscall
	
	li $v0, 2	 	   # seta a opera��o de impress�o de float
	mov.s $f12, $f1	          
	syscall