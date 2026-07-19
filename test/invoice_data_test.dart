import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/core/models/invoice_type.dart';

void main() {
  group('InvoiceData', () {
    test('deve aceitar cliente em nota de entrada', () {
      final invoiceData = InvoiceData(
        invoiceNumber: 'NF-0001',
        type: InvoiceType.entry,
        customerId: 1,
        customerName: 'Cliente Teste',
        customerCpf: '000.000.000-00',
        items: [
          InvoiceItem(
            productId: 1,
            productName: 'Produto',
            productCode: 'PROD-1',
            quantity: 2,
            unitPrice: 10,
          ),
        ],
        paymentMethod: 'pix',
      );

      expect(invoiceData.type, InvoiceType.entry);
      expect(invoiceData.customerId, 1);
      expect(invoiceData.companyId, isNull);
      expect(invoiceData.totalValue, 20);
    });

    test('deve aceitar empresa em nota de saída', () {
      final invoiceData = InvoiceData(
        invoiceNumber: 'NF-0002',
        companyId: 2,
        companyName: 'Empresa Teste',
        companyCnpj: '00.000.000/0001-00',
        items: [
          InvoiceItem(
            productId: 1,
            productName: 'Produto',
            productCode: 'PROD-1',
            quantity: 1,
            unitPrice: 20,
          ),
        ],
        paymentMethod: 'cash',
      );

      expect(invoiceData.type, InvoiceType.exit);
      expect(invoiceData.companyId, 2);
      expect(invoiceData.companyName, 'Empresa Teste');
      expect(invoiceData.companyCnpj, '00.000.000/0001-00');
      expect(invoiceData.customerId, isNull);
      expect(invoiceData.totalValue, 20);
    });

    test('personDisplayName retorna nome do cliente quando vinculado', () {
      final invoiceData = InvoiceData(
        invoiceNumber: 'NF-0010',
        customerId: 1,
        customerName: 'Maria',
        customerCpf: '111.111.111-11',
        items: [
          InvoiceItem(
            productId: 1,
            productName: 'P',
            productCode: 'C1',
            quantity: 1,
            unitPrice: 10,
          ),
        ],
        paymentMethod: 'pix',
      );

      expect(invoiceData.personDisplayName, 'Maria');
      expect(invoiceData.personDocument, '111.111.111-11');
    });

    test('personDisplayName retorna nome da empresa quando vinculado', () {
      final invoiceData = InvoiceData(
        invoiceNumber: 'NF-0011',
        companyId: 1,
        companyName: 'Empresa X',
        companyCnpj: '22.222.222/0001-22',
        items: [
          InvoiceItem(
            productId: 1,
            productName: 'P',
            productCode: 'C1',
            quantity: 1,
            unitPrice: 10,
          ),
        ],
        paymentMethod: 'cash',
      );

      expect(invoiceData.personDisplayName, 'Empresa X');
      expect(invoiceData.personDocument, '22.222.222/0001-22');
    });

    test('deve lançar erro quando cliente e empresa não são informados', () {
      expect(
        () => InvoiceData(
          invoiceNumber: 'NF-0003',
          type: InvoiceType.entry,
          items: [
            InvoiceItem(
              productId: 1,
              productName: 'Produto',
              productCode: 'PROD-1',
              quantity: 1,
              unitPrice: 20,
            ),
          ],
          paymentMethod: 'cash',
        ),
        throwsArgumentError,
      );
    });

    test('deve lançar erro quando cliente e empresa são informados juntos', () {
      expect(
        () => InvoiceData(
          invoiceNumber: 'NF-0004',
          customerId: 1,
          customerName: 'Cliente Teste',
          customerCpf: '000.000.000-00',
          companyId: 2,
          items: [
            InvoiceItem(
              productId: 1,
              productName: 'Produto',
              productCode: 'PROD-1',
              quantity: 1,
              unitPrice: 20,
            ),
          ],
          paymentMethod: 'pix',
        ),
        throwsArgumentError,
      );
    });
  });
}
