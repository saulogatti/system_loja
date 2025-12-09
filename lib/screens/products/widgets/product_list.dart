import 'package:flutter/material.dart';
import 'package:system_loja/core/models/produto.dart';
import 'package:system_loja/screens/widgets/card_list_item.dart';

/// Widget da lista de produtos cadastrados
///
/// Exibe os produtos em formato de lista com cards ou mensagem quando vazio.
class ProductList extends StatelessWidget {
  final List<Produto> produtos;
  final Function(Produto) onProductTap;

  const ProductList({
    super.key,
    required this.produtos,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Produtos Cadastrados',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        if (produtos.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'Nenhum produto cadastrado',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final produto = produtos[index];
              return CardListItem(
                colorAvatar: Colors.green,
                title: produto.nome,
                subTitle:
                    'Código: ${produto.codigo}\nR\$ ${produto.preco.toStringAsFixed(2)} - Estoque: ${produto.estoque}',
                onTap: () => onProductTap(produto),
              );
            },
          ),
      ],
    );
  }
}
