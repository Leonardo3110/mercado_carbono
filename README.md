# 🌳 Sistema Especialista - Análise de Mercado de Carbono

Projeto desenvolvido para a disciplina de **Linguagem de Programação e Paradigmas** (Sistemas de Informação - UNIDAVI), sob orientação do Prof. Esp. Ademar Perfoll Junior.

O objetivo deste projeto é criar um sistema especialista em Prolog que, com base em entradas do usuário, analisa o balanço de carbono de uma empresa e recomenda uma ação estratégica (comprar créditos, vender créditos ou investir em redução interna).

## Integrantes

* **[Leonardo Luis Abelino]** - [@Leonardo3110]
* **(Carlos Eduardo)**

---

## 🏗️ Arquitetura

[cite_start]O projeto segue a arquitetura de 5 arquivos sugerida[cite: 199], onde cada componente tem uma responsabilidade clara:

* [cite_start]`/src/main.pl`: Orquestrador principal, controla o menu e o fluxo de execução[cite: 202].
* `/src/kb.pl`: A Base de Conhecimento (Knowledge Base). [cite_start]Contém os fatos estáticos, como limites de emissão por setor e custos de créditos[cite: 203].
* `/src/rules.pl`: O Cérebro. [cite_start]Contém as regras de negócio (mais de 8 [cite: 179][cite_start]) que inferem o status, balanço e a ação recomendada[cite: 204].
* `/src/ui.pl`: A Interface do Usuário. [cite_start]Responsável por fazer as perguntas e salvar as respostas (fatos dinâmicos)[cite: 205].
* `/src/explain.pl`: O Módulo de Explicação. [cite_start]Reconstrói o raciocínio para justificar o resultado ao usuário[cite: 181, 206].

---

## ⚙️ Como Executar

O sistema é executado usando o **SWI-Prolog**.

### Opção 1: Execução Padrão (Com SWI-Prolog instalado no PATH)

1.  Abra seu terminal (no VS Code ou Prompt de Comando).
2.  Navegue até a pasta raiz do projeto:
    ```bash
    cd caminho/para/mercado_carbono
    ```
3.  Inicie o interpretador SWI-Prolog:
    ```bash
    swipl
    ```
4.  Dentro do Prolog, carregue o arquivo principal:
    ```prolog
    ?- ['src/main.pl'].
    ```
5.  Inicie o sistema:
    ```prolog
    ?- start.
    ```

### Opção 2: Execução com Versão Portátil (Sem instalação)

Se você não possui permissão de administrador, use a versão portátil (arquivo `.zip` do site do SWI-Prolog).

1.  Abra o executável `swipl-win.exe` (que você extraiu do `.zip`).
2.  Dentro do console do Prolog, navegue até a pasta do projeto usando `cd/1`. **Use barras normais (`/`) e termine com ponto (`.`)**:
    ```prolog
    ?- cd('C:/Seu/Caminho/Completo/mercado_carbono').
    ```
3.  Carregue o arquivo principal:
    ```prolog
    ?- ['src/main.pl'].
    ```
4.  Inicie o sistema:
    ```prolog
    ?- start.
    ```

---

## 📊 Exemplo de Entrada e Saída

[cite_start]Este é um exemplo de execução do cenário de uma empresa de tecnologia com déficit de carbono, onde a redução interna é financeiramente viável[cite: 191, 197].

**Entradas (Inputs):**

* Opção do Menu: `1.`
* Setor: `tecnologia.`
* Emissões anuais: `15000.`
* Potencial de redução: `5000.`
* Possui projetos?: `n.`

**Saída (Resultado e Explicação):**

--- ANALISE CONCLUIDA ---

[Explicacao da Analise]
- Setor informado: tecnologia
- FATO: Limite base para 'tecnologia' e: 10000 tCO2e
- FATO: Emissoes anuais informadas: 15000 tCO2e
- REGRA (BalanÃ§o = Emissões - Limite): 15000 - 10000 = 5000 tCO2e
- REGRA (Status): Balanço 5000 tCO2e -> Status: deficit
- FATO: Potencial de reducao interna: 5000 tCO2e
- REGRA (Viabilidade): Custo interno < Custo mercado? -> sim
- REGRA (Recomendação): Status 'deficit' + Viabilidade 'sim' -> Ação: investir_reducao

RESULTADO: resultado(status(deficit),balanco(5000),acao_sugerida(investir_reducao))