% ui.pl: Perguntas e assert das observações
% Coletar dados do usuário por perguntas guiadas 

:- dynamic obs/1. % Fatos dinâmicos

% Predicado genérico para perguntas Sim/Não
% Adaptação do exemplo [cite: 93]
pergunta(Campo, Texto) :-
    format("~w (s/n) ", [Texto]),
    read(Ans0),
    downcase_atom(Ans0, Ans),
    ( Ans == s ->
        Term =.. [Campo, sim],
        assertz(obs(Term))
    ; Ans == n ->
        Term =.. [Campo, nao],
        assertz(obs(Term))
    ; format("Entrada invalida. Digite s ou n.~n"),
      pergunta(Campo, Texto)
    ).

% Predicado genérico para perguntas numéricas
pergunta_num(Campo, Texto) :-
    format("~w ", [Texto]),
    read(N),
    ( number(N), N >= 0 ->
        Term =.. [Campo, N],
        assertz(obs(Term))
    ; format("Entrada invalida. Digite um numero >= 0.~n"),
      pergunta_num(Campo, Texto)
    ).

% Coleta todas as observações necessárias para a análise
coletar_observacoes :-
    format("Qual o setor da empresa (industria_pesada/tecnologia/agro/servicos)? "),
    read(Setor),
    assertz(obs(setor(Setor))),

    pergunta_num(emissoes_anuais, "Emissoes anuais (em tCO2e)?"),
    pergunta_num(potencial_reducao, "Potencial de reducao interna (em tCO2e)?"),

    % Esta pergunta não será usada nas regras abaixo,
    % mas é um exemplo de como tratar incerteza/ausência de dados
    pergunta(possui_projeto_credito, "A empresa ja possui projetos de credito?").

% Limpa os fatos dinâmicos para a próxima execução 
cleanup :- retractall(obs(_)).