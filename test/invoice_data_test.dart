import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/core/models/invoice_type.dart';

void main() {
  group('InvoiceData', () {
    test(
      'deve aceitar cliente em nota de entrada',
      () {
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
      },
    );

    test(
      'deve aceitar empresa em nota de saída',
      () {
        final invoiceData = InvoiceData(
          invoiceNumber: 'NF-0002',
          type: InvoiceType.exit,
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
          paymentMethod: 'cash',
        );

        expect(invoiceData.type, InvoiceType.exit);
        expect(invoiceData.companyId, 2);
        expect(invoiceData.customerId, isNull);
        expect(invoiceData.totalValue, 20);
      },
    );

    test(
      'deve lançar erro quando cliente e empresa não são informados',
      () {
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
      },
    );

    test(
      'deve lançar erro quando cliente e empresa são informados juntos',
      () {
        expect(
          () => InvoiceData(
            invoiceNumber: 'NF-0004',
            type: InvoiceType.exit,
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
      },
    );
  });
}
