% explain.pl: Impressão da trilha das regras
% Explicar, ao término, por que chegou ao resultado 

% Recebe o resultado final e imprime a trilha
explicar(resultado(status(S), balanco(B), acao_sugerida(A))) :-
    % Recupera os fatos básicos da memória
    obs(setor(Setor)),
    obs(emissoes_anuais(E)),
    obs(potencial_reducao(P)),

    % Recalcula os passos intermediários para explicar
    % (Estes são os mesmos predicados de rules.pl)
    limite_setor(L),
    reducao_viavel(V),

    % Imprimir quais regras/condições contribuíram [cite: 181]
    format("~n[Explicacao da Analise]~n"),
    format("- Setor informado: ~w~n", [Setor]),
    format("- FATO: Limite base para '~w' e: ~w tCO2e~n", [Setor, L]),
    format("- FATO: Emissoes anuais informadas: ~w tCO2e~n", [E]),
    format("- REGRA (Balanço = Emissões - Limite): ~w - ~w = ~w tCO2e~n", [E, L, B]),
    format("- REGRA (Status): Balanço ~w tCO2e -> Status: ~w~n", [B, S]),
    format("- FATO: Potencial de reducao interna: ~w tCO2e~n", [P]),
    format("- REGRA (Viabilidade): Custo interno < Custo mercado? -> ~w~n", [V]),
    format("- REGRA (Recomendação): Status '~w' + Viabilidade '~w' -> Ação: ~w~n", [S, V, A]).