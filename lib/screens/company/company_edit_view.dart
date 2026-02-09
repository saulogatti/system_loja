import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/utils/validators.dart';
import 'package:system_loja/screens/company/bloc/company_bloc.dart';
import 'package:system_loja/screens/utils/constants.dart';
import 'package:system_loja/screens/widgets/address_form.dart';
import 'package:system_loja/screens/widgets/text_form_field_email.dart';

/// Tela de edição de empresa com CNPJ em modo somente leitura
///
/// Permite editar informações da empresa, mantendo o CNPJ visível mas não editável.
/// Usa o evento updateCompany do BLoC para persistir as mudanças.
@RoutePage()
class CompanyEditView extends StatefulWidget {
  final Company company;

  const CompanyEditView({super.key, required this.company});

  @override
  State<CompanyEditView> createState() => _CompanyEditViewState();
}

class _CompanyEditViewState extends State<CompanyEditView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _corporateNameController;
  late final TextEditingController _cnpjController;
  late final TextEditingController _emailController;
  late final TextEditingController _streetController;
  late final TextEditingController _zipCodeController;
  late final TextEditingController _neighborhoodController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyBloc, CompanyBlocState>(
      listener: (context, state) {
        state.whenOrNull(
          companiesLoaded: (companies, stateType) {
            if (stateType == EnumStateCompanyLoaded.updateCompany) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Empresa atualizada com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
              // Volta para a tela anterior
              Navigator.of(context).pop();
            }
          },
          companyError: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.red),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Empresa'),
          leading: const AutoLeadingButton(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Editar Empresa',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _corporateNameController,
                  decoration: const InputDecoration(
                    labelText: 'Razão Social *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.business),
                  ),
                  validator: (value) => combineValidators([
                    (v) => validateRequired(v, 'Razão Social'),
                    (v) => validateMinLength(v, 3, 'Razão Social'),
                  ])(value),
                ),
                const SizedBox(height: 16),
                // CNPJ em modo somente leitura
                TextFormField(
                  controller: _cnpjController,
                  decoration: const InputDecoration(
                    labelText: 'CNPJ',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.badge),
                    hintText: '00.000.000/0000-00',
                  ),
                  enabled: false, // Modo somente leitura
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                TextFormFieldEmail(
                  emailController: _emailController,
                  isEditing: true,
                ),
                const SizedBox(height: 16),
                AddressForm(
                  streetController: _streetController,
                  zipCodeController: _zipCodeController,
                  neighborhoodController: _neighborhoodController,
                  cityController: _cityController,
                  stateController: _stateController,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _cancelarEdicao,
                        icon: const Icon(Icons.cancel),
                        label: const Text('Cancelar'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _salvarAlteracoes,
                        icon: const Icon(Icons.save),
                        label: const Text('Salvar'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSystemInfo(),
              ],
            ),
          ),
        ),
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
    _stateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _corporateNameController = TextEditingController(
      text: widget.company.corporateName,
    );
    // Formata o CNPJ para exibição
    _cnpjController = TextEditingController(
      text: _formatCnpjForDisplay(widget.company.cnpj),
    );
    _emailController = TextEditingController(text: widget.company.email ?? '');
    _streetController = TextEditingController(
      text: widget.company.address.street,
    );
    _zipCodeController = TextEditingController(
      text: widget.company.address.zipCode,
    );
    _neighborhoodController = TextEditingController(
      text: widget.company.address.neighborhood,
    );
    _cityController = TextEditingController(text: widget.company.address.city);
    _stateController = TextEditingController(
      text: widget.company.address.state,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 14),
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

  /// Constrói o widget de informações do sistema
  Widget _buildSystemInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informações do Sistema',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('ID', widget.company.id.toString()),
            _buildInfoRow(
              'Data de Cadastro',
              _formatDate(widget.company.registrationDate),
            ),
            _buildInfoRow(
              'Última Atualização',
              _formatDate(widget.company.lastUpdatedDate),
            ),
          ],
        ),
      ),
    );
  }

  /// Cancela a edição e volta para a tela anterior
  void _cancelarEdicao() {
    Navigator.of(context).pop();
  }

  /// Formata um CNPJ (apenas dígitos) para o padrão XX.XXX.XXX/XXXX-XX
  ///
  /// Se o CNPJ não tiver exatamente 14 dígitos, retorna o valor original
  /// sem formatação para indicar que há um problema com os dados.
  String _formatCnpjForDisplay(String cnpj) {
    // Remove caracteres não numéricos caso existam
    final cnpjLimpo = cnpj.replaceAll(Constants.nonNumericRegExp, '');

    if (cnpjLimpo.length != 14) {
      return cnpj; // Retorna original se inválido
    }

    return '${cnpjLimpo.substring(0, 2)}.${cnpjLimpo.substring(2, 5)}.${cnpjLimpo.substring(5, 8)}/${cnpjLimpo.substring(8, 12)}-${cnpjLimpo.substring(12, 14)}';
  }

  /// Formata uma data no formato DD/MM/YYYY HH:MM
  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute';
  }

  /// Salva as alterações da empresa
  void _salvarAlteracoes() {
    if (_formKey.currentState!.validate()) {
      // Normaliza o CNPJ (remove caracteres não numéricos)
      final cnpjLimpo = widget.company.cnpj.replaceAll(
        Constants.nonNumericRegExp,
        '',
      );

      // Converte strings vazias em null para campos opcionais
      final email = _emailController.text.trim();
      final street = _streetController.text.trim();
      final zipCode = _zipCodeController.text.trim();
      final neighborhood = _neighborhoodController.text.trim();
      final city = _cityController.text.trim();
      final state = _stateController.text.trim();
      final updatedCompany = Company(
        id: widget.company.id,
        corporateName: _corporateNameController.text.trim(),
        cnpj: cnpjLimpo, // CNPJ normalizado (apenas dígitos)
        email: email.isEmpty ? null : email,
        address: Address(
          street: street,
          zipCode: zipCode,
          neighborhood: neighborhood,
          city: city,
          state: state,
        ),
      );

      context.read<CompanyBloc>().add(
        CompanyBlocEvent.updateCompany(company: updatedCompany),
      );
    }
  }
}
