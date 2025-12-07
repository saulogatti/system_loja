class OperationError<R, E> extends OperationResult<R, E> {
  final E error;

  OperationError(this.error);
}

sealed class OperationResult<R, E> {
  bool get hasError => this is OperationError<R, E>;
  bool get isSuccessful => this is OperationSuccess<R, E>;
  void when({
    required void Function(R valor) onSucesso,
    required void Function(E erro) onErro,
  }) {
    if (this is OperationSuccess<R, E>) {
      onSucesso((this as OperationSuccess<R, E>).result);
    } else if (this is OperationError<R, E>) {
      onErro((this as OperationError<R, E>).error);
    }
  }
}

class OperationSuccess<R, E> extends OperationResult<R, E> {
  final R result;

  OperationSuccess(this.result);
}
