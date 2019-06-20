algoritmo "algoritmo_logica1"

{*----------------------------------------------------------------------------*}
const
   POSICAO_INICIAL = 1
   POSICAO_FINAL = 6
   BLOQUEADO = " X "
   LIVRE = "   "
   ENTRADA = " E "
   SAIDA = " S "
   OP_BLOQUEAR = 1
   OP_MOSTRAR = 2
   OP_ATRIBUIR_STATUS = 3

{*----------------------------------------------------------------------------*}
var
   tabuleiro : vetor[POSICAO_INICIAL..POSICAO_FINAL,POSICAO_INICIAL..POSICAO_FINAL] de caracter
   enter : caracter

{*----------------------------------------------------------------------------*}
procedimento pecorrerTabuleiro(operacao : inteiro)
var
   linha, coluna : inteiro
   proximaLinha : logico

inicio
   proximaLinha <- verdadeiro
   para linha de POSICAO_INICIAL ate POSICAO_FINAL faca
      para coluna de  POSICAO_INICIAL ate POSICAO_FINAL faca
         escolha(operacao)
         caso OP_BLOQUEAR
            bloquarTodosOsCampos(linha, coluna)
         caso OP_MOSTRAR
            exibirTabuleiro(linha, coluna, proximaLinha)
         caso OP_ATRIBUIR_STATUS
            preencherDeAcordoComMapa(linha,coluna)
         fimescolha
      fimpara
      proximaLinha <- verdadeiro
   fimpara
fimprocedimento

{*----------------------------------------------------------------------------*}
procedimento bloquarTodosOsCampos(linha, coluna : inteiro)
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
funcao campoBloqueado(linha, coluna : inteiro) : logico
inicio
   se(tabuleiro[linha,coluna] = BLOQUEADO) entao
      retorne verdadeiro
   senao
      retorne falso
   fimse
fimfuncao

{*----------------------------------------------------------------------------*}
funcao anteriorDe(indice : inteiro) : inteiro
inicio
   se (ehPrimeira(indice)) entao
      retorne indice;
   senao
      retorne indice - 1;
   fimse
fimfuncao

{*----------------------------------------------------------------------------*}
procedimento desenharLinhas(linha : inteiro)
var
   coluna: inteiro

inicio
   para coluna de POSICAO_INICIAL ate POSICAO_FINAL faca
      se (campoBloqueado(linha,coluna) ou campoBloqueado(anteriorDe(linha),coluna)) entao
         escreva("+---")
      senao
         escreva("+   ")
      fimse
   fimpara
   escreval("+")
fimprocedimento

{*----------------------------------------------------------------------------*}
procedimento desenharDivisoria(linha, coluna : inteiro; ultimaDivisoria : logico)
inicio
      se campoBloqueado(linha,coluna) ou campoBloqueado(linha,anteriorDe(coluna)) ou ultimaDivisoria ou ehPrimeira(coluna) entao
         escreva("|")
      senao
         escreva(" ")
      fimse
fimprocedimento

{*----------------------------------------------------------------------------*}
funcao ehUltima(indice : inteiro) : logico
inicio
   se indice = POSICAO_FINAL entao
      retorne verdadeiro
   senao
      retorne falso
   fimse
fimfuncao

{*----------------------------------------------------------------------------*}
funcao ehPrimeira(indice : inteiro) : logico
inicio
   se indice = POSICAO_INICIAL entao
      retorne verdadeiro
   senao
      retorne falso
   fimse
fimfuncao

{*----------------------------------------------------------------------------*}
procedimento exibirTabuleiro(linha, coluna : inteiro; var proximaLinha : logico)
var
   ultimaDivisoria : logico
   
inicio
   ultimaDivisoria <- falso
   se (proximaLinha) entao
      desenharLinhas(linha)
      proximaLinha <- falso
   fimse
   desenharDivisoria(linha, coluna, ultimaDivisoria)
   escreva(tabuleiro[linha,coluna])
   se (ehUltima(coluna)) entao
      ultimaDivisoria <- verdadeiro
      desenharDivisoria(linha,coluna, ultimaDivisoria)
      escreval("")
   fimse
   se (ehUltima(linha)) e (ehUltima(coluna)) entao
      desenharLinhas(linha)
   fimse
fimprocedimento

{*----------------------------------------------------------------------------*}
inicio
   escreval("")
   pecorrerTabuleiro(OP_BLOQUEAR)
   pecorrerTabuleiro(OP_MOSTRAR)
   definirStatusDoCampo(5,1,ENTRADA)
   definirStatusDoCampo(5,6,SAIDA)
   pecorrerTabuleiro(OP_ATRIBUIR_STATUS)
   escreval("Aperte enter para exibir o próximo status do tabuleiro")
   leia(enter)
   pecorrerTabuleiro(OP_MOSTRAR)
fimalgoritmo