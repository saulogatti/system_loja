import 'package:flutter/material.dart';

class AddressForm extends StatelessWidget {
  final TextEditingController streetController;
  final TextEditingController zipCodeController;
  final TextEditingController neighborhoodController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  const AddressForm({
    super.key,
    required this.streetController,
    required this.zipCodeController,
    required this.neighborhoodController,
    required this.cityController,
    required this.stateController,
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
        TextFormField(
          controller: stateController,
          decoration: const InputDecoration(
            labelText: 'Estado',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_on),
          ),
        ),
      ],
    );
  }
}
