// Gere código com as seguintes classes:
//
// 1) DataModel: classe simples de exemplo, com alguns campos (ex: id, name).
//
// 2) interface DataRepository (abstract class):
//    - Future<void> save(DataModel data);
//    - Future<DataModel?> load();
//
// 3) JsonRepository implements DataRepository:
//    - Salva e carrega os dados em um arquivo JSON (use stubs ou comentários
//      explicando onde ficaria a lógica real de I/O).
//
// 4) SqlRepository implements DataRepository:
//    - Salva e carrega os dados em um "banco SQL" (simular com comentários ou
//      métodos vazios, apenas estruturando o código).
//
// 5) enum StorageType { json, sql }
//
// 6) RepositoryStrategy:
//    - Possui instâncias de JsonRepository e SqlRepository.
//    - Possui uma propriedade StorageType currentType.
//    - Expõe DataRepository get activeRepository, que retorna o repo de acordo
//      com currentType.
//
// 7) ViewDataController:
//    - Recebe RepositoryStrategy no construtor.
//    - Tem métodos Future<void> saveFromView(Map<String, dynamic> viewData)
//      e Future<DataModel?> loadToView().
//    - Converte Map<String, dynamic> em DataModel e chama activeRepository.save/load.
//
// Use null-safety, boas práticas de nomeação e comentários explicando o papel
// de cada classe.
