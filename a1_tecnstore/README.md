a1_tecnstore

Este projeto é um aplicativo Flutter para gerenciamento de uma lista de objetos, demonstrando como integrar uma aplicação mobile com uma API RESTful para realizar operações de CRUD (criar, ler, atualizar e excluir).
Visão Geral

O a1_tecnstore é um exemplo prático que ensina conceitos fundamentais do desenvolvimento com Flutter, como:

    Listagem de Objetos: Exibe os dados obtidos de uma API.

    Cadastro de Objetos: Permite a criação de novos itens usando um formulário interativo.

    Atualização e Exclusão: Possibilita a edição e remoção dos registros existentes com feedback visual e confirmação de ações.

    Integração com API RESTful: Consumo dos serviços HTTP utilizando a biblioteca http para comunicação com o backend.

Funcionalidades

    Exibição Dinâmica: Carrega e atualiza a lista de objetos diretamente do serviço RESTful.

    Formulário de Cadastro/Atualização: Interface intuitiva para inserir ou alterar as informações dos objetos.

    Confirmação para Exclusão: Diálogo de confirmação antes da remoção de um registro.

    Refresh Manual: Atualiza a lista de itens via gesto pull-to-refresh.

Tecnologias Utilizadas

    Flutter: Framework de desenvolvimento para aplicações mobile.

    Dart: Linguagem de programação utilizada no Flutter.

    http: Biblioteca para realizar requisições HTTP.

    API RESTful: Utilizada para gerenciar os dados dos objetos (a URL base está definida como https://api.restful-api.dev/objects).

Pré-requisitos

    Flutter SDK: Certifique-se de que o Flutter está instalado. Consulte a documentação oficial para mais detalhes.

    Emulador ou Dispositivo Real: Configure um dispositivo para testar o aplicativo.

    Acesso à API: Verifique se a API RESTful está disponível e, se necessário, atualize a URL base em RestfulApiService.

Instalando e Executando

    Clone o repositório:

git clone <URL_DO_SEU_REPOSITÓRIO>
cd a1_tecnstore

Instale as dependências:

flutter pub get

Execute o aplicativo:

    flutter run

Estrutura do Projeto

A organização do projeto é a seguinte:

a1_tecnstore/
├── lib/
│   ├── main.dart                # Ponto de entrada e lógica principal do app.
│   ├── widgets/                 # Widgets customizados, como o item da lista e formulários.
│   └── models/                  # Modelos de dados e serviços (ex.: Objeto e RestfulApiService).
├── pubspec.yaml                 # Configurações e dependências do projeto.
└── README.md                    # Este arquivo.

Detalhes da Implementação

    Listagem de Objetos:
    O aplicativo inicia com uma requisição GET à API, exibindo todos os objetos cadastrados. Em caso de erro, o carregamento é interrompido e uma mensagem de erro é impressa no console.

    Cadastro e Atualização:
    A tela de formulário (FormularioObjetoScaffold) é responsável por captar os dados de um novo objeto ou atualizar um existente. Após a inserção ou alteração, os dados são enviados para a API com métodos POST ou PUT.

    Exclusão de Objetos:
    Cada item da lista possui botões para atualizar ou excluir, onde a exclusão requer confirmação por meio de um AlertDialog.

Exemplo de Código

void main() {
  runApp(const ListaComprasApp());
}

O trecho acima inicia o aplicativo, que utiliza a classe ListaComprasApp para definir o tema e a tela principal.
Personalizações

    Tema e Estilo:
    O tema padrão é baseado em Colors.blue, podendo ser ajustado conforme a identidade visual desejada para o app.

    API Base URL:
    Atualmente, a URL para a API está definida em RestfulApiService como https://api.restful-api.dev/objects. Caso a API seja alterada ou haja necessidade de endpoints diferentes, atualize este valor.

Contribuição

Contribuições são muito bem-vindas! Se você deseja sugerir melhorias ou corrigir algum problema, sinta-se à vontade para:

    Abrir uma issue detalhando o problema ou sugestão.

    Enviar um pull request com as alterações propostas.

Recursos Adicionais

    Documentação Flutter

    Codelab Flutter - Escreva seu primeiro app Flutter

    Cookbook Flutter - Exemplos úteis