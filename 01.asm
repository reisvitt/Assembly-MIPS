#************************************************************
# Autor: Vitor Reis
# Funcao: Função que retorna a quantidade de caracteres de 
#         uma frase digitada pelo usuário.
# Data: 23 de setembro de 2019
#************************************************************

.data
    A: .asciiz "Digite uma frase: "
    B: .asciiz "A quantidade de caracteres ma frase digitada é: "

.text
.globl main

main: 

    la $a0, A #carrega A
    li $v0, 4 #Exibe A na tela
    syscall

    li $v0, 8 #input
    syscall

    li $t0, 0 #index

    j while

while:
    add $t2, $a0, $t0 # $t2 recebe o endereco de memoria referente ao $a0 + #t0(index)
    lb $t1, 0($t2) #recebe o valor que esta na memoria da posicao $t2
    beq $t1, $zero, final # verifica se eh o ultimo elemento
    addi $t0,$t0, 1 #incrementa index
    j while

final:

    la $a0, B # exibe msg
    li $v0, 4
    syscall

    addi $t0, $t0, -1 
    li $v0, 1
    move $a0, $t0 #exibe quantidade de caracteres = (index - 1)
    syscall

    li $v0, 10 #exit
    syscall