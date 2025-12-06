import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/models/cliente.dart';
import 'package:system_loja/core/models/produto.dart';
import 'package:system_loja/core/models/nota_fiscal.dart';
import 'package:system_loja/core/models/item_nota_fiscal.dart';

/// Testes de serialização JSON
///
/// Valida que os métodos toJson() e fromJson() funcionam corretamente
/// para todos os modelos após a refatoração.
void main() {
  group('Produto - Serialização JSON', () {
    test('deve serializar e desserializar corretamente', () {
      // Arrange
      final produto = Produto(
        id: 1,
        nome: 'Notebook Dell',
        codigo: 'NOTE-001',
        preco: 3500.00,
        estoque: 10,
        descricao: 'Notebook Dell Inspiron 15',
        categoria: 'Eletrônicos',
      );

      // Act
      final json = produto.toJson();
      final produtoReconstruido = Produto.fromJson(json);

      // Assert
      expect(produtoReconstruido.id, equals(produto.id));
      expect(produtoReconstruido.nome, equals(produto.nome));
      expect(produtoReconstruido.codigo, equals(produto.codigo));
      expect(produtoReconstruido.preco, equals(produto.preco));
      expect(produtoReconstruido.estoque, equals(produto.estoque));
      expect(produtoReconstruido.descricao, equals(produto.descricao));
      expect(produtoReconstruido.categoria, equals(produto.categoria));
    });
  });

  group('Cliente - Serialização JSON', () {
    test('deve serializar e desserializar corretamente', () {
      // Arrange
      final cliente = Cliente(
        id: 1,
        nome: 'João Silva',
        cpf: '123.456.789-00',
        email: 'joao@email.com',
        telefone: '(11) 98765-4321',
        endereco: 'Rua A, 123',
      );

      // Act
      final json = cliente.toJson();
      final clienteReconstruido = Cliente.fromJson(json);

      // Assert
      expect(clienteReconstruido.id, equals(cliente.id));
      expect(clienteReconstruido.nome, equals(cliente.nome));
      expect(clienteReconstruido.cpf, equals(cliente.cpf));
      expect(clienteReconstruido.email, equals(cliente.email));
      expect(clienteReconstruido.telefone, equals(cliente.telefone));
      expect(clienteReconstruido.endereco, equals(cliente.endereco));
    });
  });

  group('ItemNotaFiscal - Serialização JSON', () {
    test('deve serializar e desserializar corretamente', () {
      // Arrange
      final item = ItemNotaFiscal(
        produtoId: 1,
        produtoNome: 'Notebook Dell',
        produtoCodigo: 'NOTE-001',
        quantidade: 2,
        precoUnitario: 3500.00,
      );

      // Act
      final json = item.toJson();
      final itemReconstruido = ItemNotaFiscal.fromJson(json);

      // Assert
      expect(itemReconstruido.produtoId, equals(item.produtoId));
      expect(itemReconstruido.produtoNome, equals(item.produtoNome));
      expect(itemReconstruido.produtoCodigo, equals(item.produtoCodigo));
      expect(itemReconstruido.quantidade, equals(item.quantidade));
      expect(itemReconstruido.precoUnitario, equals(item.precoUnitario));
      expect(itemReconstruido.valorTotal, equals(item.valorTotal));
    });
  });

  group('NotaFiscal - Serialização JSON', () {
    test('deve serializar e desserializar corretamente', () {
      // Arrange
      final item = ItemNotaFiscal(
        produtoId: 1,
        produtoNome: 'Notebook Dell',
        produtoCodigo: 'NOTE-001',
        quantidade: 2,
        precoUnitario: 3500.00,
      );

      final nota = NotaFiscal(
        id: 1,
        numeroNota: 'NF-001',
        clienteId: 1,
        clienteNome: 'João Silva',
        clienteCpf: '123.456.789-00',
        itens: [item],
        formaPagamento: 'Cartão de Crédito',
      );

      // Act
      final json = nota.toJson();
      final notaReconstruida = NotaFiscal.fromJson(json);

      // Assert
      expect(notaReconstruida.id, equals(nota.id));
      expect(notaReconstruida.numeroNota, equals(nota.numeroNota));
      expect(notaReconstruida.clienteId, equals(nota.clienteId));
      expect(notaReconstruida.clienteNome, equals(nota.clienteNome));
      expect(notaReconstruida.clienteCpf, equals(nota.clienteCpf));
      expect(notaReconstruida.formaPagamento, equals(nota.formaPagamento));
      expect(notaReconstruida.valorTotal, equals(nota.valorTotal));
      expect(notaReconstruida.itens.length, equals(1));
      expect(notaReconstruida.itens[0].produtoNome, equals('Notebook Dell'));
    });
  });
}
