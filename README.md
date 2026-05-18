# Book manager - sua biblioteca pessoal

O book manager é uma aplicação web e mobile que permite o usuário gerenciar suas leituras, conseguindo colocar notas e reviews pessoais, anexar documentos .epub, .mobi, .pdf
e outros tipos de arquivos de texto para fácil acesso, personalizar capas de livros, organizar seus livros em coleções e ou pastas, entre outras funções para criar um ambiente
pessoal e próprio para melhor organizar seus livros digitais.

A ideia surgiu após uma experiência frustrante com outros aplicativos do tipo, onde livros que certas pessoas consideram bons tinham péssimas notas pois a maioria pensava o
contrário, causando uma sensação de que aquele ambiente não era para elas. Ao deixar essa experiência mais pessoal, cada pessoa pode criar o seu espaço, com as suas notas,
descrevendo as suas experiências no mundo literário e deixando elas guardadas para si.

# Estratégia de testes

O app está sendo desenvolvido em Flutter, com o backend em python, permitindo que quando testamos uma funcionalidade para o mobile, não precisamos replicar o teste para a versão web, pois ambos tem o mesmo código fonte. Claro, há exceções, como em casos onde precisamos adaptar certa parte para uma ou outra versão, mas no geral a quantidade de testes deve ser menor. 
### - Funcionalidades

**Adição de livro**
| Campo | Detalhe |
| :--- | :--- |
| **Nome** | Adicão de informações de livros |
| **Descrição** | Permite o usuário adicionar livros através de diferentes tipos de arquivos, ou adicionar de forma manual |
| **Regra de negócio** | 1. Os arquivos permitidos para upload devem ser apenas nos formatos: EPUB, MOBI, PDF e DOCX. <br> 2. Ao adicionar manualmente, os campos obrigatórios são: título, autor e ano de publicação. ISBN e gênero são opcionais. <br> 3. Não há validação de duplicidade, o usuário pode adicionar o mesmo livro várias vezes caso deseje. <br> 4. O sistema deve validar apenas a integridade dos dados (ex.: ano de publicação numérico, título não vazio). <br> 5. Arquivos com dados inválidos devem ser rejeitados com log de erros.|
| **Caso de teste 1** | **Adição manual com dados válidos** <br> 1. Acessar a funcionalidade "Adicionar livro manualmente". <br> 2. Preencher título, autor e ano de publicação corretamente. <br> 3. Clicar em "Salvar". <br> **Resultado esperado:** Livro adicionado com sucesso e mensagem de confirmação exibida.|
| **Caso de teste 2** | **Upload de arquivo EPUB com dados válidos** <br> 1. Fazer upload de um arquivo EPUB. <br> 2. Processar o arquivo e suas informações. <br> **Resultado esperado:** O livro é adicionado com sucesso ao acervo pessoal.|
| **Classificação**   |  **Caso de teste 1:** Teste de integração (UI + camada de persistência) <br> **Caso de teste 2:** Teste de integração (leitura de arquivo + processamento + persistência)|
#
**Edição e exclusão de livros**
| Campo | Detalhe |
| :--- | :--- |
| **Nome** | Remoção e edição de livros |
| **Descrição** | Permite ao usuário editar informações de um livro existente ou removê-lo completamente do acervo pessoal |
| **Regra de negócio** | 1. Para editar, o usuário deve selecionar um livro da lista e ter acesso a todos os campos editáveis: título, autor, ano, gênero, ISBN (se informado). <br> 2. Para remover, deve haver uma confirmação antes da exclusão para evitar remoções acidentais. <br> 3. Após editar, o livro atualizado é salvo e exibido na lista com as novas informações. <br> 4. Após remover, o livro não deve mais aparecer em nenhuma busca ou filtro. <br> 5. Não é possível desfazer uma remoção (a menos que o usuário adicione o livro novamente manualmente). |
| **Caso de teste 1** | **Edição de livro com sucesso** <br> 1. Selecionar um livro existente. <br> 2. Alterar o título de "Dom Casmurro" para "Dom Casmurro - Edição Especial". <br> 3. Salvar as alterações. <br> **Resultado esperado:** O livro é atualizado e passa a aparecer com o novo título na lista. |
| **Caso de teste 2** | **Remoção de livro com confirmação** <br> 1. Selecionar um livro existente. <br> 2. Clicar no botão "Remover". <br> 3. Confirmar a exclusão na caixa de diálogo. <br> **Resultado esperado:** O livro é removido do acervo e não aparece mais em nenhuma consulta. |
| **Classificação** | **Caso de teste 1:** Teste de integração (UI + edição + persistência) <br> **Caso de teste 2:** Teste de sistema (fluxo completo de remoção com confirmação) |
#
**Busca de livros**
| Campo | Detalhe |
| :--- | :--- |
| **Nome** | Busca e filtro de livros |
| **Descrição** | Permite ao usuário buscar livros por título, autor, ano ou gênero, além de aplicar filtros combinados para organizar a visualização do acervo |
| **Regra de negócio** | 1. A busca deve suportar correspondência parcial (contém) para título e autor, ignorando maiúsculas/minúsculas. <br> 2. Os filtros disponíveis são: título, autor, ano (exato ou intervalo), gênero. <br> 3. O usuário pode combinar múltiplos filtros simultaneamente. <br> 4. A busca deve retornar todos os livros que atendem aos critérios, ordenados por título por padrão. <br> 5. Caso nenhum livro seja encontrado, exibir mensagem amigável "Nenhum livro encontrado". |
| **Caso de teste 1** | **Busca por título com correspondência parcial** <br> 1. No campo de busca, digitar "Senhor" (sabendo que existem livros como "O Senhor dos Anéis" e "Sinais do Senhor"). <br> 2. Acionar a busca. <br> **Resultado esperado:** Retornar todos os livros que contêm a palavra "Senhor" no título. |
| **Caso de teste 2** | **Filtro combinado (autor + intervalo de ano)** <br> 1. Selecionar autor "Stephen King". <br> 2. Definir intervalo de ano: 2000 a 2010. <br> 3. Aplicar filtros. <br> **Resultado esperado:** Exibir apenas livros de Stephen King publicados entre 2000 e 2010. |
| **Classificação** | **Caso de teste 1:** Teste unitário (lógica de busca) <br> **Caso de teste 2:** Teste de integração (filtros combinados + consulta ao repositório) |
