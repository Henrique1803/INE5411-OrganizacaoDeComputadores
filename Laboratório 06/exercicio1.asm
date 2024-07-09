.data
	string_input_n: .asciiz "insira o tamanho dos vetores N: "
	string_input_a: .asciiz "digite os valores do vetor A: \n"
	string_input_b: .asciiz "digite os valores do vetor B: \n"
	string_output_a: .asciiz "\nMédia de A: "
	string_output_b: .asciiz "\nMédia de B: "
	.align 2  
	A: .float
	.align 2
	B: .float
.text
	li $v0, 4	 	   # seta a operação de impressão de string
	la $a0, string_input_n	   # passa um ponteiro que aponta para string_input_n para $a0
	syscall
	
	li $v0, 5	 	   # seta a operação de leitura de inteiro 
	syscall
	move $s0, $v0		   # salva em $s0
	
	li $v0, 4	 	   # seta a operação de impressão de string
	la $a0, string_input_a	   # passa um ponteiro que aponta para string_input_a para $a0
	syscall
	
	la $s1, A		   # endereço de A
	move $t1, $s1
	li $t0, 0		   # contador do loop
laco_A:
	bge $t0, $s0, fim_laco_A
	
	li $v0, 6	 	   # seta a operação de leitura de float 
	syscall			   # salva por padrão em $f0	
	
	s.s $f0, 0($t1)
	addi $t1, $t1, 4
	addi $t0, $t0, 1
	
	j laco_A
	
fim_laco_A:
	
	li $v0, 4	 	   # seta a operação de impressão de string
	la $a0, string_input_b	   # passa um ponteiro que aponta para string_input_b para $a0
	syscall
	
	la $s2, B		   # endereço de B
	move $t1, $s2		   # move pra $t1 o endereço de B
	mul $t2, $s0, 4		   # faz o cálculo do endereço do vetor B com base no vetor A
	add $t1, $t1, $t2
	move $s2, $t1		   # passa o endereço do vetor B calculado através o tamanho do vetor
	li $t0, 0		   # contador do loop
laco_B:
	bge $t0, $s0, fim_laco_B
	
	li $v0, 6	 	   # seta a operação de leitura de float 
	syscall			   # salva por padrão em $f0	
	
	s.s $f0, 0($t1)
	addi $t1, $t1, 4
	addi $t0, $t0, 1
	
	j laco_B
	
fim_laco_B:

	li $t0, 0		   # Seta em $t0 o valor de 0, que será usado como contador
	move $a0, $s1	           # Passa o endereço de A como argumento da função
	move $a1, $s0		   # Passa o valor de N para a função
	jal media		   # Chama a função media
	mov.s $f0, $f2		   # Move o valor retornado da média de A para $f0
	sub.s $f2, $f2, $f2	   # Seta o $f2 o valor 0
	
	li $t0, 0	 	   # Seta em $t0 o valor de 0, que será usado como contador
	
	move $a0, $s2	           # Passa o endereço de B como argumento da função
	jal media		   # Chama a função media
	mov.s $f1, $f2		   # Move o valor retornado da média de B para $f1
	
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
	
	jr $ra			# termina a função de media
	
exit:
	li $v0, 4	 	   # seta a operação de impressão de string
	la $a0, string_output_a	   # passa um ponteiro que aponta para string_output_a para $a0
	syscall
	
	li $v0, 2	 	   # seta a operação de impressão de float
	mov.s $f12, $f0	          
	syscall
	
	li $v0, 4	 	   # seta a operação de impressão de string
	la $a0, string_output_b	   # passa um ponteiro que aponta para string_output_b para $a0
	syscall
	
	li $v0, 2	 	   # seta a operação de impressão de float
	mov.s $f12, $f1	          
	syscall