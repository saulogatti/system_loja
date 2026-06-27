import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';
import 'package:system_loja/screens/home/bloc/home_bloc.dart';
import 'package:system_loja/screens/utils/text_formatters.dart';

/// Tela de configuração da empresa emitente.
///
/// Permite configurar os dados da pessoa/empresa que o sistema está gerenciando,
/// incluindo Nome Fantasia, Logotipo, Descrição e um campo reservado para futura
/// validação de chave de acesso.
@RoutePage()
class IssuerConfigScreen extends StatefulWidget {
  /// Cria uma instância de [IssuerConfigScreen].
  const IssuerConfigScreen({super.key});

  @override
  State<IssuerConfigScreen> createState() => _IssuerConfigScreenState();
}

class _IssuerConfigScreenState extends State<IssuerConfigScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fantasyNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _accessKeyController = TextEditingController();

  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  SystemUserData? _currentSystemUserData;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        switch (state) {
          case HomeLoaded(:final systemUserData):
            _applySystemUserData(systemUserData);
          case HomeSaved(:final systemUserData):
            _applySystemUserData(systemUserData);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Dados da empresa emitente salvos com sucesso.'),
                backgroundColor: Colors.green,
              ),
            );
          case HomeError(:final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Erro ao salvar dados da empresa emitente: $message'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          case HomeInitial() || HomeLoading():
            break;
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Empresa Emitente'), leading: const AutoLeadingButton()),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: AutofillGroup(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildLogoSection(context),
                  const SizedBox(height: 24),
                  _buildInfoSection(context),
                  const SizedBox(height: 24),
                  _buildAccessKeySection(context),
                  const SizedBox(height: 32),
                  _buildSaveButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fantasyNameController.dispose();
    _descriptionController.dispose();
    _accessKeyController.dispose();
    _cnpjController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeEvent.loadSystemUserData());
    });
  }

  void _applySystemUserData(SystemUserData systemUserData) {
    _currentSystemUserData = systemUserData;
    _fantasyNameController.text = systemUserData.name;
    _descriptionController.text = systemUserData.description;
    _accessKeyController.text = systemUserData.systemKey;
    _emailController.text = systemUserData.email ?? '';
    _phoneController.text = systemUserData.phone ?? '';
  }

  /// Constrói a seção de chave de acesso (reservada para futura implementação).
  Widget _buildAccessKeySection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.vpn_key, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text(
                  'Acesso ao Sistema',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Reservado para futura validação de chave de acesso',
              style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _accessKeyController,
              obscureText: true,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Chave de Acesso',
                hintText: 'Disponível em breve',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: const IconButton(
                  tooltip: 'Visibilidade da chave de acesso indisponível',
                  icon: Icon(Icons.visibility_off),
                  onPressed: null,
                ),
                helperText: 'Este campo será habilitado em uma versão futura.',
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói a seção de informações da empresa.
  Widget _buildInfoSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.business, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text(
                  'Dados da Empresa',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _fantasyNameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.organizationName],
              decoration: const InputDecoration(
                labelText: 'Nome Fantasia *',
                hintText: 'Ex.: Minha Loja',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.storefront),
              ),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Informe o Nome Fantasia';
                }
                if (value.trim().length < 2) {
                  return 'Nome Fantasia deve ter ao menos 2 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Ex.: contato@minhaloja.com',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Informe o Email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.telephoneNumber],
              decoration: const InputDecoration(
                labelText: 'Telefone',
                hintText: 'Ex.: (11) 99999-9999',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Informe o Telefone';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cnpjController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [CnpjTextInputFormatter()],
              decoration: const InputDecoration(
                labelText: 'CNPJ',
                hintText: 'Ex.: 12.345.678/0001-90',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.business),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Informe o CNPJ';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                hintText: 'Descreva brevemente a empresa ou os produtos/serviços oferecidos',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
                alignLabelWithHint: true,
              ),
              minLines: 3,
              maxLines: null,
              maxLength: 500,
              textCapitalization: TextCapitalization.sentences,
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói a seção do logotipo da empresa.
  Widget _buildLogoSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.image, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text('Logotipo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1),
                    ),
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _selecionarLogo,
                    icon: const Icon(Icons.upload),
                    label: const Text('Selecionar Imagem'),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Formatos suportados: PNG, JPG. Tamanho máximo: 2 MB.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói o botão de salvar.
  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _salvarConfiguracoes,
      icon: const Icon(Icons.save),
      label: const Text('Salvar Configurações'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        textStyle: const TextStyle(fontSize: 16),
      ),
    );
  }

  /// Salva as configurações da empresa emitente.
  void _salvarConfiguracoes() {
    if (_formKey.currentState?.validate() ?? false) {
      final existingData = _currentSystemUserData;
      final now = DateTime.now();
      context.read<HomeBloc>().add(
        HomeEvent.saveSystemUserData(
          SystemUserData(
            id: existingData?.id,
            registrationDate: existingData?.registrationDate ?? now,
            lastUpdatedDate: now,
            name: _fantasyNameController.text,
            systemKey: _accessKeyController.text,
            description: _descriptionController.text,
            email: _emailController.text,
            phone: _phoneController.text,
          ),
        ),
      );
    }
  }

  void _selecionarLogo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Seleção de logotipo disponível em breve.'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
