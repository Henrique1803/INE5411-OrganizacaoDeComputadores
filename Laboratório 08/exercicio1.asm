.data
	MAX: .word 4    # É possível alterar este valor para definir o tamanho da matriz
	A: .space 64    # Aloca espaço para a matriz A (matriz 4x4, 4 bytes cada) -> 4x4x4 bytes
	B: .space 64    # Aloca espaço para a matriz B (matriz 4x4, 4 bytes cada) -> 4x4x4 bytes
.text
	la $s0, MAX            	# Carrega o endereço de MAX
    	lw $s0, 0($s0)         	# Carrega o valor de MAX em $s0
	li $t0, 0		# contador do primeiro loop (i)
	li $t1, 0		# contador do segundo loop (j)
	li $t3, 0		# endereço a ser acessado na matriz A
	li $t4, 0		# endereço a ser acessado na matriz B
	la $s1, A		# endereço base da matriz A
	la $s2, B		# Endereço base da matriz B

# ---------------------------- Leitura da Matriz A ----------------------------------------------------
	li $t4, 1
laco_linha_leitura_A:
	li $t1, 0			# Inicializa j com 0
	bge $t0, $s0, fim_laco_linha_leitura_A 	# se (i >= MAX) sai do loop
	
laco_coluna_leitura_A:
	bge $t1, $s0, fim_laco_coluna_leitura_A	# se (j >= MAX) sai do loop
	
	mul $t3, $t0, $s0		# t3 = i * MAX
	add $t3, $t1, $t3		# t3 = i * MAX + j
	mul $t3, $t3, 4			# t3 = (i * MAX + j) * 4
	add $t3, $s1, $t3		# Endereço de A[i][j]

	sw $t4, 0($t3)			# A[i][j] = t4
	
	addi $t4, $t4, 1
	addi $t1, $t1, 1
	
	j laco_coluna_leitura_A
	
fim_laco_coluna_leitura_A:
	
	addi $t0, $t0, 1
	
	j laco_linha_leitura_A
	
fim_laco_linha_leitura_A:

# ---------------------------- Leitura da Matriz B ----------------------------------------------------

	li $t0, 0		# contador do primeiro loop (i)
	li $t1, 0		# contador do segundo loop (j)

	li $t4, 1

laco_linha_leitura_B:
	li $t1, 0			# Inicializa j com 0
	bge $t0, $s0, fim_laco_linha_leitura_B 	# se (i >= MAX) sai do loop
	
laco_coluna_leitura_B:
	bge $t1, $s0, fim_laco_coluna_leitura_B	# se (j >= MAX) sai do loop
	
	mul $t3, $t0, $s0		# t3 = i * MAX
	add $t3, $t1, $t3		# t3 = i * MAX + j
	mul $t3, $t3, 4			# t3 = (i * MAX + j) * 4
	add $t3, $s2, $t3		# Endereço de b[i][j]

	sw $t4, 0($t3)			# B[i][j] = t4
	
	addi $t4, $t4, 1
	addi $t1, $t1, 1
	
	j laco_coluna_leitura_B
	
fim_laco_coluna_leitura_B:
	
	addi $t0, $t0, 1
	
	j laco_linha_leitura_B
	
fim_laco_linha_leitura_B:
	li $t4, 0

# ---------------------------- Cálculo da soma -----------------------------------------------
	li $t0, 0		# contador do primeiro loop (i)
	li $t1, 0		# contador do segundo loop (j)
	
laco_linha:
	li $t1, 0			# Inicializa j com 0
	bge $t0, $s0, fim_laco_linha 	# se (i >= MAX) sai do loop
	
laco_coluna:
	bge $t1, $s0, fim_laco_coluna	# se (j >= MAX) sai do loop
	
	mul $t3, $t0, $s0		# t3 = i * MAX
	add $t3, $t1, $t3		# t3 = i * MAX + j
	mul $t3, $t3, 4			# t3 = (i * MAX + j) * 4
	add $t3, $s1, $t3		# Endereço de A[i][j]
	
	mul $t4, $t1, $s0		# t4 = j * MAX
	add $t4, $t0, $t4		# t4 = j * MAX + i
	mul $t4, $t4, 4			# t4 = (j * MAX + i) * 4
	add $t4, $s2, $t4		# Endereço de B[j][i]
	
	lw $t5, 0($t3)			# t5 = A[i][j]
	lw $t6, 0($t4)			# t6 = B[j][i]
	add $t5, $t5, $t6		# t5 = A[i][j] + B[j][i]
	
	sw $t5, 0($t3)			# A[i][j] = t5

	addi $t1, $t1, 1
	
	j laco_coluna
	
fim_laco_coluna:
	
	addi $t0, $t0, 1
	j laco_linha
	
fim_laco_linha:
	nop
