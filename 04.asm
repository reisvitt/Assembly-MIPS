#**************************************************************
# Autor: Vitor Reis
# Funcao: Programa que solicita ao usuário uma frase em letras
#         minúsculas e a exibe com letras maiúsculas.
# Data: 23 de setembro de 2019
#**************************************************************

.data
    A: .asciiz "Digite uma frase: "
    output: .space 256 #tamanho maximo da frase eh 256 caracteres

.text
.globl main

main: 

    la $a0, A #carrega A
    li $v0, 4 #Exibe A na tela
    syscall

    li $v0, 8 #input
    syscall

    li $t0, 0

    jal tamanhoDaFrase # salva o tamanho da frase em $t4

    j loop


loop:
    add $t1, $a0, $t0 
    lb $t2, 0($t1)

    beq $t0, $t4, final # se chegar ao tamanho total da frase, chama final


    jal verificarMaiuscula # verifica se o caractere eh minusculo ou qualquer outro caractere que nao preciser ser convertido

    addi $t0, $t0, 1 # incrementa index
    j loop

highCase:
    addi $t2, $t2, -32 # 32 duas casas anterior para o entao caractere em maiusculo
    sb $t2, output($t0) #joga o mesmo valor na String de saida

    jr $ra

#Registradores usado para escrita: $t3, $t4, $t5
tamanhoDaFrase:
    add $t3, $a0, $t4
    lb $t5, 0($t3)
    beq $t5, $zero, finalTamanho
    addi $t4,$t4, 1 #index
    j tamanhoDaFrase

finalTamanho:
    addi $t4,$t4, -1
    jr $ra


verificarMaiuscula:
    li $t3 96 #(valor da primeira letra minuscula na tabela ascii) - 1
    
    slt $s0, $t3, $t2 #$t2 eh o valor em ascii do caractere. se $t3 for menor que $t2, logo o caractere em $t2 eh minusculo

    beq $s0, $zero jaMaiuscula #se menor ou igual a 96, eh maiuscula ou qualquer outro caractere
    
    li $t3 123 #(valor da ultima letra minuscula na tabela ascii) + 1
    slt $s0, $t2, $t3 #caractere eh menor que 123, logo eh minuscula
    beq $s0, $zero jaMaiuscula #se maior ou igual a 123 eh qualquer outro caractere que nao precisa ser convertido

    j highCase

jaMaiuscula:
    sb $t2, output($t0) #joga o mesmo valor na String de saida
    addi $t0, $t0, 1 #passa para o proximo caractere
    j loop #chama label


final:

    la $a0, output #exibe String
    li $v0, 4
    syscall

    li $v0, 10 #exit
    syscall
