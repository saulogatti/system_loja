import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_type.dart' show InvoiceType;
import 'package:system_loja/core/utils/result_status.dart';

/// Contrato de persistência de notas fiscais (entrada e saída).
///
/// {@category contratos}
/// {@subCategory Vendas}
///
/// CRUD de [Invoice] via Drift, com geração e validação de número único.
/// Erros voltam como [ResultStatus.error].
///
/// Resolver com `appInjection.get<ISalesRepository>()`.
///
/// ```dart
/// final repository = appInjection.get<ISalesRepository>();
/// final numero = await repository.generateInvoiceNumber();
/// numero.when(
///   onSuccess: (valor) => print(valor),
///   onError: (mensagem) => print(mensagem),
/// );
/// ```
///
/// Veja também:
/// - [Invoice] — modelo de domínio
/// - [InvoiceType] — entrada ou saída
/// - [ResultStatus] — retorno das operações
abstract interface class ISalesRepository {
  /// Remove uma venda do sistema pelo ID.
  ///
  /// **ATENÇÃO**: A remoção de uma venda pode afetar o estoque.
  /// Certifique-se de implementar a lógica de estorno adequada.
  ///
  /// Parâmetros:
  /// - [id]: ID único da venda a ser removida
  ///
  /// Retorna:
  /// - [ResultStatus] com true se removida com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> deleteSale(int id);

  /// Gera um novo número de nota fiscal único.
  ///
  /// O número é gerado automaticamente seguindo a sequência do sistema,
  /// garantindo que não haja duplicação.
  ///
  /// Retorna:
  /// - [ResultStatus] com String contendo o novo número ou mensagem de erro
  Future<ResultStatus<String, String>> generateInvoiceNumber();

  /// Obtém o próximo ID disponível para uma venda.
  ///
  /// Útil para pré-alocação de IDs em interfaces de cadastro.
  ///
  /// Retorna:
  /// - [ResultStatus] com o próximo ID disponível ou mensagem de erro
  Future<ResultStatus<int, String>> getNextSaleId();

  /// Busca uma venda específica pelo ID.
  ///
  /// Parâmetros:
  /// - [id]: ID único da venda
  ///
  /// Retorna:
  /// - [ResultStatus] com a venda encontrada ou mensagem de erro
  Future<ResultStatus<Invoice, String>> getSaleById(int id);

  /// Retorna todas as vendas mapeadas por ID.
  ///
  /// Útil para acesso rápido a vendas por ID sem necessidade de busca.
  ///
  /// Retorna:
  /// - [ResultStatus] com `Map<int, Invoice>` ou mensagem de erro
  Future<ResultStatus<Map<int, Invoice>, String>> loadAllSales();

  /// Retorna todas as notas de entrada mapeadas por ID.
  ///
  /// Notas de entrada são vinculadas a empresas ([InvoiceType.entry]).
  ///
  /// Retorna:
  /// - [ResultStatus] com `Map<int, Invoice>` ou mensagem de erro
  Future<ResultStatus<Map<int, Invoice>, String>> loadEntryInvoices();

  /// Retorna todas as notas de saída mapeadas por ID.
  ///
  /// Notas de saída são vinculadas a clientes ([InvoiceType.exit]).
  ///
  /// Retorna:
  /// - [ResultStatus] com `Map<int, Invoice>` ou mensagem de erro
  Future<ResultStatus<Map<int, Invoice>, String>> loadExitInvoices();

  /// Salva uma nova venda no sistema.
  ///
  /// Para vendas sem ID ou com ID = 0, será criado um novo registro.
  /// O número da nota fiscal deve ser único.
  ///
  /// Parâmetros:
  /// - [invoice]: Objeto Invoice a ser salvo
  ///
  /// Retorna:
  /// - [ResultStatus] com true se salva com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> saveSale(Invoice invoice);

  /// Atualiza os dados de uma venda existente.
  ///
  /// A venda deve ter um ID válido.
  ///
  /// Parâmetros:
  /// - [invoice]: Objeto Invoice com dados atualizados
  ///
  /// Retorna:
  /// - [ResultStatus] com true se atualizada com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> updateSale(Invoice invoice);

  /// Valida se um número de nota fiscal é único no sistema.
  ///
  /// Útil para verificação antes de criar ou atualizar vendas.
  ///
  /// Parâmetros:
  /// - [invoiceNumber]: Número da nota fiscal a ser validado
  ///
  /// Retorna:
  /// - [ResultStatus] com true se o número é válido (não existe) ou mensagem de erro
  Future<ResultStatus<bool, String>> validateInvoiceNumber(
    String invoiceNumber,
  );
}
