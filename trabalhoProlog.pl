% Mochilas
mochila(amarela).
mochila(azul).
mochila(branca).
mochila(verde).
mochila(vermelha).

% Nomes
nome(denis).
nome(joao).
nome(lenin).
nome(otavio).
nome(will).

% Meses
mes(agosto).
mes(dezembro).
mes(janeiro).
mes(maio).
mes(setembro).

% Jogos
jogo(toumais).
jogo(cpalavras).
jogo(cubo).
jogo(forca).
jogo(logica).

% Matérias
materia(biologia).
materia(geografia).
materia(historia).
materia(matematica).
materia(portugues).

% Sucos
suco(laranja).
suco(limao).
suco(maracuja).
suco(morango).
suco(uva).

% Auxiliar
alldifferent([]).
alldifferent([H|T]) :-
    \+(member(H, T)),
    alldifferent(T).

% Imprimir lista
imprime_lista([]) :- write('\n\n FIM do imprime_lista \n').

imprime_lista([(Mochila, Nome, Mes, Jogo, Materia, Suco)|T]) :-
    format('Mochila: ~w | Nome: ~w | Mês: ~w | Jogo: ~w | Matéria: ~w | Suco: ~w~n',
           [Mochila, Nome, Mes, Jogo, Materia, Suco]),
    imprime_lista(T).
main :-
    statistics(cputime, L1),
    (modelo(Solucao) ->
        statistics(cputime, L2),
        write('Solução encontrada entre '), write(L1), write(' a '), write(L2), write(' ms:'), nl,
        imprime_lista(Solucao)
    ;
        write('Nenhuma solução encontrada.')
    ).

% Predicado modelo
modelo(Solucao) :-
    % Estrutura da solução
    Solucao = [
    (Mochila_1, Nome_1, Mes_1, Jogo_1, Materia_1, Suco_1),
    (Mochila_2, Nome_2, Mes_2, Jogo_2, Materia_2, Suco_2),
    (Mochila_3, Nome_3, Mes_3, Jogo_3, Materia_3, Suco_3),
    (Mochila_4, Nome_4, Mes_4, Jogo_4, Materia_4, Suco_4),
    (Mochila_5, Nome_5, Mes_5, Jogo_5, Materia_5, Suco_5)
       ],

    % Definição de domínios
    mochila(Mochila_1), nome(Nome_1), mes(Mes_1), jogo(Jogo_1), materia(Materia_1), suco(Suco_1),
    mochila(Mochila_2), nome(Nome_2), mes(Mes_2), jogo(Jogo_2), materia(Materia_2), suco(Suco_2),
    mochila(Mochila_3), nome(Nome_3), mes(Mes_3), jogo(Jogo_3), materia(Materia_3), suco(Suco_3),
    mochila(Mochila_4), nome(Nome_4), mes(Mes_4), jogo(Jogo_4), materia(Materia_4), suco(Suco_4),
    mochila(Mochila_5), nome(Nome_5), mes(Mes_5), jogo(Jogo_5), materia(Materia_5), suco(Suco_5),

    % Definindo a restrição de valores distintos
    alldifferent([Mochila_1, Mochila_2, Mochila_3, Mochila_4, Mochila_5]),
    alldifferent([Nome_1, Nome_2, Nome_3, Nome_4, Nome_5]),
    alldifferent([Mes_1, Mes_2, Mes_3, Mes_4, Mes_5]),
    alldifferent([Jogo_1, Jogo_2, Jogo_3, Jogo_4, Jogo_5]),
    alldifferent([Materia_1, Materia_2, Materia_3, Materia_4, Materia_5]),
    alldifferent([Suco_1, Suco_2, Suco_3, Suco_4, Suco_5]),


    % Restrições específicas do problema
    ( Nome_5 == lenin ),
    ( Nome_1 == otavio ),
    ( Suco_3 == morango ),
    ( Jogo_3 == forca ),
    ( Suco_1 == limao  ),

    ( Materia_3 == biologia  ),

    % Restrições específicas
    % Em uma das pontas está o menino que adora jogar Cubo Vermelho.
    (
         Jogo_1 == cubo;
         Jogo_5 == cubo
    ),

    % Quem gosta de Matemática gosta também de suco de Maracujá.
    Materia_3 \= matematica,
    Materia_1 \= matematica,
    (
        (Materia_2 == matematica, Suco_2 == maracuja) ;
        (Materia_4 == matematica, Suco_4 == maracuja) ;
        (Materia_5 == matematica, Suco_5 == maracuja)
    ),

    % O garoto que nasceu em setembro está ao lado de quem gosta de jogar Cubo Vermelho.
    (
        (Mes_1 == setembro, Jogo_2 == cubo) ;
        (Mes_3 == setembro, (Jogo_2 == cubo ; Jogo_4 == cubo)) ;
        (Mes_4 == setembro, (Jogo_3 == cubo ; Jogo_5 == cubo)) ;
        (Mes_5 == setembro, Jogo_4 == cubo)
    ),

    % O dono da mochila Azul nasceu em janeiro.
    (
        (Mochila_1 == azul, Mes_1 == janeiro) ;
        (Mochila_2 == azul, Mes_2 == janeiro) ;
        (Mochila_3 == azul, Mes_3 == janeiro) ;
        (Mochila_4 == azul, Mes_4 == janeiro) ;
        (Mochila_5 == azul, Mes_5 == janeiro)
    ),

    % Quem curte Problemas de Lógica está ao lado do menino da mochila Amarela.
    (
        (Jogo_2 == logica, (Mochila_1 == amarela ; Mochila_3 == amarela)) ;
        (Jogo_4 == logica, (Mochila_3 == amarela ; Mochila_5 == amarela)) ;
        (Jogo_5 == logica, Mochila_4 == amarela)
    ),

    % Relações de vizinhança
    (
        (Mes_1 == setembro, Suco_2 == laranja) ;
        (Mes_3 == setembro, (Suco_2 == laranja ; Suco_4 == laranja)) ;
        (Mes_4 == setembro, Suco_5 == laranja) ;
        (Mes_5 == setembro, Suco_4 == laranja)
    ),

    % O garoto da mochila Azul está em algum lugar à esquerda de quem nasceu em maio.
    (
        (Mochila_1 == azul, (Mes_2 == maio ; Mes_3 == maio ; Mes_4 == maio ; Mes_5 == maio)) ;
        (Mochila_2 == azul, (Mes_3 == maio ; Mes_4 == maio ; Mes_5 == maio)) ;
        (Mochila_3 == azul, (Mes_4 == maio ; Mes_5 == maio)) ;
        (Mochila_4 == azul, Mes_5 == maio)
    ),

    % Will está ao lado do menino que gosta de Problemas de Lógica.
    (
        (Nome_2 == will, Jogo_1 == logica) ;
        (Nome_3 == will, (Jogo_2 == logica ; Jogo_4 == logica)) ;
        (Nome_4 == will, Jogo_5 == logica)
    ),

    % O garoto da mochila Branca está exatamente à esquerda de Will.
    (
        (Nome_2 == will, Mochila_3 == branca) ;
        (Nome_3 == will, Mochila_4 == branca) ;
        (Nome_4 == will, Mochila_5 == branca)
    ),

    % O garoto que gosta do Jogo da Forca(Pos = 3) está ao lado do que gosta do 3 ou Mais.
    (Jogo_3 == forca, (Jogo_2 == toumais ; Jogo_4 == toumais)),

    % O menino que gosta de suco de Uva está em algum lugar à direita do garoto da mochila Azul.
    (
        (Mochila_1 == azul, (Suco_2 == uva ; Suco_4 == uva ; Suco_5 == uva)) ;
        (Mochila_2 == azul, (Suco_4 == uva ; Suco_5 == uva)) ;
        (Mochila_3 == azul, (Suco_4 == uva ; Suco_5 == uva)) ;
        (Mochila_4 == azul, Suco_5 == uva)
    ),

    % Quem gosta do Jogo da Forca está ao lado do dono da mochila Vermelha
    (Mochila_2 == vermelha ; Mochila_4 == vermelha),

    % O menino que gosta de Matemática nasceu em dezembro.
    (
        (Materia_2 == matematica, Mes_2 == dezembro) ;
        (Materia_4 == matematica, Mes_4 == dezembro) ;
        (Materia_5 == matematica, Mes_5 == dezembro)
    ),

    % Quem gosta de suco de Uva está exatamente à esquerda de quem gosta de Português.
    (
        (Suco_2 == uva, Materia_3 == portugues) ;
        (Suco_4 == uva, Materia_5 == portugues)
    ),

    % O menino que nasceu em janeiro está ao lado de quem nasceu em Setembro.
    (
        (Mes_1 == setembro, Mes_2 == janeiro) ;
        (Mes_3 == setembro, (Mes_2 == janeiro ; Mes_4 == janeiro)) ;
        (Mes_4 == setembro, (Mes_3 == janeiro ; Mes_5 == janeiro)) ;
        (Mes_5 == setembro, Mes_4 == janeiro)
    ),

    % João gosta de história
    (
        (Nome_2 == joao, Materia_2 == historia) ;
        (Nome_3 == joao, Materia_3 == historia) ;
        (Nome_4 == joao, Materia_4 == historia)
    ),

    % Quem gosta de suco de Uva gosta de Problemas de Lógica.
    (
        (Suco_2 == uva, Jogo_2 == logica) ;
        (Suco_4 == uva, Jogo_4 == logica) ;
        (Suco_5 == uva, Jogo_5 == logica)
    ),

    label([Mochila_1, Mochila_2, Mochila_3, Mochila_4, Mochila_5]),
    label([Nome_1, Nome_2, Nome_3, Nome_4, Nome_5]),
    label([Mes_1, Mes_2, Mes_3, Mes_4, Mes_5]),
    label([Jogo_1, Jogo_2, Jogo_3, Jogo_4, Jogo_5]),
    label([Materia_1, Materia_2, Materia_3, Materia_4, Materia_5]),
    label([Suco_1, Suco_2, Suco_3, Suco_4, Suco_5]).








