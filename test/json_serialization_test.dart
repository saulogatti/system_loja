// import 'package:flutter_test/flutter_test.dart';
// import 'package:system_loja/core/models/customer.dart';
// import 'package:system_loja/core/models/invoice.dart';
// import 'package:system_loja/core/models/invoice_item.dart';
// import 'package:system_loja/core/models/product.dart';
// /// Testes de serialização JSON
// ///
// /// Valida que os métodos toJson() e fromJson() funcionam corretamente
// /// para todos os modelos após a refatoração.
// void main() {
//   group('Produto - Serialização JSON', () {
//     test('deve serializar e desserializar corretamente', () {
//       // Arrange
//       final produto = Product(
//         id: 1,
//         name: 'Notebook Dell',
//         code: 'NOTE-001',
//         price: 3500.00,
//         stockQuantity: 10,
//         description: 'Notebook Dell Inspiron 15',
//         category: 'Eletrônicos',
//       );

//       // Act
//       final json = produto.toJson();
//       final produtoReconstruido = Product.fromJson(json);

//       // Assert
//       expect(produtoReconstruido.id, equals(produto.id));
//       expect(produtoReconstruido.name, equals(produto.name));
//       expect(produtoReconstruido.code, equals(produto.code));
//       expect(produtoReconstruido.price, equals(produto.price));
//       expect(produtoReconstruido.stockQuantity, equals(produto.stockQuantity));
//       expect(produtoReconstruido.description, equals(produto.description));
//       expect(produtoReconstruido.category, equals(produto.category));
//     });
//   });

//   group('Cliente - Serialização JSON', () {
//     test('deve serializar e desserializar corretamente', () {
//       // Arrange
//       final cliente = Customer(
//         id: 1,
//         name: 'João Silva',
//         cpf: '123.456.789-00',
//         email: 'joao@email.com',
//         phone: '(11) 98765-4321',
//         address: 'Rua A, 123',
//       );

//       // Act
//       final json = cliente.toJson();
//       final clienteReconstruido = Customer.fromJson(json);

//       // Assert
//       expect(clienteReconstruido.id, equals(cliente.id));
//       expect(clienteReconstruido.name, equals(cliente.name));
//       expect(clienteReconstruido.cpf, equals(cliente.cpf));
//       expect(clienteReconstruido.email, equals(cliente.email));
//       expect(clienteReconstruido.phone, equals(cliente.phone));
//       expect(clienteReconstruido.address, equals(cliente.address));
//     });
//   });

//   group('ItemNotaFiscal - Serialização JSON', () {
//     test('deve serializar e desserializar corretamente', () {
//       // Arrange
//       final item = InvoiceItem(
//         productId: 1,
//         productName: 'Notebook Dell',
//         productCode: 'NOTE-001',
//         quantity: 2,
//         unitPrice: 3500.00,
//       );

//       // Act
//       final json = item.toJson();
//       final itemReconstruido = InvoiceItem.fromJson(json);

//       // Assert
//       expect(itemReconstruido.productId, equals(item.productId));
//       expect(itemReconstruido.productName, equals(item.productName));
//       expect(itemReconstruido.productCode, equals(item.productCode));
//       expect(itemReconstruido.quantity, equals(item.quantity));
//       expect(itemReconstruido.unitPrice, equals(item.unitPrice));
//       expect(itemReconstruido.totalValue, equals(item.totalValue));
//     });
//   });

//   group('Invoice - Serialização JSON', () {
//     test('deve serializar e desserializar corretamente', () {
//       // Arrange
//       final item = InvoiceItem(
//         productId: 1,
//         productName: 'Notebook Dell',
//         productCode: 'NOTE-001',
//         quantity: 2,
//         unitPrice: 3500.00,
//       );

//       final invoice = Invoice(
//         id: 1,
//         data: InvoiceData(
//           invoiceNumber: 'NF-001',
//           customerId: 1,
//           customerName: 'João Silva',
//           customerCpf: '123.456.789-00',
//           items: [item],
//           paymentMethod: 'Cartão de Crédito',
//         ),
//       );

//       // Act
//       final json = invoice.toJson();
//       final invoiceReconstruido = Invoice.fromJson(json);

//       // Assert
//       expect(invoiceReconstruido.id, equals(invoice.id));
//       expect(invoiceReconstruido.data.invoiceNumber, equals(invoice.data.invoiceNumber));
//       expect(invoiceReconstruido.data.customerId, equals(invoice.data.customerId));
//       expect(invoiceReconstruido.data.customerName, equals(invoice.data.customerName));
//       expect(invoiceReconstruido.data.customerCpf, equals(invoice.data.customerCpf));
//       expect(invoiceReconstruido.data.paymentMethod, equals(invoice.data.paymentMethod));
//       expect(invoiceReconstruido.data.totalValue, equals(invoice.data.totalValue));
//       expect(invoiceReconstruido.data.items.length, equals(1));
//       expect(invoiceReconstruido.data.items[0].productName, equals('Notebook Dell'));
//     });
//   });
// }
