// Descri��o:
// - preenche um tabuleiro tamanho NxY com X (campo bloqueado)
//    em seguida mostra o tabuleiro bloqueado para o usu�rio
//    depois, preenche o tabuleiro com um determinado status
//    em seguida mostra novamente o tabuleiro com o seu estado atual
// Autor: @jonas-eos
// Data: 06/24/2019
algoritmo algoritmo_logica1

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
// Descri��o:
// - percorrer todo o tabuleiro com uma determinada opera��o
// Par�metro:
// - operacao: determina qual opera��o ser� realizada durante o processo que
//    percorrer� todo a matriz
// Depend�ncia:
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
   proximaLinha : l�gico

In�cio
   proximaLinha <- verdadeiro
   para linha de POSICAO_INICIAL at� POSICAO_FINAL fa�a
      para coluna de  POSICAO_INICIAL at� POSICAO_FINAL fa�a
         caso(operacao)

         {* Bloqueio *}
         seja OP_BLOQUEAR fa�a
            bloquarTodosOsCampos(linha, coluna)
            
         {* Mostrar tabuleiro *}
         seja OP_MOSTRAR fa�a
            exibirTabuleiro(linha, coluna, proximaLinha)
            
         {* Atribuir status *}
         seja OP_ATRIBUIR_STATUS fa�a
            preencherDeAcordoComMapa(linha,coluna)
         fim_caso
      fim_para        // colunas
      proximaLinha <- verdadeiro
   fim_para        // linhas
fim_procedimento

{*----------------------------------------------------------------------------*}
// Descri��o:
// - bloqueia um determinado campo do tabuleiro
// Par�metros:
// - linha, coluna: Posi��o onde o tabuleiro ser� bloqueado
// Depend�ncia:
// - @const BLOQUEADO
// - @var-global tabuleiro[]
procedimento bloquarTodosOsCampos(linha, coluna : inteiro)
In�cio
   tabuleiro[linha, coluna] <- BLOQUEADO
fim_procedimento

{*----------------------------------------------------------------------------*}
// Descri��o:
// - altera o status de um determinado campo do tabuleiro
// Par�metros:
// - linha, coluna: Posi��o onde o tabuleiro sofrer� altera��o
// - status: o status para qual o campo ser� alterado
// Depend�ncia:
// @var-global tabuleiro[]
procedimento definirStatusDoCampo(linha, coluna : inteiro; status : caracter)
In�cio
   tabuleiro[linha,coluna] <- status
fim_procedimento

{*----------------------------------------------------------------------------*}
// Descri��o:
// - altera os status dos campos do tabuleiro de acordo com a imagem do MAPA
// Par�metros:
// - linha, coluna: Posi��o onde o tabuleiro sofrer� altera��o
// Depend�ncia:
// @method definirStatusDoCampo
// @const LIVRE
procedimento preencherDeAcordoComMapa(linha, coluna : inteiro)
var
   preencher : l�gico
   
In�cio
   preencher <- falso
   caso(linha)
   seja 2 fa�a
      se(coluna > 2) e (coluna < 6) ent�o
         preencher <- verdadeiro
      fimse
   seja 3 fa�a
      se(coluna > 1) e (coluna < 6) e (coluna <> 4) ent�o
         preencher <- verdadeiro
      fimse
   seja 4, 5 fa�a
      se(coluna = 2) ou (coluna = 5) ent�o
         preencher <- verdadeiro
      fimse
   fim_caso
   se(preencher) ent�o
      definirStatusDoCampo(linha,coluna,LIVRE)
   fimse
fim_procedimento

{*----------------------------------------------------------------------------*}
// Descri��o:
// - verificar se o campo informado esta bloqueado
// Par�metros:
// - linha, coluna: Posi��o onde ser� feito a verifica��o
// Depend�ncia:
// @const BLOQUEADO
// @var-global tabuleiro[]
fun��o campoBloqueado(linha, coluna : inteiro) : l�gico
In�cio
   se(tabuleiro[linha,coluna] = BLOQUEADO) ent�o
      retorne verdadeiro
   sen�o
      retorne falso
   fimse
fim_funcao

{*----------------------------------------------------------------------------*}
// Descri��o:
// - retorna a posi��o do �ndice anterior, seja n�o seja o primeiro �ndice
// Par�metros:
// - �ndice: posi��o onde ser� usado para retornar a posi��o anterior
// Depend�ncia:
// @method ehPrimeira
fun��o anteriorDe(indice : inteiro) : inteiro
In�cio
   se (ehPrimeira(indice)) ent�o
      retorne indice;
   sen�o
      retorne indice - 1;
   fimse
fim_funcao

{*----------------------------------------------------------------------------*}
// Descri��o:
// - desenha as linhas na tela seja o campo atual informado e o campo anterior
//    estejam bloqueados
// Par�metros:
// - linha: posi��o onde o curso da tela est� presente
// Depend�ncia:
// @const POSICAO_INICIAL
// @const POSICAO_FINAL
// @method campoBloqueado
// @method anteriorDe
procedimento desenharLinhas(linha : inteiro)
var
   coluna: inteiro

In�cio
   para coluna de POSICAO_INICIAL at� POSICAO_FINAL fa�a
      se (campoBloqueado(linha,coluna) ou campoBloqueado(anteriorDe(linha),coluna)) ent�o
         escreva("+---")
      sen�o
         escreva("+   ")
      fimse
   fim_para
   escreval("+")
fim_procedimento

{*----------------------------------------------------------------------------*}
// Descri��o:
// - desenha divis�ria entre as colunas na tela
// Par�metros:
// - linha, coluna: posi��o onde ser� desenhado a divis�ria
// - ultimaDivisoria: se for verdadeiro a divis�ria ser� obritatoriamente desenhada
// Depend�ncia:
// @method campoBloqueado
// @method anteriorDe
// @method ehPrimeira
procedimento desenharDivisoria(linha, coluna : inteiro; ultimaDivisoria : l�gico)
In�cio
      se campoBloqueado(linha,coluna) ou campoBloqueado(linha,anteriorDe(coluna)) ou ultimaDivisoria ou ehPrimeira(coluna) ent�o
         escreva("|")
      sen�o
         escreva(" ")
      fimse
fim_procedimento

{*----------------------------------------------------------------------------*}
// Descri��o:
// - retorna verdadeiro se for o �ltimo �ndice
// Par�metros:
// - �ndice: posi��o que ser� analisado
// Depend�ncia:
// @const POSICAO_FINAL
fun��o ehUltima(indice : inteiro) : l�gico
In�cio
   se indice = POSICAO_FINAL ent�o
      retorne verdadeiro
   sen�o
      retorne falso
   fimse
fim_funcao

{*----------------------------------------------------------------------------*}
// Descri��o:
// - retorna se � primeiro �ndice
// Par�metros:
// - �ndice: posi��o que ser� analisado
// Depend�ncia:
// @const POSICAO_INICIAL
fun��o ehPrimeira(indice : inteiro) : l�gico
In�cio
   se indice = POSICAO_INICIAL ent�o
      retorne verdadeiro
   sen�o
      retorne falso
   fimse
fim_funcao

{*----------------------------------------------------------------------------*}
//Descri��o:
// - desenha o tabuleiro na tela com auxilio das divis�rias e das linhas separadoras
// Par�metros:
// - linha, coluna: posi��o do tabuleiro que ser� desenhado na tela, ser� usado
//    tamb�m como guia para desenhar os separadores
// - proximaLinha(referencia): usado como guia se a posi��o esta na pr�xima linha
//    por este par�metro, ser� obrigat�rio o desenho das linhas
// Depend�ncia:
// @method desenharLinhas
// @method desenharDivisoria
// @method ehUltima
// @var-global tabuleiro[]
procedimento exibirTabuleiro(linha, coluna : inteiro; var proximaLinha : l�gico)
var
   ultimaDivisoria : l�gico
   
In�cio
   ultimaDivisoria <- falso
   se (proximaLinha) ent�o
      desenharLinhas(linha)
      proximaLinha <- falso
   fim_se       // proxima linha
   desenharDivisoria(linha, coluna, ultimaDivisoria)
   escreva(tabuleiro[linha,coluna])
   se (ehUltima(coluna)) ent�o
      ultimaDivisoria <- verdadeiro
      desenharDivisoria(linha,coluna, ultimaDivisoria)
      escreval("")
   fim_se       // se for ultima coluna
   se (ehUltima(linha)) e (ehUltima(coluna)) ent�o
      desenharLinhas(linha)
   fim_se       // se for ultima linha ou coluna
fim_procedimento

{*----------------------------------------------------------------------------*}
// Programa principal
In�cio
   escreval("")
   pecorrerTabuleiro(OP_BLOQUEAR)
   pecorrerTabuleiro(OP_MOSTRAR)
   definirStatusDoCampo(5,1,ENTRADA)
   definirStatusDoCampo(5,6,SAIDA)
   pecorrerTabuleiro(OP_ATRIBUIR_STATUS)
   escreval("Aperte enter para exibir o pr�ximo status do tabuleiro")
   leia(enter)
   pecorrerTabuleiro(OP_MOSTRAR)
fim.