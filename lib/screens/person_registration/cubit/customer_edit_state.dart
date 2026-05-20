class CustomerEditDeleted extends CustomerEditState {
  final String message;

  const CustomerEditDeleted(this.message);
}

class CustomerEditError extends CustomerEditState {
  final String message;

  const CustomerEditError(this.message);
}

class CustomerEditInitial extends CustomerEditState {
  const CustomerEditInitial();
}

class CustomerEditLoading extends CustomerEditState {
  const CustomerEditLoading();
}

class CustomerEditSaved extends CustomerEditState {
  final String message;

  const CustomerEditSaved(this.message);
}

sealed class CustomerEditState {
  const CustomerEditState();
}
