/// Modelo de dados básico para transferência entre camadas.
///
/// Representa dados genéricos com identificador e nome, utilizado
/// para demonstrar o padrão Repository e Strategy na aplicação.
class DataModel {
  /// Identificador único do modelo.
  final String id;

  /// Nome descritivo do modelo.
  final String name;

  /// Cria uma instância de [DataModel].
  const DataModel({required this.id, required this.name});

  /// Cria uma instância a partir de um mapa de dados.
  ///
  /// Converte valores nulos ou inválidos para strings vazias.
  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
    );
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  /// Converte a instância para um mapa de dados.
  ///
  /// Utilizado para serialização e persistência.
  Map<String, dynamic> toMap() => {'id': id, 'name': name};

  @override
  String toString() => 'DataModel(id: $id, name: $name)';
}

/// Interface para repositórios que persistem [DataModel].
///
/// Define o contrato para operações de persistência, permitindo
/// múltiplas implementações (JSON, SQL, etc.).
abstract class DataRepository {
  /// Remove todos os dados persistidos.
  Future<void> clear();

  /// Carrega um modelo de dados persistido.
  ///
  /// Retorna `null` se não houver dados armazenados.
  Future<DataModel?> load();

  /// Persiste um modelo de dados.
  ///
  /// Lança exceção em caso de erro na persistência.
  Future<void> save(DataModel data);
}

/// Repositório que simula persistência em arquivo JSON.
///
/// Implementação de teste que mantém dados em memória.
/// Em produção, deve usar [FileSystemManager] para persistência real.
class JsonRepository implements DataRepository {
  /// Dados em cache (simula arquivo JSON).
  DataModel? _cachedData;

  @override
  Future<void> clear() async {
    _cachedData = null;
  }

  @override
  Future<DataModel?> load() async {
    // TODO: Implementar leitura real com FileSystemManager
    return _cachedData;
  }

  @override
  Future<void> save(DataModel data) async {
    // TODO: Implementar escrita real com FileSystemManager
    _cachedData = data;
  }
}

/// Estratégia de seleção de repositório baseada no tipo de armazenamento.
///
/// Implementa o padrão Strategy para permitir troca dinâmica entre
/// diferentes mecanismos de persistência sem alterar o código cliente.
class RepositoryStrategy {
  /// Repositório para persistência JSON.
  final JsonRepository jsonRepository;

  /// Repositório para persistência SQL.
  final SqlRepository sqlRepository;

  /// Tipo de armazenamento atualmente ativo.
  StorageType currentType;

  /// Cria uma estratégia de repositório.
  ///
  /// [currentType] define o tipo de armazenamento ativo (padrão: JSON).
  /// [jsonRepository] e [sqlRepository] podem ser injetados para testes.
  RepositoryStrategy({
    this.currentType = StorageType.json,
    JsonRepository? jsonRepository,
    SqlRepository? sqlRepository,
  }) : jsonRepository = jsonRepository ?? JsonRepository(),
       sqlRepository = sqlRepository ?? SqlRepository();

  /// Retorna o repositório ativo baseado no [currentType].
  DataRepository get activeRepository {
    switch (currentType) {
      case StorageType.json:
        return jsonRepository;
      case StorageType.sql:
        return sqlRepository;
    }
  }

  /// Altera o tipo de armazenamento ativo.
  void switchTo(StorageType type) {
    currentType = type;
  }
}

/// Repositório que simula persistência em banco SQL.
///
/// Implementação de teste que mantém dados em memória.
/// Em produção, deve usar SQLite managers para persistência real.
class SqlRepository implements DataRepository {
  /// Dados em cache (simula registro no banco).
  DataModel? _cachedData;

  @override
  Future<void> clear() async {
    _cachedData = null;
  }

  @override
  Future<DataModel?> load() async {
    // TODO: Implementar consulta SQL real com DatabaseHelper
    return _cachedData;
  }

  @override
  Future<void> save(DataModel data) async {
    // TODO: Implementar comandos SQL reais com DatabaseHelper
    _cachedData = data;
  }
}

/// Tipos de armazenamento suportados pela aplicação.
///
/// Permite alternar entre persistência JSON (legado) e SQL (novo).
enum StorageType {
  /// Persistência em arquivo JSON.
  json,

  /// Persistência em banco de dados SQLite.
  sql,
}

/// Controlador para operações de dados na camada de view.
///
/// Converte dados da interface do usuário para modelos de domínio
/// e delega operações de persistência para o repositório ativo
/// através da estratégia configurada.
class ViewDataController {
  /// Estratégia que determina qual repositório será utilizado.
  final RepositoryStrategy strategy;

  /// Cria um controlador com a estratégia de repositório especificada.
  ViewDataController(this.strategy);

  /// Remove todos os dados armazenados.
  Future<void> clearData() async {
    await strategy.activeRepository.clear();
  }

  /// Carrega dados para exibição na view.
  ///
  /// Retorna `null` se não houver dados armazenados.
  Future<DataModel?> loadToView() {
    return strategy.activeRepository.load();
  }

  /// Salva dados recebidos da view.
  ///
  /// Converte o mapa de dados da view em [DataModel] e persiste
  /// usando o repositório ativo.
  ///
  /// Lança exceção se [viewData] não contiver os campos obrigatórios.
  Future<void> saveFromView(Map<String, dynamic> viewData) async {
    if (viewData.isEmpty) {
      throw ArgumentError('viewData cannot be empty');
    }

    final dataModel = DataModel.fromMap(viewData);
    await strategy.activeRepository.save(dataModel);
  }

  /// Alterna o tipo de armazenamento.
  ///
  /// Permite trocar entre JSON e SQL em tempo de execução.
  void switchStorageType(StorageType type) {
    strategy.switchTo(type);
  }
}
