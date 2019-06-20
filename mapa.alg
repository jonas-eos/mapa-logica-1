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
{* TODO: Avaliar se pode melhorar este bloco de subrotina *}
procedimento pecorrerTabuleiro(operacao : inteiro)
var
   linha, coluna : inteiro
   proximaLinha : logico

inicio
   proximaLinha <- verdadeiro
   para linha de POSICAO_INICIAL ate LINHAS faca
      para coluna de  POSICAO_INICIAL ate COLUNAS faca
         se coluna = 6 entao
         fimse
         escolha(operacao)
         caso PREENCHER
            preencherComX(linha, coluna)
         caso MOSTRAR
            exibirTabuleiro(linha, coluna, proximaLinha)
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
{* TODO: Avaliar possibilidade de adicionar constantes *}
{* TODO: Avaliar possibilidade de eliminar codigo repetido *}
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
{* TODO: Adicionar constantes *}
{* TODO: Criar subrotina para avaliar se é primeiraLinha *}
{* TODO: Eliminar código repetido *}
procedimento desenharLinhas(linha : inteiro)
var
   coluna: inteiro
inicio
   para coluna de 1 ate 6 faca
      se(ehPrimeiraOuUltimaLinha(linha)) entao
         escreva("+---")
      senao
         se(tabuleiro[linha,coluna] = BLOQUEADO) ou (tabuleiro[linha - 1,coluna] = BLOQUEADO) entao
            escreva("+---")
         senao
            escreva("+   ")
         fimse
      fimse
   fimpara
   escreval("+")
fimprocedimento

{*----------------------------------------------------------------------------*}
{* TODO: Adicionar constantes *}
{* TODO: Eliminar Código repetido *}
{* TODO: Criar sub-rotina para validar se é ultima coluna *}
{* TODO: O código ainda pode ser melhorado *}
procedimento desenharDivisoria(linha, coluna : inteiro; ultimaDivisoria : logico)
inicio
   se(ultimaDivisoria) ou (coluna = 1) entao
      escreva("|")
   senao
      se(tabuleiro[linha,coluna] = BLOQUEADO) ou (tabuleiro[linha,coluna - 1] = BLOQUEADO) entao
         escreva("|")
      senao
         escreva(" ")
      fimse
   fimse
fimprocedimento

{* --------------------------------------------------------------------------{*}
{* TODO: reavaliar código para velhorar *}
funcao ehPrimeiraOuUltimaLinha(linha : inteiro) : logico
inicio
   se ((linha = POSICAO_INICIAL) ou (linha = POSICAO_FINAL)) entao
      retorne verdadeiro
   senao
      retorne falso
   fimse
fimfuncao

{*----------------------------------------------------------------------------*}
{* TODO: Reavaliar melhorias para este bloco *}
procedimento exibirTabuleiro(linha, coluna : inteiro; var proximaLinha : logico)
inicio
   se (proximaLinha) entao
      desenharLinhas(linha)
      proximaLinha <- falso
   fimse
   desenharDivisoria(linha, coluna, falso)
   escreva(tabuleiro[linha,coluna])
   se (coluna  = 6 ) entao
      desenharDivisoria(linha,coluna, verdadeiro)
      escreval("")
   fimse
   se (linha = 6) e (coluna = 6) entao
      desenharLinhas(linha)
   fimse
fimprocedimento

{*----------------------------------------------------------------------------*}
{* TODO: Adicionar constantes *}
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