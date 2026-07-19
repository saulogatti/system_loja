class CustomerEditDeleted extends CustomerEditState {

  const CustomerEditDeleted(this.message);
  final String message;
}

class CustomerEditError extends CustomerEditState {

  const CustomerEditError(this.message);
  final String message;
}

class CustomerEditInitial extends CustomerEditState {
  const CustomerEditInitial();
}

class CustomerEditLoading extends CustomerEditState {
  const CustomerEditLoading();
}

class CustomerEditSaved extends CustomerEditState {

  const CustomerEditSaved(this.message);
  final String message;
}

sealed class CustomerEditState {
  const CustomerEditState();
}
