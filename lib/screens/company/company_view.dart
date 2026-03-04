import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/models/company.dart';
import '../route/route_app.gr.dart';
import '../utils/constants.dart';
import 'bloc/company_bloc.dart';
import 'widgets/company_form.dart';
import 'widgets/company_list.dart';
import 'widgets/company_search_section.dart';
import 'widgets/info_row.dart';

@RoutePage()
class CompanyView extends StatefulWidget {
  const CompanyView({super.key});

  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {
  final _formKey = GlobalKey<FormState>();
  final _corporateNameController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _emailController = TextEditingController();
  final _streetController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();
  final _searchCnpjController = TextEditingController();
  final _stateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyBloc, CompanyBlocState>(
      listener: (context, state) {
        state.whenOrNull(
          companiesLoaded: (companies, stateType) {
            switch (stateType) {
              case EnumStateCompanyLoaded.registerCompany:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Empresa cadastrada com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
                _formKey.currentState!.reset();
                _corporateNameController.clear();
                _cnpjController.clear();
                _emailController.clear();
                _streetController.clear();
                _zipCodeController.clear();
                _neighborhoodController.clear();
                _cityController.clear();
                _stateController.clear();
              case EnumStateCompanyLoaded.deleteCompany:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Empresa deletada com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
              case EnumStateCompanyLoaded.companiesLoaded:
              case EnumStateCompanyLoaded.updateCompany:
            }
          },
          companyFound: (company) {
            // Navega para a tela de detalhes quando uma empresa é encontrada
            _openCompanyDetails(company);
          },
        );
      },
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Formulário de cadastro
                  CompanyForm(
                    formKey: _formKey,
                    corporateNameController: _corporateNameController,
                    cnpjController: _cnpjController,
                    emailController: _emailController,
                    streetController: _streetController,
                    zipCodeController: _zipCodeController,
                    neighborhoodController: _neighborhoodController,
                    cityController: _cityController,
                    stateController: _stateController,
                    onSubmit: _adicionarEmpresa,
                  ),
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 32),
                  // Seção de busca por CNPJ
                  CompanySearchSection(
                    searchCnpjController: _searchCnpjController,
                    onSearch: _buscarEmpresaPorCnpj,
                  ),
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 32),
                  // Lista de empresas
                  CompanyList(onCompanyTap: _mostrarDetalhesEmpresa),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _corporateNameController.dispose();
    _cnpjController.dispose();
    _emailController.dispose();
    _streetController.dispose();
    _zipCodeController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _searchCnpjController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Carrega as empresas ao inicializar a tela
    context.read<CompanyBloc>().add(const CompanyBlocEvent.loadCompanies());
  }

  /// Abre a tela de edição da empresa
  void _abrirTelaEdicao(Company company) {
    context.pushRoute(CompanyEditRoute(company: company));
  }

  /// Adiciona uma nova empresa
  void _adicionarEmpresa() {
    if (_formKey.currentState!.validate()) {
      // Remove caracteres não numéricos do CNPJ
      final cnpjLimpo = _cnpjController.text.replaceAll(
        Constants.nonNumericRegExp,
        '',
      );

      context.read<CompanyBloc>().add(
        CompanyBlocEvent.registerCompany(
          corporateName: _corporateNameController.text,
          cnpj: cnpjLimpo,
          email: _emailController.text,
          street: _streetController.text,
          zipCode: _zipCodeController.text,
          neighborhood: _neighborhoodController.text,
          city: _cityController.text,
          state: _stateController.text,
        ),
      );
    }
  }

  /// Busca uma empresa pelo CNPJ
  void _buscarEmpresaPorCnpj() {
    final cnpj = _searchCnpjController.text.trim();
    if (cnpj.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite um CNPJ para buscar'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Remove caracteres não numéricos do CNPJ
    final cnpjLimpo = cnpj.replaceAll(Constants.nonNumericRegExp, '');

    context.read<CompanyBloc>().add(
      CompanyBlocEvent.findCompanyByCnpj(cnpj: cnpjLimpo),
    );
  }

  /// Mostra os detalhes de uma empresa
  void _mostrarDetalhesEmpresa(Company company) {
    _openCompanyDetails(company);
  }

  /// Abre a tela de detalhes da empresa
  void _openCompanyDetails(Company company) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(company.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InfoRow(label: 'CNPJ', value: company.cnpj),
              if (company.email != null && company.email!.isNotEmpty)
                InfoRow(label: 'Email', value: company.email!),
              if (company.address.street.isNotEmpty)
                InfoRow(label: 'Rua', value: company.address.street),
              if (company.address.zipCode.isNotEmpty)
                InfoRow(label: 'CEP', value: company.address.zipCode),
              if (company.address.neighborhood.isNotEmpty)
                InfoRow(
                  label: 'Bairro',
                  value: company.address.neighborhood,
                ),
              if (company.address.city.isNotEmpty)
                InfoRow(label: 'Cidade', value: company.address.city),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              _abrirTelaEdicao(company);
            },
            icon: const Icon(Icons.edit),
            label: const Text('Editar'),
          ),
        ],
      ),
    );
  }
}
