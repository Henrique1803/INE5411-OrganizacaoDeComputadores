.data
	input: .asciiz "insira o valor de x: "
	output: .asciiz "o fatorial de x �: "
.text
	li $v0, 4	 	   # seta a opera��o de impress�o de string
	la $a0, input	   	   # passa um ponteiro que aponta para input para $a0
	syscall
	
	li $v0, 5
	syscall	 	   	   # seta a opera��o de leitura de inteiro 
	move $t0, $v0		   # salva em $t0
	
	li $t2, 1
    	li $t1, 1                  # Inicializa o contador do loop (i = 1)
loop:
	bgt $t1, $t0, fim_fatorial

    	mul $t2, $t2, $t1          # Multiplica o fatorial acumulado por $t1
    	addi $t1, $t1, 1           # Incrementa o contador do loop

    	j loop                     # Volta para o in�cio do loop
    	
fim_fatorial:

	li $v0, 4	 	   # seta a opera��o de impress�o de string
	la $a0, output	   	   # passa um ponteiro que aponta para output para $a0
	syscall
	
	li $v0, 1	 	   # seta a opera��o de impress�o de int
	move $a0, $t2	          
	syscall
	
