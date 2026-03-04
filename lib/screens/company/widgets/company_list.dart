import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/screens/company/bloc/company_bloc.dart';
import 'package:system_loja/screens/widgets/card_list_item.dart';

/// Widget da lista de empresas cadastradas
///
/// Exibe as empresas em formato de lista com cards ou mensagem quando vazio.
/// Gerencia os estados do BLoC internamente.
class CompanyList extends StatefulWidget {
  /// Espaçamento padrão entre título e lista
  static const double _defaultSpacing = 16.0;

  final Function(Company) onCompanyTap;

  const CompanyList({super.key, required this.onCompanyTap});

  @override
  State<CompanyList> createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList> {
  final Map<int, Company> _companies = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Empresas Cadastradas',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: CompanyList._defaultSpacing),
        BlocListener<CompanyBloc, CompanyBlocState>(
          listener: (context, state) {
            state.when(
              initial: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    'Carregando empresas...',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              companiesLoaded: (companies, stateType) {
                _companies.clear();
                _companies.addAll(companies);
                setState(() {});
              },
              companyError: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              companyFound: (company) => const SizedBox.shrink(),
            );
          },
          child: Column(
            children: [
              if (_companies.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      'Nenhuma empresa cadastrada',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
              if (_companies.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: _companies.length,
                  itemBuilder: (context, index) {
                    final company = _companies.values.elementAt(index);
                    return CardListItem(
                      colorAvatar: Colors.teal,
                      title: company. name,
                      subTitle:
                          'CNPJ: ${company.cnpj}\n${company.email ?? "Sem email"}\n${company.address.city}',
                      onTap: () => widget.onCompanyTap(company),
                      onDelete: () => _confirmarExclusao(company),
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _confirmarExclusao(Company company) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text(
          'Tem certeza que deseja excluir a empresa "${company.name}"?\n\nEsta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<CompanyBloc>().add(
                CompanyBlocEvent.deleteCompany(id: company.id),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Deletar'),
          ),
        ],
      ),
    );
  }
}
