.data
	endereco: .word 0
    	prompt: .asciiz "\nDigite 1 para ligar ou 0 para desligar um bit: "
    	bit_prompt: .asciiz "\nDigite o número do bit (0-31): "
    	output: .asciiz "\nValor após operação: "

.text
main:

        li $v0, 4          
        la $a0, prompt      
        syscall

        # Ler a entrada do usuário (ligar = 1, desligar = 0)
        li $v0, 5          
        syscall
        move $s0, $v0

        li $v0, 4           
        la $a0, bit_prompt 
        syscall

        # Ler a entrada do usuário (número do bit)
        li $v0, 5    
        syscall
        move $s1, $v0 
        
        #t0 é a máscara
        li $t0, 1
        
        li $t8, 0
loop:
	bge $t8, $s1, fim_loop
        sll $t0, $t0, 1
        addi $t8, $t8, 1
        j loop
fim_loop:
	la $s2, endereco
        lw $t1, 0($s2)
	
	beq $s0, $zero, desativar

ativar:
	or $t1, $t1, $t0
	j fim

desativar:
	not $t0, $t0
	and $t1, $t1, $t0
	j fim
	
fim:
	sw $t1, 0($s2)
	
	li $v0, 4
	la $a0, output
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall

	j main
