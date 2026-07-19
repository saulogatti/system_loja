import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/screens/widgets/address_form.dart';

void main() {
  testWidgets(
    'AddressForm fields have correct keyboardType, autofillHints, and textInputAction',
    (tester) async {
      final streetController = TextEditingController();
      final zipCodeController = TextEditingController();
      final neighborhoodController = TextEditingController();
      final cityController = TextEditingController();
      final stateController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AddressForm(
                streetController: streetController,
                zipCodeController: zipCodeController,
                neighborhoodController: neighborhoodController,
                cityController: cityController,
                stateController: stateController,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Endereço'), findsOneWidget);

      // Get fields
      final fields = tester
          .widgetList<TextField>(find.byType(TextField))
          .toList();

      // TextField widgets wrap the TextFormField data internally.
      // Field 0: Rua
      expect(fields[0].keyboardType, TextInputType.streetAddress);
      expect(
        fields[0].autofillHints,
        contains(AutofillHints.streetAddressLine1),
      );
      expect(fields[0].textInputAction, TextInputAction.next);

      // Field 1: CEP
      expect(fields[1].keyboardType, TextInputType.number);
      expect(fields[1].autofillHints, contains(AutofillHints.postalCode));
      expect(fields[1].textInputAction, TextInputAction.next);

      // Field 2: Bairro
      expect(fields[2].autofillHints, contains(AutofillHints.sublocality));
      expect(fields[2].textInputAction, TextInputAction.next);

      // Field 3: Cidade
      expect(fields[3].autofillHints, contains(AutofillHints.addressCity));
      expect(fields[3].textInputAction, TextInputAction.next);

      // Check Estado dropdown
      expect(
        find.widgetWithText(DropdownButtonFormField<BrazilianState>, 'Estado'),
        findsOneWidget,
      );
    },
  );
}
