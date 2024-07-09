.data
	string_input_x: .asciiz "insira o valor de x: "
	string_input_n: .asciiz "insira o número de termos: "
	string_output: .asciiz "\n o seno do número é: " 
	numMenos1: .double -1.0
	num1: .double 1
.text
	li $v0, 4	 	   # seta a operação de impressão de string
	la $a0, string_input_x	   # passa um ponteiro que aponta para string_input_x para $a0
	syscall
	
	li $v0, 7	 	   # seta a operação de leitura de double 
	syscall			   # salva por padrão em $f0
	
	li $v0, 4	 	   # seta a operação de impressão de string
	la $a0, string_input_n	   # passa um ponteiro que aponta para string_input_n para $a0
	syscall
	
	li $v0, 5	 	   # seta a operação de leitura de inteiro 
	syscall			   
	move $t1, $v0
	
	la $s1, numMenos1
	l.d $f6, 0($s1)            # número -1
	
	move $a1, $t1
	jal  seno
	j exit
	
#--------------------------------------  Seno ----------------------------------

# $f0 = x; $a1, = numero_termos, $f14 = resultado do seno 	
seno:	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	li $t3, 0 # contador
repeticao_seno:
	bge $t3, $a1, fim_funcao_seno
	
	mul $t4, $t3, 2
	addi $t4, $t4, 1
	
	mov.d $f2, $f6
	move $t1, $t3
	jal potenciacao
	mov.d $f8, $f4
	
	mov.d $f2, $f0
	move $t1, $t4
	jal potenciacao
	mul.d $f8, $f8, $f4
	
	mtc1 $t4, $f2
        cvt.d.w $f2, $f2
	jal fatorial
	mov.d $f10, $f4
	
	div.d $f8, $f8, $f10
	
	add.d $f14, $f14, $f8
	
	addi $t3, $t3, 1
	j repeticao_seno
fim_funcao_seno: 
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
#--------------------------------------  Potenciação ----------------------------------
potenciacao:
	# $t1 = expoente, $f2 = base, $f4 = retorno
	la $t9, num1
	l.d $f4, 0($t9)
	
	li $t0, 0 # contador
repeticao_potenciacao:
	bge $t0, $t1, fim_funcao_potenciacao
	mul.d $f4, $f4, $f2
	addi $t0, $t0, 1
	j repeticao_potenciacao
fim_funcao_potenciacao: 
	jr $ra

#--------------------------------------  Fatorial ----------------------------------
	
fatorial:
	# $f2 = número, $f4 = retorno
	
	# Inicializa o fatorial como 1.0
    	la $t9, num1
	l.d $f4, 0($t9)
	
	cvt.w.d $f16, $f2        # Converte o valor de double para inteiro
	mfc1 $t8, $f16           # Move o valor inteiro de $f16 para $t8 (número para calcular o fatorial)

    	li $t1, 1                # Inicializa o contador do loop (i = 1)
loop:
	bgt $t1, $t8, fim_fatorial
	
	mtc1 $t1, $f16        	# Move o valor inteiro de $t1 para $f16
        cvt.d.w $f16, $f16     	# Converte o valor de inteiro para double

    	mul.d $f4, $f4, $f16    # Multiplica o fatorial acumulado por f16
    	addi $t1, $t1, 1        # Incrementa o contador do loop

    	j loop                  # Volta para o início do loop
    	
fim_fatorial:
    	jr $ra

# --------------------------------- Print Resultado ----------------------------------------
exit:	
	li $v0, 4	 	   # seta a operação de impressão de string
	la $a0, string_output	   # passa um ponteiro que aponta para string_result para $a0
	syscall
	
	li $v0, 3	 	   # seta a operação de impressão de double
	mov.d $f12, $f14	          
	syscall
	
