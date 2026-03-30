import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_type.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart';
import 'package:system_loja/screens/sales/cubit/sales_state.dart';
import 'package:system_loja/screens/sales/cubit/sales_invoice_cubit.dart';
import 'package:system_loja/screens/sales/cubit/sales_invoice_state.dart';
import 'package:system_loja/screens/sales/cubit/sales_state.dart';
import 'package:system_loja/screens/sales/models/person_selection.dart';

void main() {
  late _FakeSalesCubit salesCubit;

  Product product({required int id, int stock = 100, double price = 10}) {
    return Product(name: 'P$id', description: '', price: price, stockQuantity: stock, code: 'C$id', id: id);
  }

  Customer customer({int id = 1}) {
    return Customer(name: 'João', cpf: '00000000000', id: id);
  }

  setUp(() {
    salesCubit = _FakeSalesCubit();
  });

  group('SalesInvoiceCubit', () {
    test('total soma linhas corretamente', () {
      final cubit = SalesInvoiceCubit(salesCubit: salesCubit, paymentMethods: [PaymentMethodType.pix]);
      final p1 = product(id: 1, price: 10);
      final p2 = product(id: 2, price: 5);
      cubit.addOrMergeLine(p1, 2);
      cubit.addOrMergeLine(p2, 3);
      expect(cubit.state.form.computeTotal(), 10 * 2 + 5 * 3);
    });

    test('saída com quantidade acima do estoque emite SalesInvoiceFeedback', () {
      final cubit = SalesInvoiceCubit(salesCubit: salesCubit, paymentMethods: [PaymentMethodType.pix]);
      final p = product(id: 1, stock: 5);
      cubit.addOrMergeLine(p, 10);
      expect(cubit.state, isA<SalesInvoiceFeedback>());
      expect((cubit.state as SalesInvoiceFeedback).message, contains('Estoque insuficiente'));
    });

    test('entrada permite quantidade acima do estoque', () {
      final cubit = SalesInvoiceCubit(salesCubit: salesCubit, paymentMethods: [PaymentMethodType.pix]);
      cubit.setInvoiceType(InvoiceType.entry);
      final p = product(id: 1, stock: 5);
      cubit.addOrMergeLine(p, 10);
      expect(cubit.state, isA<SalesInvoiceEditing>());
      expect(cubit.state.form.linesByProductId[1]?.quantity, 10);
    });

    test('merge soma quantidade do mesmo produto', () {
      final cubit = SalesInvoiceCubit(salesCubit: salesCubit, paymentMethods: [PaymentMethodType.pix]);
      final p = product(id: 1, stock: 100);
      cubit.addOrMergeLine(p, 2);
      cubit.addOrMergeLine(p, 3);
      expect(cubit.state.form.linesByProductId[1]?.quantity, 5);
      expect(cubit.state.form.buildOrderedLines().length, 1);
    });

    test('submit chama registerSale quando válido', () {
      final cubit = SalesInvoiceCubit(salesCubit: salesCubit, paymentMethods: [PaymentMethodType.pix]);
      cubit.updateInvoiceNumber('1');
      cubit.setPerson(CustomerSelection(customer()));
      cubit.addOrMergeLine(product(id: 1, stock: 10), 1);
      cubit.submit();
      expect(salesCubit.registerSaleCalls, 1);
    });

    test('submit sem itens emite feedback com mensagem', () {
      final cubit = SalesInvoiceCubit(salesCubit: salesCubit, paymentMethods: [PaymentMethodType.pix]);
      cubit.setPerson(CustomerSelection(customer()));
      cubit.submit();
      expect(cubit.state, isA<SalesInvoiceFeedback>());
      expect((cubit.state as SalesInvoiceFeedback).message, contains('item'));
      expect(salesCubit.registerSaleCalls, 0);
    });

    test('consumeFeedback volta para editing', () {
      final cubit = SalesInvoiceCubit(salesCubit: salesCubit, paymentMethods: [PaymentMethodType.pix]);
      cubit.submit();
      expect(cubit.state, isA<SalesInvoiceFeedback>());
      cubit.consumeFeedback();
      expect(cubit.state, isA<SalesInvoiceEditing>());
    });
  });
}

/// [SalesCubit] mínimo para testes: só [registerSale] é usado pelo [SalesInvoiceCubit].
class _FakeSalesCubit extends Fake implements SalesCubit {
  int registerSaleCalls = 0;

  @override
  Stream<SalesState> get stream => Stream.value(SalesSaved(items: {}));

  @override
  Future<void> registerSale(InvoiceData invoiceData, bool enableCodeGeneration) async {
    registerSaleCalls++;
  }

  @override
  Stream<SalesState> get stream => Stream.value(SalesState.saved(items: {}));

  @override
  bool get isClosed => false;
}
