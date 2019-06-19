algoritmo "algoritmo_logica1"

{*----------------------------------------------------------------------------*}
const
   POSICAO_INICIAL = 1
   POSICAO_FINAL = 6
   LINHAS = 6
   COLUNAS = 6
   BLOQUEADO = "X"
   LIVRE = " "
   ENTRADA = "E"
   SAIDA = "S"
   PREENCHER = 1
   MOSTRAR = 2

{*----------------------------------------------------------------------------*}
var
   tabuleiro : vetor[POSICAO_INICIAL..LINHAS,POSICAO_INICIAL..COLUNAS] de caracter

{*----------------------------------------------------------------------------*}
procedimento pecorrerTabuleiro(operacao : inteiro)
var
   linha, coluna : inteiro
   proximaLinha : logico

inicio
   proximaLinha <- verdadeiro
   para linha de POSICAO_INICIAL ate LINHAS faca
      para coluna de  POSICAO_INICIAL ate COLUNAS faca
         escolha(operacao)
            caso PREENCHER
               preencherComX(linha, coluna)
            caso MOSTRAR
               proximaLinha <- exibirTabuleiro(linha, coluna, proximaLinha)
         fimescolha
      fimpara
      proximaLinha <- verdadeiro
   fimpara
fimprocedimento

{*----------------------------------------------------------------------------*}
procedimento preencherComX(linha, coluna : inteiro)
inicio
   tabuleiro[linha, coluna] <- BLOQUEADO
fimprocedimento

{*----------------------------------------------------------------------------*}
procedimento definirStatusDoCampo(linha, coluna : inteiro; status : caracter)
inicio
   tabuleiro[linha,coluna] <- status
fimprocedimento

{*----------------------------------------------------------------------------*}
funcao exibirTabuleiro(linha, coluna : inteiro; proximaLinha : logico) : logico
inicio
   se(proximaLinha) entao
      escreval("")
      proximaLinha <- falso
   fimse
   escreva(tabuleiro[linha,coluna])
   retorne proximaLinha
fimfuncao

{*----------------------------------------------------------------------------*}
inicio
    pecorrerTabuleiro(PREENCHER)
    pecorrerTabuleiro(MOSTRAR)
fimalgoritmo