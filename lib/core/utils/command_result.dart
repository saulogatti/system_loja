import 'package:freezed_annotation/freezed_annotation.dart';

/// Representa um resultado que contém um erro.
///
/// Subclasse de `ResultStatus<R, E>` usada internamente para indicar
/// que a operação falhou. O erro real está em `failure`.
///
/// Genéricos:
/// - `R`: tipo do valor em caso de sucesso
/// - `E`: tipo do erro em caso de falha
class ResultError<R, E> extends ResultStatus<R, E> {
  /// Erro ocorrido durante a operação.
  final E resultError;

  /// Cria uma instância de erro com o erro fornecido.
  ResultError(this.resultError);
}

/// Resultado selado de uma operação que pode ser sucesso ou falha.
///
/// Use `isSuccessful` / `hasError` para checar o estado antes de
/// acessar `asSuccess` ou `asError`. Alternativamente, use `when`
/// para executar callbacks específicos para cada caso.
///
/// Genéricos:
/// - `R`: tipo do valor em caso de sucesso
/// - `E`: tipo do erro em caso de falha
///
/// Exemplo de uso:
/// ```dart
/// ResultStatus<String, Exception> r = ResultStatus.success('ok');
/// r.when(
///   onSuccess: (v) => print('Sucesso: $v'),
///   onError: (e) => print('Erro: $e'),
/// );
/// ```
sealed class ResultStatus<R, E> {
  /// Construtor protegido para ser utilizado apenas por subclasses.
  @protected
  ResultStatus();

  /// Factory que cria um resultado de erro contendo `error`.
  factory ResultStatus.error(E error) {
    return ResultError<R, E>(error);
  }

  /// Factory que cria um resultado de sucesso contendo `result`.
  factory ResultStatus.success(R result) {
    return ResultSuccess(result);
  }

  /// Retorna o erro quando o resultado é uma falha.
  ///
  /// Lança [StateError] se chamado quando o resultado for sucesso.
  /// Verifique `hasError` antes de acessar este getter.
  E get asError {
    if (this is ResultError<R, E>) {
      return (this as ResultError<R, E>).resultError;
    }
    throw StateError('ResultStatus is not an error');
  }

  /// Retorna o valor quando o resultado é um sucesso.
  ///
  /// Lança [StateError] se chamado quando o resultado for erro.
  /// Verifique `isSuccessful` antes de acessar este getter.
  R get asSuccess {
    if (this is ResultSuccess<R, E>) {
      return (this as ResultSuccess<R, E>).result;
    }
    throw StateError('ResultStatus is not a success');
  }

  /// `true` quando o resultado representa um erro.
  bool get hasError => this is ResultError<R, E>;

  /// `true` quando o resultado representa sucesso.
  bool get isSuccessful => this is ResultSuccess<R, E>;

  /// Executa um callback conforme o tipo do resultado.
  ///
  /// - `onSuccess` é chamado se for sucesso.
  /// - `onError` é chamado se for erro.
  void when({
    required void Function(R valor) onSuccess,
    required void Function(E error) onError,
  }) {
    if (this is ResultSuccess<R, E>) {
      onSuccess((this as ResultSuccess<R, E>).result);
    } else if (this is ResultError<R, E>) {
      onError((this as ResultError<R, E>).resultError);
    }
  }
}

/// Representa um resultado bem-sucedido contendo o valor `result`.
///
/// Subclasse de `ResultStatus<R, E>` utilizada quando a operação
/// foi concluída com sucesso.
class ResultSuccess<R, E> extends ResultStatus<R, E> {
  /// Valor resultante da operação.
  final R result;

  /// Cria uma instância de sucesso com o valor especificado.
  ResultSuccess(this.result);
}
