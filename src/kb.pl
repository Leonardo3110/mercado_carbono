% kb.pl: Fatos, tabelas e domínios do tema.
% Base de conhecimento: fatos, domínios, faixas/tabelas simples do tema. [cite: 178]

% --- Fatos: Limites de Emissão (fictícios) ---
% limite_emissao(Setor, LimiteEmTonsCO2e)
% Define a "cota" de emissão esperada para cada setor.
limite_emissao(industria_pesada, 100000).
limite_emissao(tecnologia, 10000).
limite_emissao(agro, 50000).
limite_emissao(servicos, 5000).

% --- Fatos: Custos (fictícios) ---
% Define os custos médios por tonelada de CO2 equivalente.

% Preco medio de compra de 1 credito de carbono no mercado voluntario.
preco_medio_credito(50).

% Custo medio para a empresa reduzir 1 tonelada de CO2 internamente
% (ex: mudando maquinario, otimizando logistica).
custo_reducao_interno(30).