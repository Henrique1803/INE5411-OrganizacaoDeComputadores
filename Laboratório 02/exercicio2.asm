.text
	li $s0, 0xFFFF0012      # carrega para $s0 o endereço do controlador de linhas do teclado
	li $s1, 0xFFFF0014 	# carrega para $s1 o endereço de memória que armazena a informação da tecla pressionada
	li $s2, 0xFFFF0010 	# carrega para $s2 o endereço do display da direita
	
	li $t3, 0		# variável que será utilizada como comparador, para verificar a repetição do clique de um botão
				# e assim, não ficar atualizando o display com o mesmo valor repetidas vezes. Assim, o número não pisca no display
loop_principal:
	li $t0, 0x01      	# bit 0 = 1 -> linha 1 
        sb $t0, 0($s0)    	# linha 1 selecionada(escrevendo em 0xFFFF0012)
        lb $t1, 0($s1)    	# $t1= código da tecla pressionada da linha 1 ($t1=0 se não for pressionada)
        bne $t1, $zero, linha1  # faz a verificação se alguma tecla da linha 1 foi pressionada
        
        li $t0, 0x02	  	# bit 1 = 1 -> linha 2	
        sb $t0, 0($s0)    	# linha 2 selecionada(escrevendo em 0xFFFF0012)
        lb $t1, 0($s1)    	# $t1= código da tecla pressionada da linha 2 ($t1=0 se não for pressionada)
        bne $t1, $zero, linha2  # faz a verificação se alguma tecla da linha 2 foi pressionada
        
        li $t0, 0x04	  	# bit 2 = 1 -> linha 3
	sb $t0, 0($s0)    	# linha 3 selecionada(escrevendo em 0xFFFF0012)
       	lb $t1, 0($s1)    	# $t1= código da tecla pressionada da linha 3 ($t1=0 se não for pressionada)
       	bne $t1, $zero, linha3	# faz a verificação se alguma tecla da linha 3 foi pressionada
        
        li $t0, 0x08	  	# bit 3 = 1 -> linha 4
        sb $t0, 0($s0)    	# linha 4 selecionada(escrevendo em 0xFFFF0012)
        lb $t1, 0($s1)    	# $t1= código da tecla pressionada da linha 4 ($t1=0 se não for pressionada)
        bne $t1, $zero, linha4	# faz a verificação se alguma tecla da linha 4 foi pressionada
        
        j loop_principal
        
linha1:
	beq $t1, $t3, loop_principal	# verifica se a tecla pressionada na iteração atual é a mesma que a da iteração anteriro, se sim, retorna para o loop principal
	move $t3, $t1	  		# salva o valor que foi digitado, para não entrar aqui de novo repetidas vezes
	beq $t1, 17, zero		# verifica se o número da tecla pressionada equivale ao número zero, a partir do código da tecla
	beq $t1, 33, um			# verifica se o número da tecla pressionada equivale ao número um, a partir do código da tecla
	beq $t1, 65, dois		# verifica se o número da tecla pressionada equivale ao número dois, a partir do código da tecla
	beq $t1, -127, tres		# verifica se o número da tecla pressionada equivale ao número tres, a partir do código da tecla
	j loop_principal
       
linha2:
	beq $t1, $t3, loop_principal	# verifica se a tecla pressionada na iteração atual é a mesma que a da iteração anteriro, se sim, retorna para o loop principal
	move $t3, $t1	  		# salva o valor que foi digitado, para não entrar aqui de novo repetidas vezes
	beq $t1, 18, quatro		# verifica se o número da tecla pressionada equivale ao número quatro, a partir do código da tecla
	beq $t1, 34, cinco		# verifica se o número da tecla pressionada equivale ao número cinco, a partir do código da tecla
	beq $t1, 66, seis		# verifica se o número da tecla pressionada equivale ao número seis, a partir do código da tecla
	beq $t1, -126, sete		# verifica se o número da tecla pressionada equivale ao número sete, a partir do código da tecla
	j loop_principal
	
linha3:
	beq $t1, $t3, loop_principal 	# verifica se a tecla pressionada na iteração atual é a mesma que a da iteração anteriro, se sim, retorna para o loop principal
	move $t3, $t1	  		# salva o valor que foi digitado, para não entrar aqui de novo repetidas vezes
	beq $t1, 20, oito		# verifica se o número da tecla pressionada equivale ao número oito, a partir do código da tecla
	beq $t1, 36, nove		# verifica se o número da tecla pressionada equivale ao número novo, a partir do código da tecla
	beq $t1, 68, A			# verifica se o número da tecla pressionada equivale ao número A, a partir do código da tecla
	beq $t1, -124, B		# verifica se o número da tecla pressionada equivale ao número B, a partir do código da tecla
	j loop_principal

linha4:
	beq $t1, $t3, loop_principal	# verifica se a tecla pressionada na iteração atual é a mesma que a da iteração anteriro, se sim, retorna para o loop principal
	move $t3, $t1 			# salva o valor que foi digitado, para não entrar aqui de novo repetidas vezes
	beq $t1, 24, C			# verifica se o número da tecla pressionada equivale ao número C, a partir do código da tecla
	beq $t1, 40, D			# verifica se o número da tecla pressionada equivale ao número D, a partir do código da tecla
	beq $t1, 72, E			# verifica se o número da tecla pressionada equivale ao número E, a partir do código da tecla
	beq $t1, -120, F		# verifica se o número da tecla pressionada equivale ao número F, a partir do código da tecla
	j loop_principal  
	
zero:
	li $t2, 63        #valor do byte para representar o número 0
	sb $t2, 0($s2)    #passa o valor que representa o número 0 para o endereço do display
	j loop_principal
	
um:
	li $t2, 6         #valor do byte para representar o número 1
	sb $t2, 0($s2)    #passa o valor que representa o número 1 para o endereço do display
	j loop_principal
	
dois:
	li $t2, 91        #valor do byte para representar o número 2
	sb $t2, 0($s2)    #passa o valor que representa o número 2 para o endereço do display
	j loop_principal
	
tres:
	li $t2, 79        #valor do byte para representar o número 3
	sb $t2, 0($s2)    #passa o valor que representa o número 3 para o endereço do display
	j loop_principal
	
quatro:
	li $t2, 102	  #valor do byte para representar o número 4
	sb $t2, 0($s2)    #passa o valor que representa o número 4 para o endereço do display
	j loop_principal

cinco:
	li $t2, 109       #valor do byte para representar o número 5
	sb $t2, 0($s2)    #passa o valor que representa o número 5 para o endereço do display
	j loop_principal

seis:
	li $t2, 125       #valor do byte para representar o número 6
	sb $t2, 0($s2)    #passa o valor que representa o número 6 para o endereço do display
	j loop_principal

sete:
	li $t2, 7         #valor do byte para representar o número 7
	sb $t2, 0($s2)    #passa o valor que representa o número 7 para o endereço do display
	j loop_principal

oito:
	li $t2, 127       #valor do byte para representar o número 8
	sb $t2, 0($s2)    #passa o valor que representa o número 8 para o endereço do display
	j loop_principal

nove:
	li $t2, 111        #valor do byte para representar o número 9
	sb $t2, 0($s2)    #passa o valor que representa o número 9 para o endereço do display
	j loop_principal

A:
	li $t2, 119       #valor do byte para representar a letra A
	sb $t2, 0($s2)    #passa o valor que representa a letra A para o endereço do display
	j loop_principal
	
B:
	li $t2, 124       #valor do byte para representar a letra B
	sb $t2, 0($s2)    #passa o valor que representa a letra B para o endereço do display
	j loop_principal

C:
	li $t2, 57        #valor do byte para representar a letra C
	sb $t2, 0($s2)    #passa o valor que representa a letra C para o endereço do display
	j loop_principal

D:
	li $t2, 94        #valor do byte para representar a letra D
	sb $t2, 0($s2)    #passa o valor que representa a letra D para o endereço do display
	j loop_principal

E:
	li $t2, 121       #valor do byte para representar a letra E
	sb $t2, 0($s2)    #passa o valor que representa a letra E para o endereço do display
	j loop_principal
	
F:
	li $t2, 113       #valor do byte para representar a letra F
	sb $t2, 0($s2)    #passa o valor que representa a letra F para o endereço do display
	j loop_principal

	
