% Problema de Eisten
% Cores
cor(amarela).
cor(azul).
cor(branca).
cor(verde).
cor(vermelha).

% Nacionalidade
nacionalidade(alemao).
nacionalidade(dinamarques).
nacionalidade(ingles).
nacionalidade(noruegues).
nacionalidade(sueco).

% Bebidas

bebida(agua).
bebida(cafe).
bebida(cha).
bebida(cerveja).
bebida(leite).

% Cigarro
cigarro(blends).
cigarro(bluemaster).
cigarro(dunhill).
cigarro(pallmall).
cigarro(prince).

% Animal
animal(cachorros).
animal(cavalos).
animal(gatos).
animal(passaros).
animal(peixes).

member(X, Lista).

Casa = (Cor, Nacionalidade, Bebida, Cigarro, Animal),
    Casas = [C1, C2, C3, C4, C5],

% Predicados auxiliares

ao_lado(A, B, Lista) :-
    nextto(A, B, Lista);
    nextto(B, A, Lista).
% Extrai e verifica se os elementos são únicos
cores_diferentes(Casas) :-
    findall(Cor, member((Cor, _, _, _, _), Casas), Cores),
    alldifferent(Cores).

nacionalidades_diferentes(Casas) :-
    findall(Nac, member((_, Nac, _, _, _), Casas), Nacs),
    alldifferent(Nacs).

bebidas_diferentes(Casas) :-
    findall(Beb, member((_, _, Beb, _, _), Casas), Bebs),
    alldifferent(Bebs).

cigarros_diferentes(Casas) :-
    findall(Cig, member((_, _, _, Cig, _), Casas), Cigs),
    alldifferent(Cigs).

animais_diferentes(Casas) :-
    findall(An, member((_, _, _, _, An), Casas), Ans),
    alldifferent(Ans).

% Garante que todos os elementos são diferentes
alldifferent([]).
alldifferent([H|T]) :- \+ member(H, T), alldifferent(T).

% Definindo o modelo principal
main :-
    statistics(cputime, T1),
    modelo(Casas),
    imprime_lista(Casas),
    statistics(cputime, T2),
    Tempo is T2 - T1,
    format('\nTempo total: ~10f msec\n', Tempo).

% Imprime cada casa com visual agradável
imprime_lista([]) :-
    write('\nFIM das casas\n').

imprime_lista([(Cor, Nac, Beb, Cigarro, Animal)|T]) :-
    format('\nCasa: ~w, ~w, ~w, ~w, ~w', [Cor, Nac, Beb, Cigarro, Animal]),
    imprime_lista(T).

% Modelo com as regras do problema
modelo(Casas) :-
    Casas = [_, _, _, _, _],  % Garante que são 5 casas

    % Cada casa tem: (Cor, Nacionalidade, Bebida, Cigarro, Animal)
    Casas = [_, _, (_, _, leite, _, _), _, _],  % Leite na casa do meio

    member((vermelha, ingles, _, _, _), Casas),    % Inglês na casa vermelha
    member((_, sueco, _, _, cachorros), Casas),    % Sueco tem cachorros
    member((_, dinamarques, cha, _, _), Casas),    % Dinamarquês bebe chá
    member((verde, _, cafe, _, _), Casas),         % Verde bebe café
    member((amarela, _, _, dunhill, _), Casas),    % Amarela fuma Dunhill
    member((_, _, cerveja, bluemaster, _), Casas), % Blue Master bebe cerveja
    member((_, alemao, _, prince, _), Casas),      % Alemão fuma Prince
    member((_, _, _, pallmall, passaros), Casas),  % Pall Mall tem pássaros

    % Norueguês na primeira casa
    Casas = [( _, noruegues, _, _, _)|_],

    % A casa azul é vizinha da do norueguês
    ao_lado((azul, _, _, _, _), (_, noruegues, _, _, _), Casas),

    % Casa verde à esquerda da branca
    ao_lado((verde, _, _, _, _), (branca, _, _, _, _), Casas),

    % Blends ao lado de quem tem gatos
    ao_lado((_, _, _, blends, _), (_, _, _, _, gatos), Casas),

    % Blends ao lado de quem bebe água
    ao_lado((_, _, _, blends, _), (_, _, agua, _, _), Casas),

    % Cavalos ao lado de Dunhill
    ao_lado((_, _, _, dunhill, _), (_, _, _, _, cavalos), Casas),

    % Todas categorias têm elementos diferentes
    cores_diferentes(Casas),
    nacionalidades_diferentes(Casas),
    bebidas_diferentes(Casas),
    cigarros_diferentes(Casas),
    animais_diferentes(Casas).
