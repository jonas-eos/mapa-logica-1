// Descrição:
// - preenche um tabuleiro tamanho NxY com X (campo bloqueado)
//    em seguida mostra o tabuleiro bloqueado para o usuário
//    depois, preenche o tabuleiro com um determinado status
//    em seguida mostra novamente o tabuleiro com o seu estado atual
// Autor: @jonas-eos
// Data: 06/24/2019
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
// Descrição:
// - percorrer todo o tabuleiro com uma determinada operação
// Parâmetro:
// - operacao: determina qual operação será realizada durante o processo que
//    percorrerá todo a matriz
// Dependência:
// - @const POSICAO_INICIAL
// - @const POSICAL_FINAL
// - @const OP_BLOQUEAR
// - @const OP_MOSTRAR
// - @const OP_ATRIBUIR_STATUS
// - @method bloquearTodosOsCampos
// - @method exibirTabuleiro
// - @method preencherDeAcordoComMapa
procedimento pecorrerTabuleiro(operacao : inteiro)
var
   linha, coluna : inteiro
   proximaLinha : logico

inicio
   proximaLinha <- verdadeiro
   para linha de POSICAO_INICIAL ate POSICAO_FINAL faca
      para coluna de  POSICAO_INICIAL ate POSICAO_FINAL faca
         escolha(operacao)

         {* Bloqueio *}
         caso OP_BLOQUEAR
            bloquarTodosOsCampos(linha, coluna)
            
         {* Mostrar tabuleiro *}
         caso OP_MOSTRAR
            exibirTabuleiro(linha, coluna, proximaLinha)
            
         {* Atribuir status *}
         caso OP_ATRIBUIR_STATUS
            preencherDeAcordoComMapa(linha,coluna)
         fimescolha
      fimpara        // colunas
      proximaLinha <- verdadeiro
   fimpara        // linhas
fimprocedimento

{*----------------------------------------------------------------------------*}
// Descrição:
// - bloqueia um determinado campo do tabuleiro
// Parâmetros:
// - linha, coluna: Posição onde o tabuleiro será bloqueado
// Dependência:
// - @const BLOQUEADO
// - @var-global tabuleiro[]
procedimento bloquarTodosOsCampos(linha, coluna : inteiro)
inicio
   tabuleiro[linha, coluna] <- BLOQUEADO
fimprocedimento

{*----------------------------------------------------------------------------*}
// Descrição:
// - altera o status de um determinado campo do tabuleiro
// Parâmetros:
// - linha, coluna: Posição onde o tabuleiro sofrerá alteração
// - status: o status para qual o campo será alterado
// Dependência:
// @var-global tabuleiro[]
procedimento definirStatusDoCampo(linha, coluna : inteiro; status : caracter)
inicio
   tabuleiro[linha,coluna] <- status
fimprocedimento

{*----------------------------------------------------------------------------*}
// Descrição:
// - altera os status dos campos do tabuleiro de acordo com a imagem do MAPA
// Parâmetros:
// - linha, coluna: Posição onde o tabuleiro sofrerá alteração
// Dependência:
// @method definirStatusDoCampo
// @const LIVRE
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
// Descrição:
// - verificar se o campo informado esta bloqueado
// Parâmetros:
// - linha, coluna: Posição onde será feito a verificação
// Dependência:
// @const BLOQUEADO
// @var-global tabuleiro[]
funcao campoBloqueado(linha, coluna : inteiro) : logico
inicio
   se(tabuleiro[linha,coluna] = BLOQUEADO) entao
      retorne verdadeiro
   senao
      retorne falso
   fimse
fimfuncao

{*----------------------------------------------------------------------------*}
// Descrição:
// - retorna a posição do índice anterior, caso não seja o primeiro índice
// Parâmetros:
// - índice: posição onde será usado para retornar a posição anterior
// Dependência:
// @method ehPrimeira
funcao anteriorDe(indice : inteiro) : inteiro
inicio
   se (ehPrimeira(indice)) entao
      retorne indice;
   senao
      retorne indice - 1;
   fimse
fimfuncao

{*----------------------------------------------------------------------------*}
// Descrição:
// - desenha as linhas na tela caso o campo atual informado e o campo anterior
//    estejam bloqueados
// Parâmetros:
// - linha: posição onde o curso da tela está presente
// Dependência:
// @const POSICAO_INICIAL
// @const POSICAO_FINAL
// @method campoBloqueado
// @method anteriorDe
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
// Descrição:
// - desenha divisória entre as colunas na tela
// Parâmetros:
// - linha, coluna: posição onde será desenhado a divisória
// - ultimaDivisoria: se for verdadeiro a divisória será obritatoriamente desenhada
// Dependência:
// @method campoBloqueado
// @method anteriorDe
// @method ehPrimeira
procedimento desenharDivisoria(linha, coluna : inteiro; ultimaDivisoria : logico)
inicio
      se campoBloqueado(linha,coluna) ou campoBloqueado(linha,anteriorDe(coluna)) ou ultimaDivisoria ou ehPrimeira(coluna) entao
         escreva("|")
      senao
         escreva(" ")
      fimse
fimprocedimento

{*----------------------------------------------------------------------------*}
// Descrição:
// - retorna verdadeiro se for o último índice
// Parâmetros:
// - índice: posição que será analisado
// Dependência:
// @const POSICAO_FINAL
funcao ehUltima(indice : inteiro) : logico
inicio
   se indice = POSICAO_FINAL entao
      retorne verdadeiro
   senao
      retorne falso
   fimse
fimfuncao

{*----------------------------------------------------------------------------*}
// Descrição:
// - retorna se é primeiro índice
// Parâmetros:
// - índice: posição que será analisado
// Dependência:
// @const POSICAO_INICIAL
funcao ehPrimeira(indice : inteiro) : logico
inicio
   se indice = POSICAO_INICIAL entao
      retorne verdadeiro
   senao
      retorne falso
   fimse
fimfuncao

{*----------------------------------------------------------------------------*}
//Descrição:
// - desenha o tabuleiro na tela com auxilio das divisórias e das linhas separadoras
// Parâmetros:
// - linha, coluna: posição do tabuleiro que será desenhado na tela, será usado
//    também como guia para desenhar os separadores
// - proximaLinha(referencia): usado como guia se a posição esta na próxima linha
//    por este parâmetro, será obrigatório o desenho das linhas
// Dependência:
// @method desenharLinhas
// @method desenharDivisoria
// @method ehUltima
// @var-global tabuleiro[]
procedimento exibirTabuleiro(linha, coluna : inteiro; var proximaLinha : logico)
var
   ultimaDivisoria : logico
   
inicio
   ultimaDivisoria <- falso
   se (proximaLinha) entao
      desenharLinhas(linha)
      proximaLinha <- falso
   fimse       // /\ proxima linha
   desenharDivisoria(linha, coluna, ultimaDivisoria)
   escreva(tabuleiro[linha,coluna])
   se (ehUltima(coluna)) entao
      ultimaDivisoria <- verdadeiro
      desenharDivisoria(linha,coluna, ultimaDivisoria)
      escreval("")
   fimse       // /\ se for ultima coluna
   se (ehUltima(linha)) e (ehUltima(coluna)) entao
      desenharLinhas(linha)
   fimse       // /\ se for ultima linha ou coluna
fimprocedimento

{*----------------------------------------------------------------------------*}
// Programa principal
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