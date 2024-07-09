.data
	string_input_n: .asciiz "insira o tamanho dos vetores N: "
	string_input_a: .asciiz "digite os valores do vetor A: \n"
	string_input_b: .asciiz "digite os valores do vetor B: \n"
	string_output_a: .asciiz "\nMédia de A: "
	string_output_b: .asciiz "\nMédia de B: "

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
	
	li $t0, 0		   # contador do loop
laco_A:
	bge $t0, $s0, fim_laco_A
	
	li $v0, 6	 	   # seta a operação de leitura de float 
	syscall			   # salva por padrão em $f0	
	
	add.s $f2, $f2, $f0
	addi $t0, $t0, 1
	
	j laco_A
	
fim_laco_A:
	mtc1 $s0, $f1        	# Move o valor inteiro de $s0 para $f1
        cvt.s.w $f1, $f1    	# Converte o valor de inteiro para float
        
    	div.s $f2, $f2, $f1
	
	li $v0, 4	 	   # seta a operação de impressão de string
	la $a0, string_input_b	   # passa um ponteiro que aponta para string_input_b para $a0
	syscall
	
	li $t0, 0		   # contador do loop
laco_B:
	bge $t0, $s0, fim_laco_B
	
	li $v0, 6	 	   # seta a operação de leitura de float 
	syscall			   # salva por padrão em $f0	
	
	add.s $f3, $f3, $f0
	addi $t1, $t1, 4
	addi $t0, $t0, 1
	
	j laco_B
	
fim_laco_B:

	div.s $f3, $f3, $f1
	
	li $v0, 4	 	   # seta a operação de impressão de string
	la $a0, string_output_a	   # passa um ponteiro que aponta para string_output_a para $a0
	syscall
	
	li $v0, 2	 	   # seta a operação de impressão de float
	mov.s $f12, $f2	          
	syscall
	
	li $v0, 4	 	   # seta a operação de impressão de string
	la $a0, string_output_b	   # passa um ponteiro que aponta para string_output_b para $a0
	syscall
	
	li $v0, 2	 	   # seta a operação de impressão de float
	mov.s $f12, $f3	          
	syscall