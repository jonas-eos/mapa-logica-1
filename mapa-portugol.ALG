// Descrição:
// - preenche um tabuleiro tamanho NxY com X (campo bloqueado)
//    em seguida mostra o tabuleiro bloqueado para o usuário
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
   proximaLinha : lógico

Início
   proximaLinha <- verdadeiro
   para linha de POSICAO_INICIAL até POSICAO_FINAL faça
      para coluna de  POSICAO_INICIAL até POSICAO_FINAL faça
         caso(operacao)

         {* Bloqueio *}
         seja OP_BLOQUEAR faça
            bloquarTodosOsCampos(linha, coluna)
            
         {* Mostrar tabuleiro *}
         seja OP_MOSTRAR faça
            exibirTabuleiro(linha, coluna, proximaLinha)
            
         {* Atribuir status *}
         seja OP_ATRIBUIR_STATUS faça
            preencherDeAcordoComMapa(linha,coluna)
         fim_caso
      fim_para        // colunas
      proximaLinha <- verdadeiro
   fim_para        // linhas
fim_procedimento

{*----------------------------------------------------------------------------*}
// Descrição:
// - bloqueia um determinado campo do tabuleiro
// Parâmetros:
// - linha, coluna: Posição onde o tabuleiro será bloqueado
// Dependência:
// - @const BLOQUEADO
// - @var-global tabuleiro[]
procedimento bloquarTodosOsCampos(linha, coluna : inteiro)
Início
   tabuleiro[linha, coluna] <- BLOQUEADO
fim_procedimento

{*----------------------------------------------------------------------------*}
// Descrição:
// - altera o status de um determinado campo do tabuleiro
// Parâmetros:
// - linha, coluna: Posição onde o tabuleiro sofrerá alteração
// - status: o status para qual o campo será alterado
// Dependência:
// @var-global tabuleiro[]
procedimento definirStatusDoCampo(linha, coluna : inteiro; status : caracter)
Início
   tabuleiro[linha,coluna] <- status
fim_procedimento

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
   preencher : lógico
   
Início
   preencher <- falso
   caso(linha)
   seja 2 faça
      se(coluna > 2) e (coluna < 6) então
         preencher <- verdadeiro
      fimse
   seja 3 faça
      se(coluna > 1) e (coluna < 6) e (coluna <> 4) então
         preencher <- verdadeiro
      fimse
   seja 4, 5 faça
      se(coluna = 2) ou (coluna = 5) então
         preencher <- verdadeiro
      fimse
   fim_caso
   se(preencher) então
      definirStatusDoCampo(linha,coluna,LIVRE)
   fimse
fim_procedimento

{*----------------------------------------------------------------------------*}
// Descrição:
// - verificar se o campo informado esta bloqueado
// Parâmetros:
// - linha, coluna: Posição onde será feito a verificação
// Dependência:
// @const BLOQUEADO
// @var-global tabuleiro[]
função campoBloqueado(linha, coluna : inteiro) : lógico
Início
   se(tabuleiro[linha,coluna] = BLOQUEADO) então
      retorne verdadeiro
   senão
      retorne falso
   fimse
fim_funcao

{*----------------------------------------------------------------------------*}
// Descrição:
// - retorna a posição do índice anterior, seja não seja o primeiro índice
// Parâmetros:
// - índice: posição onde será usado para retornar a posição anterior
// Dependência:
// @method ehPrimeira
função anteriorDe(indice : inteiro) : inteiro
Início
   se (ehPrimeira(indice)) então
      retorne indice;
   senão
      retorne indice - 1;
   fimse
fim_funcao

{*----------------------------------------------------------------------------*}
// Descrição:
// - desenha as linhas na tela seja o campo atual informado e o campo anterior
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

Início
   para coluna de POSICAO_INICIAL até POSICAO_FINAL faça
      se (campoBloqueado(linha,coluna) ou campoBloqueado(anteriorDe(linha),coluna)) então
         escreva("+---")
      senão
         escreva("+   ")
      fimse
   fim_para
   escreval("+")
fim_procedimento

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
procedimento desenharDivisoria(linha, coluna : inteiro; ultimaDivisoria : lógico)
Início
      se campoBloqueado(linha,coluna) ou campoBloqueado(linha,anteriorDe(coluna)) ou ultimaDivisoria ou ehPrimeira(coluna) então
         escreva("|")
      senão
         escreva(" ")
      fimse
fim_procedimento

{*----------------------------------------------------------------------------*}
// Descrição:
// - retorna verdadeiro se for o último índice
// Parâmetros:
// - índice: posição que será analisado
// Dependência:
// @const POSICAO_FINAL
função ehUltima(indice : inteiro) : lógico
Início
   se indice = POSICAO_FINAL então
      retorne verdadeiro
   senão
      retorne falso
   fimse
fim_funcao

{*----------------------------------------------------------------------------*}
// Descrição:
// - retorna se é primeiro índice
// Parâmetros:
// - índice: posição que será analisado
// Dependência:
// @const POSICAO_INICIAL
função ehPrimeira(indice : inteiro) : lógico
Início
   se indice = POSICAO_INICIAL então
      retorne verdadeiro
   senão
      retorne falso
   fimse
fim_funcao

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
procedimento exibirTabuleiro(linha, coluna : inteiro; var proximaLinha : lógico)
var
   ultimaDivisoria : lógico
   
Início
   ultimaDivisoria <- falso
   se (proximaLinha) então
      desenharLinhas(linha)
      proximaLinha <- falso
   fim_se       // proxima linha
   desenharDivisoria(linha, coluna, ultimaDivisoria)
   escreva(tabuleiro[linha,coluna])
   se (ehUltima(coluna)) então
      ultimaDivisoria <- verdadeiro
      desenharDivisoria(linha,coluna, ultimaDivisoria)
      escreval("")
   fim_se       // se for ultima coluna
   se (ehUltima(linha)) e (ehUltima(coluna)) então
      desenharLinhas(linha)
   fim_se       // se for ultima linha ou coluna
fim_procedimento

{*----------------------------------------------------------------------------*}
// Programa principal
Início
   escreval("")
   pecorrerTabuleiro(OP_BLOQUEAR)
   pecorrerTabuleiro(OP_MOSTRAR)
   definirStatusDoCampo(5,1,ENTRADA)
   definirStatusDoCampo(5,6,SAIDA)
   pecorrerTabuleiro(OP_ATRIBUIR_STATUS)
   escreval("Aperte enter para exibir o próximo status do tabuleiro")
   leia(enter)
   pecorrerTabuleiro(OP_MOSTRAR)
fim.