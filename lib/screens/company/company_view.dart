import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/models/company.dart';
import 'bloc/company_bloc.dart';
import 'widgets/company_form.dart';
import 'widgets/company_list.dart';
import 'widgets/company_search_section.dart';

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
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Carrega as empresas ao inicializar a tela
    context.read<CompanyBloc>().add(const CompanyBlocEvent.loadCompanies());
  }

  /// Adiciona uma nova empresa
  void _adicionarEmpresa() {
    if (_formKey.currentState!.validate()) {
      // Remove caracteres não numéricos do CNPJ
      final cnpjLimpo = _cnpjController.text.replaceAll(RegExp(r'[^0-9]'), '');

      context.read<CompanyBloc>().add(
            CompanyBlocEvent.registerCompany(
              corporateName: _corporateNameController.text,
              cnpj: cnpjLimpo,
              email: _emailController.text,
              street: _streetController.text,
              zipCode: _zipCodeController.text,
              neighborhood: _neighborhoodController.text,
              city: _cityController.text,
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
    final cnpjLimpo = cnpj.replaceAll(RegExp(r'[^0-9]'), '');

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
        title: Text(company.corporateName),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('CNPJ', company.cnpj),
              if (company.email != null && company.email!.isNotEmpty)
                _buildDetailRow('Email', company.email!),
              if (company.street != null && company.street!.isNotEmpty)
                _buildDetailRow('Rua', company.street!),
              if (company.zipCode != null && company.zipCode!.isNotEmpty)
                _buildDetailRow('CEP', company.zipCode!),
              if (company.neighborhood != null &&
                  company.neighborhood!.isNotEmpty)
                _buildDetailRow('Bairro', company.neighborhood!),
              if (company.city != null && company.city!.isNotEmpty)
                _buildDetailRow('Cidade', company.city!),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
