import 'package:flutter/material.dart';
import 'package:system_loja/core/models/produto.dart';

/// Widget de seleção e criação de categorias de produto
///
/// Permite selecionar uma categoria existente de um dropdown ou criar uma nova
/// digitando no campo de texto. As categorias são extraídas dinamicamente
/// da lista de produtos existentes.
class ProductCategory extends StatefulWidget {
  /// Controller para gerenciar o texto da categoria
  final TextEditingController controller;

  /// Lista de produtos para extrair categorias existentes
  final List<Produto> produtos;

  /// Indica se o campo é obrigatório
  final bool required;

  /// Indica se o campo está habilitado
  final bool enabled;

  /// Callback chamado quando a categoria é alterada
  final ValueChanged<String?>? onChanged;

  const ProductCategory({
    super.key,
    required this.controller,
    required this.produtos,
    this.required = false,
    this.enabled = true,
    this.onChanged,
  });

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  /// Lista de categorias únicas extraídas dos produtos
  List<String> _categorias = [];

  /// Categoria atualmente selecionada no dropdown
  String? _categoriaSelecionada;

  /// Indica se o modo de entrada manual está ativo
  bool _modoEntradaManual = false;

  @override
  Widget build(BuildContext context) {
    // Se não há categorias cadastradas ou modo manual ativo, mostra apenas o campo de texto
    if (_categorias.isEmpty || _modoEntradaManual) {
      return _buildCampoTexto();
    }

    // Se há categorias, mostra dropdown + opção de adicionar nova
    return _buildCampoComDropdown();
  }

  @override
  void didUpdateWidget(ProductCategory oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.produtos != widget.produtos) {
      _atualizarCategorias();
    }
  }

  @override
  void initState() {
    super.initState();
    // Atualiza categorias antes de inicializar valor, pois depende da lista
    _atualizarCategorias();
    _inicializarValor();
  }

  /// Alterna entre modo dropdown e modo entrada manual
  void _alternarModo() {
    setState(() {
      _modoEntradaManual = !_modoEntradaManual;
      if (_modoEntradaManual) {
        _categoriaSelecionada = null;
      } else {
        // Preserva o valor do controller ao alternar para dropdown
        // Se o valor existir nas categorias, seleciona-o no dropdown
        final valorAtual = widget.controller.text.trim();
        if (valorAtual.isNotEmpty && _categorias.contains(valorAtual)) {
          _categoriaSelecionada = valorAtual;
        } else {
          // Valor não existe nas categorias, limpa o controller
          widget.controller.clear();
        }
      }
    });
  }

  /// Extrai categorias únicas dos produtos
  void _atualizarCategorias() {
    setState(() {
      _categorias =
          widget.produtos
              .where((produto) => produto.categoria.isNotEmpty)
              .map((produto) => produto.categoria)
              .toSet()
              .toList()
            ..sort();
    });
  }

  /// Constrói o campo com dropdown de categorias existentes
  Widget _buildCampoComDropdown() {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            padding: EdgeInsets.zero,
            initialValue: _categoriaSelecionada,
            hint: const Text('Selecione ou crie uma nova'),
            decoration: InputDecoration(
              labelText: widget.required ? 'Categoria *' : 'Categoria',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.category),
            ),
            items: [
              ..._categorias.map((categoria) {
                return DropdownMenuItem(
                  value: categoria,
                  child: Text(categoria),
                );
              }),
            ],
            onChanged: widget.enabled
                ? (value) {
                    setState(() {
                      _categoriaSelecionada = value;
                      if (value != null) {
                        widget.controller.text = value;
                      }
                    });
                    widget.onChanged?.call(value);
                  }
                : null,
            validator: widget.required
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'Selecione uma categoria';
                    }
                    return null;
                  }
                : null,
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: widget.enabled ? _alternarModo : null,
          icon: const Icon(Icons.add),
          tooltip: 'Adicionar nova categoria',
        ),
      ],
    );
  }

  /// Constrói o campo de texto para entrada manual
  Widget _buildCampoTexto() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: widget.controller,
            enabled: widget.enabled,
            decoration: InputDecoration(
              labelText: widget.required ? 'Categoria *' : 'Categoria',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.category),
              hintText: 'Digite uma nova categoria',
            ),
            validator: widget.required
                ? (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Categoria é obrigatória';
                    }
                    return null;
                  }
                : null,
            onChanged: (value) => widget.onChanged?.call(value),
          ),
        ),
        if (_categorias.isNotEmpty) ...[
          const SizedBox(width: 8),
          IconButton(
            onPressed: widget.enabled ? _alternarModo : null,
            icon: const Icon(Icons.list),
            tooltip: 'Selecionar categoria existente',
          ),
        ],
      ],
    );
  }

  /// Inicializa o valor do dropdown com base no controller
  void _inicializarValor() {
    final valorAtual = widget.controller.text.trim();
    if (valorAtual.isNotEmpty && _categorias.contains(valorAtual)) {
      _categoriaSelecionada = valorAtual;
      _modoEntradaManual = false;
    } else if (valorAtual.isNotEmpty) {
      _categoriaSelecionada = null;
      _modoEntradaManual = true;
    }
  }
}
