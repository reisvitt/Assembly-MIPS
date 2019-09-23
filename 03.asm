#*******************************************************************
# Autor: Vitor Reis
# Funcao: Programa que informa quantas letras “A” maiúscula tem uma
#         frase digitada pelo usuário. O programa possui mensagens 
#         como “Digite uma frase: “ e “Quantidade de letras A: “.
# Data: 23 de setembro de 2019
#*******************************************************************

.data
    A: .asciiz "Digite uma frase: "
    B: .asciiz "Quantidade de letras A: "

.text
.globl main

main: 

    la $a0, A #carrega A
    li $v0, 4 #Exibe A na tela
    syscall

    li $v0, 8 #input
    syscall

    li $t0, 0 #index vetor
    li $t4, 0 #qtd letra A

    li $t3, 65 # letra A na tabela ascii

    
    j while

while:
    add $t2, $a0, $t0
    lb $t1, 0($t2)
    beq $t1, $t3, counter
    beq $t1, $zero, final
    addi $t0,$t0, 1 #index
    j while

counter: #incrementa a variavel com a quantidade de letras A's
    addi $t4, $t4, 1
    addi $t0,$t0, 1 #index
    j while 

final:

    la $a0, B
    li $v0, 4
    syscall

    #exibe o numero
    li $v0, 1
    move $a0, $t4
    syscall

    li $v0, 10 #exit
    syscall
