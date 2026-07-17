# CompareTBs

CompareTBs é uma ferramenta desenvolvida em Python para comparar os resultados de consultas SQL (`SELECT`) entre diferentes bancos de dados, auxiliando na validação de migrações e na identificação de inconsistências de forma rápida e automatizada.

O projeto começou a ser desenvolvido nos meus primeiros meses de trabalho na Webline, com o objetivo de reduzir o tempo gasto em conferências manuais e tornar o processo de validação de migração muito mais eficiente.

## Como funciona

O programa executa consultas previamente definidas em dois bancos de dados distintos, compara os resultados obtidos e apresenta todas as diferenças encontradas, facilitando a identificação de registros que não foram migrados corretamente ou que sofreram alterações inesperadas.

## Estrutura do projeto

O CompareTBs é composto por três arquivos principais:

### `Comparar.py`
Arquivo principal da aplicação.

Responsável por:
- Executar as consultas SQL;
- Comparar os resultados entre os bancos;
- Identificar divergências;
- Armazenar as diferenças encontradas para posterior exibição.

### `DB.py`
Responsável pelo gerenciamento das conexões com os bancos de dados.

Suas funções incluem:
- Ler as variáveis do arquivo `.env`;
- Montar as conexões com os bancos;
- Centralizar as informações sensíveis em um único ponto da aplicação.

### `Dicionario.json`
Arquivo de configuração utilizado pelo sistema.

Nele são definidos:
- Caminhos das consultas SQL;
- Parâmetros utilizados durante a comparação;
- Nome das tabelas;
- IDs e identificadores;
- Comentários e observações específicas de cada comparação.

## Arquivos auxiliares

Além dos arquivos principais, o projeto utiliza:

- `.env` — Armazena as credenciais e configurações de conexão com os bancos de dados.
- Arquivos `.sql` — Contêm as consultas executadas durante o processo de comparação.

## Objetivo

Com a combinação desses arquivos, o CompareTBs consegue identificar problemas de migração de bancos de dados praticamente em tempo real.
Isso elimina boa parte da necessidade de abrir sistemas, consultar tabelas manualmente ou realizar conferências repetitivas, tornando o processo de validação muito mais rápido, confiável e produtivo.
