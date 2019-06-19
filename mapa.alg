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

{*----------------------------------------------------------------------------*}
var
   tabuleiro : vetor[POSICAO_INICIAL..LINHAS,POSICAO_INICIAL..COLUNAS] de string

{*----------------------------------------------------------------------------*}
procedimento preencherComX()
var
   linha, coluna : inteiro

inicio
   para linha de POSICAO_INICIAL ate LINHAS faca
      para coluna de  POSICAO_INICIAL ate COLUNAS faca
         tabuleiro[linha,coluna] <- BLOQUEADO
      fimpara
   fimpara
fimprocedimento

{*----------------------------------------------------------------------------*}
{* b) Crie uma função que receba os parâmetros da posição e do caracter a ser prenchido: [ E ] , [   ] ou  [ S ]. *}
{* TODO: *}
procedimento definirStatusDoCampo(linha, coluna : inteiro; status : caracter)
inicio
   tabuleiro[linha,coluna] <- status
fimprocedimento

{*----------------------------------------------------------------------------*}
inicio

fimalgoritmo