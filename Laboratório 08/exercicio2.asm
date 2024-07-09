.data
	MAX: .word 4    # É possível alterar este valor para definir o tamanho da matriz
	block_size: .word 2     # É possível alterar este valor para definir o tamanho do bloco da matriz  
	A: .space 64    # Aloca espaço para a matriz A (matriz 4x4, 4 bytes cada) -> 4x4x4 bytes
	B: .space 64    # Aloca espaço para a matriz B (matriz 4x4, 4 bytes cada) -> 4x4x4 bytes

.text
	la $s0, MAX            	# Carrega o endereço de MAX
    	lw $s0, 0($s0)         	# Carrega o valor de MAX em $s0
    	la $s3, block_size	# Carrega o endereço de block_size
    	lw $s3, 0($s3)		# Carrega o valor de block_size em $s3
	li $t0, 0		# contador do primeiro loop (i)
	li $t1, 0		# contador do segundo loop (j)
	li $t6, 0		# endereço a ser acessado na matriz A
	li $t7, 0		# endereço a ser acessado na matriz B
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
	li $t2, 0		# contador do terceiro loop (ii)
	li $t3, 0		# contador do quarto loop (jj)
	li $t4, 0		# comparador i+block_size
	li $t5, 0		# comparador j+block_size

laco_i:
	li $t1, 0		# seta j para 0
	beq $t0, $s0, fim_laco_i  # se i >= MAX sai do loop
	
laco_j:
	move $t2, $t0		# faz ii = i
	
	beq $t1, $s0, fim_laco_j  # se j >= MAX sai do loop
	
laco_ii:
	move $t3, $t1		# faz jj = j
	add $t4, $t0, $s3	# faz i + block_size
	
	beq $t2, $t4, fim_laco_ii  # se ii >= i+block_size sai do loop
	
laco_jj:
	add $t5, $t1, $s3	# faz j + block_size
	
	beq $t3, $t5, fim_laco_jj  # se jj >= j+block_size sai do loop
	
	mul $t6, $t2, $s0	# $t6 = ii * MAX
	add $t6, $t6, $t3	# $t6 = ii * MAX + jj
	mul $t6, $t6, 4		# $t6 = (ii * MAX + jj) * 4
	add $t6, $t6, $s1	# Endereço de A[ii][jj]

	mul $t7, $t3, $s0	# $t7 = jj * MAX
	add $t7, $t7, $t2	# $t7 = jj * MAX + ii
	mul $t7, $t7, 4		# $t7 = (jj * MAX + ii) * 4
	add $t7, $t7, $s2	# Endereço de B[jj][ii]
	
	lw $t8, 0($t6)		# $t8 = A[ii][jj]
	lw $t9, 0($t7)		# $t9 = B[jj][ii]
	add $s4, $t8, $t9	# $s4 = A[ii][jj] + B[jj][ii]
	sw $s4, 0($t6)		# A[ii][jj] = A[ii][jj] + B[jj][ii]

	addi $t3, $t3, 1	# faz jj++
	j laco_jj		# retorna para o laço jj

fim_laco_jj:
	addi $t2, $t2, 1	# faz ii++
	j laco_ii		# retorna para o laço ii	

fim_laco_ii:
	add $t1, $t1, $s3	# faz j += block_size
	j laco_j		# retorna para o laço j
	
fim_laco_j:
	add $t0, $t0, $s3	# i += block_size
	j laco_i		# retorna para o laço i

fim_laco_i:
	nop

	
	
	
	
	
	
	
	
	
	
	
	
