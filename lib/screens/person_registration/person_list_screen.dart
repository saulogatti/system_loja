import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/application/app_injection.dart';
import 'package:system_loja/core/interface/i_company_repository.dart';
import 'package:system_loja/core/interface/i_customer_repository.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/screens/person_registration/cubit/person_list_cubit.dart';
import 'package:system_loja/screens/person_registration/cubit/person_list_state.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';
import 'package:system_loja/screens/widgets/card_list_item.dart';
import 'package:system_loja/screens/widgets/empty_widget.dart';

/// Exibe as listagens de pessoa fisica e pessoa juridica.
@RoutePage()
class PersonListScreen extends StatefulWidget implements AutoRouteWrapper {
  const PersonListScreen({super.key});
  static final ValueNotifier<int> _reloadSignal = ValueNotifier<int>(0);

  @override
  State<PersonListScreen> createState() => PersonListScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
    create: (_) => PersonListCubit(
      appInjection.get<ICustomerRepository>(),
      appInjection.get<ICompanyRepository>(),
    )..loadPeople(),
    child: this,
  );

  static void requestReload() {
    _reloadSignal.value++;
  }
}

class PersonListScreenState extends State<PersonListScreen> {
  @override
  Widget build(BuildContext context) => BlocBuilder<PersonListCubit, PersonListState>(
    builder: (context, state) {
      if (state is PersonListLoading || state is PersonListInitial) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state is! PersonListLoaded) {
        return const SizedBox.shrink();
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
            if (state.errorMessage != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: MaterialBanner(
                  content: Text(state.errorMessage!),
                  actions: [
                    TextButton(onPressed: _reloadPeople, child: const Text('Tentar novamente')),
                  ],
                ),
              ),
            Expanded(
              child: TabBarView(
                children: [
                  _PersonSectionList<Customer>(
                    emptyMessage: 'Nenhuma pessoa física cadastrada.',
                    entries: state.customers,
                    titleBuilder: (customer) => customer.name,
                    subtitleBuilder: (customer) =>
                        'CPF: ${customer.cpf} • E-mail: ${customer.email ?? '-'} • Telefone: ${customer.phone ?? '-'}',
                    onTap: (customer) async {
                      final changed = await context.router.push<bool>(
                        CustomerEditRoute(customer: customer),
                      );
                      if (changed == true && mounted) {
                        await _reloadPeople();
                      }
                    },
                  ),
                  _PersonSectionList<Company>(
                    emptyMessage: 'Nenhuma pessoa jurídica cadastrada.',
                    entries: state.companies,
                    titleBuilder: (company) => company.name,
                    subtitleBuilder: (company) =>
                        'CNPJ: ${company.cnpj} • E-mail: ${company.email ?? '-'} • Telefone: ${company.phone ?? '-'}',
                    onTap: (company) async {
                      final changed = await context.router.push<bool>(
                        CompanyEditRoute(company: company),
                      );
                      if (changed == true && mounted) {
                        await _reloadPeople();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );

  @override
  void dispose() {
    PersonListScreen._reloadSignal.removeListener(_onReloadSignal);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    PersonListScreen._reloadSignal.addListener(_onReloadSignal);
  }

  void _onReloadSignal() {
    _reloadPeople();
  }

  Future<void> _reloadPeople() => context.read<PersonListCubit>().loadPeople();
}

class _PersonSectionList<T> extends StatelessWidget {
  const _PersonSectionList({
    required this.entries,
    required this.emptyMessage,
    required this.titleBuilder,
    required this.subtitleBuilder,
    required this.onTap,
  });
  static const SliverGridDelegateWithMaxCrossAxisExtent _gridDelegate =
      SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 350,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: 132,
      );

  final List<T> entries;
  final String emptyMessage;
  final String Function(T entry) titleBuilder;
  final String Function(T entry) subtitleBuilder;
  final Future<void> Function(T entry) onTap;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return EmptyWidget(message: emptyMessage, icon: Icons.person_off_outlined);
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: _gridDelegate,
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return CardListItem(
          colorAvatar: Theme.of(context).colorScheme.primary,
          title: titleBuilder(entry),
          subTitle: subtitleBuilder(entry),
          margin: EdgeInsets.zero,
          onTap: () => onTap(entry),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<T>('entries', entries));
    properties.add(StringProperty('emptyMessage', emptyMessage));
    properties.add(ObjectFlagProperty<String Function(T entry)>.has('titleBuilder', titleBuilder));
    properties.add(
      ObjectFlagProperty<String Function(T entry)>.has('subtitleBuilder', subtitleBuilder),
    );
    properties.add(ObjectFlagProperty<Future<void> Function(T entry)>.has('onTap', onTap));
  }
}
