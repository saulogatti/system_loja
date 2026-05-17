class CompanyEditDeleted extends CompanyEditState {
  final String message;

  const CompanyEditDeleted(this.message);
}

class CompanyEditError extends CompanyEditState {
  final String message;

  const CompanyEditError(this.message);
}

class CompanyEditInitial extends CompanyEditState {
  const CompanyEditInitial();
}

class CompanyEditLoading extends CompanyEditState {
  const CompanyEditLoading();
}

class CompanyEditSaved extends CompanyEditState {
  final String message;

  const CompanyEditSaved(this.message);
}

sealed class CompanyEditState {
  const CompanyEditState();
}
