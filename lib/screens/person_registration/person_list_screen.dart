import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/aplication/app_injection.dart';
import 'package:system_loja/core/interface/i_company_repository.dart';
import 'package:system_loja/core/interface/i_customer_repository.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';
import 'package:system_loja/screens/widgets/card_list_item.dart';

/// Exibe as listagens de pessoa fisica e pessoa juridica.
@RoutePage()
class PersonListScreen extends StatefulWidget {
  static final ValueNotifier<int> _reloadSignal = ValueNotifier<int>(0);

  const PersonListScreen({super.key});

  @override
  State<PersonListScreen> createState() => PersonListScreenState();

  static void requestReload() {
    _reloadSignal.value++;
  }
}

class PersonListScreenState extends State<PersonListScreen> {
  final ICustomerRepository _customerRepository = appInjection.get<ICustomerRepository>();
  final ICompanyRepository _companyRepository = appInjection.get<ICompanyRepository>();

  bool _isLoading = false;
  String? _errorMessage;
  List<Customer> _customers = const [];
  List<Company> _companies = const [];

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const SizedBox(height: 8),
          const TabBar(
            tabs: [
              Tab(text: 'Pessoa Física', icon: Icon(Icons.badge)),
              Tab(text: 'Pessoa Jurídica', icon: Icon(Icons.business)),
            ],
          ),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: MaterialBanner(
                content: Text(_errorMessage!),
                actions: [TextButton(onPressed: reloadPeople, child: const Text('Tentar novamente'))],
              ),
            ),
          Expanded(
            child: TabBarView(
              children: [
                _PersonSectionList<Customer>(
                  emptyMessage: 'Nenhuma pessoa física cadastrada.',
                  entries: _customers,
                  titleBuilder: (customer) => customer.name,
                  subtitleBuilder: (customer) =>
                      'CPF: ${customer.cpf}\nE-mail: ${customer.email ?? '-'}\nTelefone: ${customer.phone ?? '-'}',
                  onTap: (customer) async {
                    final changed = await context.router.push<bool>(CustomerEditRoute(customer: customer));
                    if (changed == true && mounted) {
                      await reloadPeople();
                    }
                  },
                ),
                _PersonSectionList<Company>(
                  emptyMessage: 'Nenhuma pessoa jurídica cadastrada.',
                  entries: _companies,
                  titleBuilder: (company) => company.name,
                  subtitleBuilder: (company) =>
                      'CNPJ: ${company.cnpj}\nE-mail: ${company.email ?? '-'}\nTelefone: ${company.phone ?? '-'}',
                  onTap: (company) async {
                    final changed = await context.router.push<bool>(CompanyEditRoute(company: company));
                    if (changed == true && mounted) {
                      await reloadPeople();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    PersonListScreen._reloadSignal.removeListener(_onReloadSignal);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    PersonListScreen._reloadSignal.addListener(_onReloadSignal);
    reloadPeople();
  }

  /// Recarrega os dados das listas PF e PJ.
  Future<void> reloadPeople() async {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final customerResult = await _customerRepository.getAllCustomers();
    final companyResult = await _companyRepository.getAllCompanies();

    if (!mounted) {
      return;
    }

    final errors = <String>[];
    final customers = customerResult.isSuccessful ? customerResult.asSuccess : <Customer>[];
    final companies = companyResult.isSuccessful ? companyResult.asSuccess : <Company>[];

    if (customerResult.hasError) {
      errors.add(customerResult.asError);
    }
    if (companyResult.hasError) {
      errors.add(companyResult.asError);
    }

    setState(() {
      _customers = customers;
      _companies = companies;
      _errorMessage = errors.isEmpty ? null : errors.join(' | ');
      _isLoading = false;
    });
  }

  void _onReloadSignal() {
    reloadPeople();
  }
}

class _PersonSectionList<T> extends StatelessWidget {
  final List<T> entries;
  final String emptyMessage;
  final String Function(T entry) titleBuilder;
  final String Function(T entry) subtitleBuilder;
  final Future<void> Function(T entry) onTap;

  const _PersonSectionList({
    required this.entries,
    required this.emptyMessage,
    required this.titleBuilder,
    required this.subtitleBuilder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Center(
        child: Text(emptyMessage, style: const TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return CardListItem(
          colorAvatar: Theme.of(context).colorScheme.primary,
          title: titleBuilder(entry),
          subTitle: subtitleBuilder(entry),
          onTap: () => onTap(entry),
        );
      },
    );
  }
}
