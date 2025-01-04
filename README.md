# WL Consulting - Desafio Flutter

Este é um aplicativo de gerenciamento de tarefas desenvolvido em Flutter como parte do desafio técnico da WL Consulting.

## 🚀 Funcionalidades

- ✅ Listagem de tarefas com scroll infinito
- ✅ Listagem de tarefas finalizadas
- ✅ Criação de novas tarefas
- ✅ Atualização de tarefas
- ✅ Exclusão de tarefas
- ✅ Busca de tarefas
- ✅ Persistência local de dados
- ✅ Interface moderna e responsiva

## 🛠️ Tecnologias Utilizadas

- **Flutter**: Framework para desenvolvimento multiplataforma
- **Bloc**: Gerenciamento de estado
- **SQLite**: Banco de dados local
- **GetIt**: Injeção de dependências
- **Clean Architecture**: Arquitetura do projeto
- **Mocktail**: Framework para testes

## 📁 Estrutura do Projeto

O projeto segue os princípios da Clean Architecture:

```
lib/
  ├── core/              # Componentes centrais
  │   ├── database/      # Implementação do banco de dados
  │   └── di/            # Injeção de dependências
  ├── data/              # Camada de dados
  │   ├── datasources/   # Fontes de dados
  │   ├── models/        # Modelos de dados
  │   └── repositories/  # Implementação dos repositórios
  ├── domain/            # Regras de negócio
  │   ├── entities/      # Entidades
  │   ├── repositories/  # Interfaces dos repositórios
  │   └── usecases/      # Casos de uso
  └── presenter/         # Camada de apresentação
      ├── bloc/          # Gerenciamento de estado
      └── ui/            # Interfaces de usuário
          ├── pages/     # Páginas
          └── widgets/   # Componentes reutilizáveis
```

## 🔥 Recursos Implementados

### Offline First
- Banco de dados SQLite para persistência local
- Operações CRUD completas
- Sincronização automática

### Scroll Infinito
- Carregamento paginado de tarefas
- Cache local para melhor performance
- Indicador de carregamento

### Clean Code
- Código limpo e bem organizado
- Princípios SOLID
- Separação clara de responsabilidades
- Nomes descritivos e intuitivos

### Injeção de Dependências
- GetIt para gerenciamento de dependências
- Configuração centralizada
- Lazy loading de instâncias
- Fácil manutenção e teste

### Testes Automatizados
- Testes unitários do BLoC
- Testes de repositório
- Mocks para isolamento de testes
- Cobertura de casos de erro

## 🚦 Como Executar

1. Clone o repositório:
```bash
git clone https://github.com/lviegas21/wl-consulting-challenger.git
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Execute o aplicativo:
```bash
flutter run
```

4. Para rodar os testes:
```bash
flutter test
```

## 📱 Funcionalidades Detalhadas

### Listagem de Tarefas
- Visualização em lista com scroll infinito
- Carregamento de 10 itens por vez
- Indicador de carregamento ao final da lista
- Pull-to-refresh para atualização

### Gerenciamento de Tarefas
- Criação com título e descrição
- Marcação como concluída
- Exclusão com confirmação
- Atualização em tempo real

### Busca
- Busca por título ou descrição
- Resultados instantâneos
- Filtro de tarefas concluídas

## 🧪 Testes

O projeto inclui testes abrangentes:

- Testes unitários do BLoC
- Testes de repositório
- Testes de casos de uso
- Testes de integração

Para executar todos os testes com cobertura:
```bash
flutter test --coverage
```
