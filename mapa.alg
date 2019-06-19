algoritmo "algoritmo_logica1"

{*----------------------------------------------------------------------------*}
const
   POSICAO_INICIAL = 1
   POSICAO_FINAL = 6
   LINHAS = 6
   COLUNAS = 6
   BLOQUEADO = " X "
   LIVRE = "   "
   ENTRADA = " E "
   SAIDA = " S "
   PREENCHER = 1
   MOSTRAR = 2
   ATRIBUIR_STATUS = 3

{*----------------------------------------------------------------------------*}
var
   tabuleiro : vetor[POSICAO_INICIAL..LINHAS,POSICAO_INICIAL..COLUNAS] de caracter
   enter : caracter

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
         caso ATRIBUIR_STATUS
            preencherDeAcordoComMapa(linha,coluna)
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
procedimento preencherDeAcordoComMapa(linha, coluna : inteiro)
var
   preencher : logico
inicio
   preencher <- falso
   escolha(linha)
   caso 2
      se(coluna > 2) e (coluna < 6) entao
         preencher <- verdadeiro
      fimse
   caso 3
      se(coluna > 1) e (coluna < 6) e (coluna <> 4) entao
         preencher <- verdadeiro
      fimse
   caso 4, 5
      se(coluna = 2) ou (coluna = 5) entao
         preencher <- verdadeiro
      fimse
   fimescolha
   se(preencher) entao
      definirStatusDoCampo(linha,coluna,LIVRE)
   fimse
fimprocedimento

{*----------------------------------------------------------------------------*}
procedimento desenharLinhas()
var
   i, j: inteiro
inicio
   para i de 1 ate 6 faca
      escreva("+---")
   fimpara
   escreval("+")
fimprocedimento

{*----------------------------------------------------------------------------*}
procedimento desenharDivisoria()
inicio
   escreva("|")
fimprocedimento

{*----------------------------------------------------------------------------*}
funcao exibirTabuleiro(linha, coluna : inteiro; proximaLinha : logico) : logico
inicio
   se(proximaLinha) entao
      escreval("")
      proximaLinha <- falso
      desenharLinhas()
   fimse
   desenharDivisoria()
   escreva(tabuleiro[linha,coluna])
   se(coluna = 6) entao
      desenharDivisoria()
   fimse
   se(linha = 6) e (coluna = 6) entao
      escreval("")
      desenharLinhas()
   fimse
   retorne proximaLinha
fimfuncao

{*----------------------------------------------------------------------------*}
inicio
   pecorrerTabuleiro(PREENCHER)
   pecorrerTabuleiro(MOSTRAR)
   definirStatusDoCampo(5,1,ENTRADA)
   definirStatusDoCampo(5,6,SAIDA)
   pecorrerTabuleiro(ATRIBUIR_STATUS)
   escreval("Aperte enter para exibir o próximo status do tabuleiro")
   leia(enter)
   pecorrerTabuleiro(MOSTRAR)
fimalgoritmo