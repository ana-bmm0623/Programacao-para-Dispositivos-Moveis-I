# a1_tecnstore

Este projeto é um aplicativo Flutter para gerenciamento de uma lista de objetos, demonstrando como integrar uma aplicação mobile com uma API RESTful para executar operações de CRUD (criar, ler, atualizar e excluir).

---

## Visão Geral

O **a1_tecnstore** é um exemplo prático que ilustra conceitos fundamentais do desenvolvimento com Flutter:

- **Listagem de Objetos:** Exibe os dados obtidos de uma API.
- **Cadastro de Objetos:** Permite a criação de novos itens através de um formulário interativo.
- **Atualização e Exclusão:** Possibilita a edição e remoção dos registros existentes com feedback visual e confirmação de ações.
- **Integração com API RESTful:** Consome serviços HTTP utilizando a biblioteca `http` para comunicação com o backend.

---

## Funcionalidades

- **Exibição Dinâmica:** Carrega e atualiza a lista de objetos diretamente do serviço RESTful.
- **Formulário de Cadastro/Atualização:** Interface intuitiva para inserir ou alterar informações dos objetos.
- **Confirmação para Exclusão:** Diálogo de confirmação antes da remoção de um registro.
- **Refresh Manual:** Atualiza a lista de itens por meio de gesto _pull-to-refresh_.

---

## Tecnologias Utilizadas

- **[Flutter](https://flutter.dev):** Framework para desenvolvimento de aplicações mobile.
- **Dart:** Linguagem de programação utilizada para desenvolver o app.
- **http:** Biblioteca para realizar requisições HTTP.
- **API RESTful:** Gerencia os dados dos objetos (a URL base é definida como `https://api.restful-api.dev/objects`).

---

## Pré-requisitos

- **Flutter SDK:** Tenha o Flutter instalado. Consulte a [documentação oficial](https://docs.flutter.dev/) para mais detalhes.
- **Emulador ou Dispositivo Real:** Configure um dispositivo para testar o aplicativo.
- **Acesso à API:** Certifique-se de que a API RESTful está disponível e, se necessário, atualize a URL base no `RestfulApiService`.

---

## Instalando e Executando

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/ana-bmm0623/Programacao-para-Dispositivos-Moveis-I/edit/main/a1_tecnstore
   cd a1_tecnstore

2. **Instale as dependências:**

   ```bash
   flutter pub get


3. **Execute o aplicativo:**

   ```bash
   flutter run

## Estrutura do Projeto
   ```bash
a1_tecnstore/
├── lib/
│   ├── main.dart                # Ponto de entrada e lógica principal do app.
├── pubspec.yaml                 # Configurações e dependências do projeto.
└── README.md                    # Este arquivo.
