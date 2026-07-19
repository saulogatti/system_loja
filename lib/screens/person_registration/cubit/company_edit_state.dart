class CompanyEditDeleted extends CompanyEditState {

  const CompanyEditDeleted(this.message);
  final String message;
}

class CompanyEditError extends CompanyEditState {

  const CompanyEditError(this.message);
  final String message;
}

class CompanyEditInitial extends CompanyEditState {
  const CompanyEditInitial();
}

class CompanyEditLoading extends CompanyEditState {
  const CompanyEditLoading();
}

class CompanyEditSaved extends CompanyEditState {

  const CompanyEditSaved(this.message);
  final String message;
}

sealed class CompanyEditState {
  const CompanyEditState();
}
