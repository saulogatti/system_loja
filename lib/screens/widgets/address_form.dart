import 'package:flutter/material.dart';
import 'package:system_loja/core/utils/text_formatters.dart';

class AddressForm extends StatelessWidget {
  /// Lista de estados brasileiros (UF)
  static const List<BrazilianState> brazilianStates = BrazilianState.values;
  final TextEditingController streetController;
  final TextEditingController zipCodeController;
  final TextEditingController neighborhoodController;
  final TextEditingController cityController;
  final TextEditingController stateController;

  const AddressForm({
    required this.streetController, required this.zipCodeController, required this.neighborhoodController, required this.cityController, required this.stateController, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Endereço',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: streetController,
          decoration: const InputDecoration(
            labelText: 'Rua',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_on),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: zipCodeController,
                decoration: const InputDecoration(
                  labelText: 'CEP',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.markunread_mailbox),
                  hintText: '00000-000',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [CepTextInputFormatter()],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: neighborhoodController,
                decoration: const InputDecoration(
                  labelText: 'Bairro',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.map),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: cityController,
          decoration: const InputDecoration(
            labelText: 'Cidade',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_city),
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<BrazilianState>(
          initialValue: stateController.text.isEmpty
              ? null
              : BrazilianState.values.firstWhere(
                  (state) => state.displayName == stateController.text,
                  orElse: () => BrazilianState.values.first,
                ),

          decoration: const InputDecoration(
            labelText: 'Estado',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.map),
          ),
          items: brazilianStates.map((BrazilianState state) {
            return DropdownMenuItem<BrazilianState>(
              value: state,
              child: Text(state.displayName),
            );
          }).toList(),
          onChanged: (BrazilianState? newValue) {
            if (newValue != null) {
              stateController.text = newValue.displayName;
            }
          },
        ),
      ],
    );
  }
}

enum BrazilianState {
  ac,
  al,
  ap,
  am,
  ba,
  ce,
  df,
  es,
  go,
  ma,
  mt,
  ms,
  mg,
  pa,
  pb,
  pr,
  pe,
  pi,
  rj,
  rn,
  rs,
  ro,
  rr,
  sc,
  sp,
  se,
  to;

  String get displayName {
    switch (this) {
      case BrazilianState.ac:
        return 'Acre';
      case BrazilianState.al:
        return 'Alagoas';
      case BrazilianState.ap:
        return 'Amapá';
      case BrazilianState.am:
        return 'Amazonas';
      case BrazilianState.ba:
        return 'Bahia';
      case BrazilianState.ce:
        return 'Ceará';
      case BrazilianState.df:
        return 'Distrito Federal';
      case BrazilianState.es:
        return 'Espírito Santo';
      case BrazilianState.go:
        return 'Goiás';
      case BrazilianState.ma:
        return 'Maranhão';
      case BrazilianState.mt:
        return 'Mato Grosso';
      case BrazilianState.ms:
        return 'Mato Grosso do Sul';
      case BrazilianState.mg:
        return 'Minas Gerais';
      case BrazilianState.pa:
        return 'Pará';
      case BrazilianState.pb:
        return 'Paraíba';
      case BrazilianState.pr:
        return 'Paraná';
      case BrazilianState.pe:
        return 'Pernambuco';
      case BrazilianState.pi:
        return 'Piauí';
      case BrazilianState.rj:
        return 'Rio de Janeiro';
      case BrazilianState.rn:
        return 'Rio Grande do Norte';
      case BrazilianState.rs:
        return 'Rio Grande do Sul';
      case BrazilianState.ro:
        return 'Rondônia';
      case BrazilianState.rr:
        return 'Roraima';
      case BrazilianState.sc:
        return 'Santa Catarina';
      case BrazilianState.sp:
        return 'São Paulo';
      case BrazilianState.se:
        return 'Sergipe';
      case BrazilianState.to:
        return 'Tocantins';
    }
  }
}
