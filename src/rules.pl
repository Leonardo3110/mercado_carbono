% rules.pl: Regras e meta/1 (resultado principal)
% Pelo menos 8 regras significativas 

:- dynamic obs/1. % Para acessar os fatos de ui.pl

% --- Meta Principal ---
% O resultado principal será uma estrutura:
% resultado(status(S), balanco(B), acao_sugerida(A))
meta(resultado(status(S), balanco(B), acao_sugerida(A))) :-
    status(S),
    balanco(B),
    acao_sugerida(A).

/* ===== Derivações (Regras Intermediárias) ===== */

% Fatos observados (o que o usuário digitou)
setor(S) :- obs(setor(S)).
emissoes(E) :- obs(emissoes_anuais(E)).
potencial_reducao(P) :- obs(potencial_reducao(P)).

% === Regra 1: Obter limite de emissão por setor ===
limite_setor(L) :-
    setor(S),
    limite_emissao(S, L), !. % Usa a kb.pl

% === Regra 2: Limite padrão (fallback) ===
% Se o setor digitado não está na kb.pl
limite_setor(10000) :-
    \+ (setor(S), limite_emissao(S, _)).

% === Regra 3: Calcular balanço (Déficit/Superávit) ===
% Balanço = Emissões - Limite.
% Positivo = Déficit (emitiu mais que o limite)
% Negativo = Superávit (emitiu menos que o limite)
balanco(B) :-
    emissoes(E),
    limite_setor(L),
    B is E - L.

% === Regras 4, 5, 6: Determinar status (Classificação) ===
status(deficit) :- balanco(B), B > 100, !.  % Regra 4: Déficit claro
status(superavit) :- balanco(B), B < -100, !. % Regra 5: Superávit claro
status(neutro).                                % Regra 6: Neutro (fallback)

% === Regras 7, 8: Determinar viabilidade da redução interna ===
% É mais barato reduzir internamente do que comprar créditos?
reducao_viavel(sim) :-
    potencial_reducao(P), P > 0,          % Regra 7
    custo_reducao_interno(CustoRed),      % da kb.pl
    preco_medio_credito(CustoCompra),     % da kb.pl
    CustoRed < CustoCompra, !.

reducao_viavel(nao).                         % Regra 8 (fallback)

/* ===== Regras de Recomendação (Resultado Principal)  ===== */

% === Regra 9: Déficit alto, redução viável -> Investir ===
acao_sugerida(investir_reducao) :-
    status(deficit),
    reducao_viavel(sim), !.

% === Regra 10: Déficit (qualquer), redução não viável -> Comprar ===
acao_sugerida(comprar_creditos) :-
    status(deficit),
    reducao_viavel(nao), !.

% === Regra 11: Superávit -> Vender ===
acao_sugerida(vender_creditos) :-
    status(superavit), !.

% === Regra 12: Neutro -> Monitorar ===
acao_sugerida(monitorar). % Fallback final