% main.pl: menu + orquestração do fluxo
% Carrega todos os módulos
:- ["kb.pl","rules.pl","ui.pl","explain.pl"].

% Ponto de entrada do sistema
start :-
    banner,
    menu.

% Mostra o banner inicial
banner :-
    format("~n=== Sistema Especialista - Análise de Mercado de Carbono ===~n"),
    % Adicionar o nome dos desenvolvedores [cite: 185]
    format("Desenvolvido por: [Seu Nome Aqui] (@SeuGithub)~n~n").

% Controla o menu principal 
menu :-
    format("1) Executar analise de carbono~n2) Sair~n> "),
    read(Opt),
    ( Opt = 1 -> run_case, cleanup, menu % Limpa obs/1 apos o caso
    ; Opt = 2 -> format("Saindo...~n")   %
    ; format("Opcao invalida.~n"), menu ). %

% Executa um ciclo de consulta
run_case :-
    coletar_observacoes, % de ui.pl
    ( meta(Result) ->   % de rules.pl
        format("~n--- ANÁLISE CONCLUÍDA ---~n"),
        explicar(Result), % de explain.pl [cite: 187]
        format("~nRESULTADO: ~w~n", [Result]) % Imprime resultado [cite: 187]
    ; format("~nNao foi possivel concluir a analise. Revise as respostas.~n") % [cite: 176]
    ),
    true.