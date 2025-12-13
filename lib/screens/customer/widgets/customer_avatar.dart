import 'package:flutter/material.dart';

/// Widget que exibe um avatar circular com a inicial do nome do cliente.
class CustomerAvatar extends StatelessWidget {
  final String name;

  const CustomerAvatar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final trimmedName = name.trim();
    return Center(
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.blue,
        child: Text(
          trimmedName.isNotEmpty ? trimmedName[0].toUpperCase() : '?',
          style: const TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
