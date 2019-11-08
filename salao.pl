/*
=======================
=== Salao de Beleza ===
=======================
https://rachacuca.com.br/logica/problemas/salao-de-beleza/
Author: Robson Zagre Júnior
Data: 7/11/19
*/

/*
==================
=== Predicados ===
==================
*/


%Bolsa
bolsa(amarela).
bolsa(azul).
bolsa(branca).
bolsa(verde).
bolsa(vermelha).

%Gentilico
gentilico(gaucha).
gentilico(baiana).
gentilico(fluminense).
gentilico(mineira).
gentilico(paulista).

%Suco
suco(abacaxi).
suco(laranja).
suco(limao).
suco(maracuja).
suco(morango).

%Nome
nome(ana).
nome(claudia).
nome(mariana).
nome(tina).
nome(vivian).

%Profissao
profissao(advogada).
profissao(cozinheira).
profissao(dentista).
profissao(publicitaria).
profissao(tradutora).

%Fazer
fazer(alisar).
fazer(cortar).
fazer(maquiagem).
fazer(manicure).
fazer(tingir).

/*
==============
=== Regras ===
==============
*/

% X se encontra a esquerda de Y na Lista
aEsquerda(X, Y, Lista) :- nth0(IndexX, Lista, X),
                          nth0(IndexY, Lista, Y),
                          IndexX < IndexY.

% X e o item anterior a Y na Lista
exatamenteAEsquerda(X, Y, Lista) :- nextto(X, Y, Lista).

% X se encontra a direita de Y na Lista
aDireita(X, Y, Lista) :- aEsquerda(Y, X, Lista).

% X e o item posterior a Y na Lista
exatamenteADireita(X, Y, Lista) :- exatamenteAEsquerda(Y, X, Lista).

% X esta ao lado de Y na lista (Direita ou Esquerda)
aoLado(X, Y, Lista) :- nextto(X, Y, Lista); nextto(Y, X, Lista).

% X e o primeiro elemento da Lista
primeiraPosicao(X, [X|_]).

% X e o ultimo elemento da Lista
ultimaPosicao(X, Lista) :- last(Lista, X).

% X ou e o primeiro ou e o ultimo elemento da Lista
naPonta(X, Lista) :- primeiraPosicao(X, Lista); ultimaPosicao(X, Lista).

% Todos os elementos da lista sao diferentes
todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H, T)), todosDiferentes(T).

/*
===========================
=== Solucao do problema ===
===========================
*/

solucao(ListaSolucao) :-
    ListaSolucao = [
        cadeira(Bolsa1, Gentilico1, Suco1, Nome1, Profissao1, Fazer1),
        cadeira(Bolsa2, Gentilico2, Suco2, Nome2, Profissao2, Fazer2),
        cadeira(Bolsa3, Gentilico3, Suco3, Nome3, Profissao3, Fazer3),
        cadeira(Bolsa4, Gentilico4, Suco4, Nome4, Profissao4, Fazer4),
        cadeira(Bolsa5, Gentilico5, Suco5, Nome5, Profissao5, Fazer5)
    ],

    /*
    ============================
    === Regras Exigidas para ===
    ===     solucionar       ===
    ===          o           ===
    ===      problema        ===
    ============================
    */

    %A mulher que vai Tingir os cabelos está exatamente à esquerda da Cláudia.
    exatamenteAEsquerda(cadeira(_,_,_,_,_,tingir), cadeira(_,_,_,claudia,_,_), ListaSolucao),

    %A moça que está no meio vai Alisar os cabelos.
    Fazer3 = alisar,

    %Quem vai Cortar os cabelos está em algum lugar entre a Fluminense
    % e a que tem a bolsa Vermelha, que está à direita.
    aDireita(cadeira(_,_,_,_,_,cortar), cadeira(_,fluminense,_,_,_,_), ListaSolucao),
    aEsquerda(cadeira(_,_,_,_,_,cortar), cadeira(vermelha,_,_,_,_,_), ListaSolucao),

    %Quem vai fazer Maquiagem está na primeira cadeira.
    Fazer1 = maquiagem,

    %A Paulista está sentada exatamente à esquerda da Publicitária.
    exatamenteAEsquerda(cadeira(_,paulista,_,_,_,_),cadeira(_,_,_,_,publicitaria,_),ListaSolucao),

    %A Mariana trabalha como Tradutora.
    member(cadeira(_,_,_,mariana,tradutora,_), ListaSolucao),

    %A Dentista está sentada na quarta cadeira.
    Profissao4 = dentista,

    %A Cozinheira está sentada ao lado da Mineira.
    aoLado(cadeira(_,_,_,_,cozinheira,_), cadeira(_,mineira,_,_,_,_), ListaSolucao),

    %A Ana está exatamente à direita da mulher que veio fazer Maquiagem.
    exatamenteADireita(cadeira(_,_,_,ana,_,_), cadeira(_,_,_,_,_,maquiagem), ListaSolucao),

    %Tina está sentada em uma das pontas.
    naPonta(cadeira(_,_,_,tina,_,_), ListaSolucao),

    %A Paulista adora Limonada
    member(cadeira(_,paulista,limao,_,_,_), ListaSolucao),

    %A dona da bolsa Vermelha está sentada em algum lugar à esquerda da
    % que bebe suco de Morango.
    aEsquerda(cadeira(vermelha,_,_,_,_,_), cadeira(_,_,morango,_,_,_), ListaSolucao),

    %Quem bebe suco de Laranja está na segunda cadeira.
    Suco2 = laranja,

    %A dona da bolsa Verde está sentada ao lado de quem bebe suco de Maracujá.
    aoLado(cadeira(verde,_,_,_,_,_), cadeira(_,_,maracuja,_,_,_), ListaSolucao),

    %A Mineira está sentada exatamente à direita da dona da bolsa Branca.
    exatamenteADireita(cadeira(_,mineira,_,_,_,_), cadeira(branca,_,_,_,_,_),ListaSolucao),

    %A Sul-rio-grandense adora suco de Morango.
    member(cadeira(_,gaucha,morango,_,_,_), ListaSolucao),

    %A Advogada está sentada ao lado da mulher que veio Cortar os cabelos.
    aoLado(cadeira(_,_,_,_,advogada,_), cadeira(_,_,_,_,_,cortar), ListaSolucao),

    %A dona da bolsa Amarela está sentada exatamente à esquerda da dona da bolsa Branca.
    exatamenteAEsquerda(cadeira(amarela,_,_,_,_,_), cadeira(branca,_,_,_,_,_), ListaSolucao),

    /*
    =========================
    ===  Atribui Valores  ===
    ===         e         ===
    === Limita Repeticoes ===
    =========================
    */

    %Bolsa
    bolsa(Bolsa1), bolsa(Bolsa2), bolsa(Bolsa3), bolsa(Bolsa4), bolsa(Bolsa5),
    todosDiferentes([Bolsa1, Bolsa2, Bolsa3, Bolsa4, Bolsa5]),

    %Gentilico
    gentilico(Gentilico1), gentilico(Gentilico2), gentilico(Gentilico3), gentilico(Gentilico4), gentilico(Gentilico5),
    todosDiferentes([Gentilico1, Gentilico2, Gentilico3, Gentilico4, Gentilico5]),

    %Suco
    suco(Suco1), suco(Suco2), suco(Suco3), suco(Suco4), suco(Suco5),
    todosDiferentes([Suco1, Suco2, Suco3, Suco4, Suco5]),

    %Nome
    nome(Nome1), nome(Nome2), nome(Nome3), nome(Nome4), nome(Nome5),
    todosDiferentes([Nome1, Nome2, Nome3, Nome4, Nome5]),

    %Profissao
    profissao(Profissao1), profissao(Profissao2), profissao(Profissao3), profissao(Profissao4), profissao(Profissao5),
    todosDiferentes([Profissao1, Profissao2, Profissao3, Profissao4, Profissao5]),

    %Fazer
    fazer(Fazer1), fazer(Fazer2), fazer(Fazer3), fazer(Fazer4), fazer(Fazer5),
    todosDiferentes([Fazer1, Fazer2, Fazer3, Fazer4, Fazer5]).
