// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:system_loja/core/models/customer.dart';
// import 'package:system_loja/screens/route/route_app.gr.dart';

// /// Exibe um bottom sheet com visão geral dos dados do cliente.
// ///
// /// Mostra as informações principais do cliente e oferece ação de navegação
// /// para a tela de edição completa.
// class CustomerOverviewBottomSheet extends StatelessWidget {
//   /// Cliente cujas informações serão exibidas.
//   final Customer customer;

//   /// Cria uma instância de [CustomerOverviewBottomSheet].
//   const CustomerOverviewBottomSheet({required this.customer, super.key});

//   /// Exibe o bottom sheet de visão geral do cliente.
//   static Future<void> show(BuildContext context, Customer customer) {
//     return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (_) => CustomerOverviewBottomSheet(customer: customer),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Center(
//               child: Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.outlineVariant,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 28,
//                   backgroundColor: Colors.blue,
//                   child: Text(
//                     customer.name[0].toUpperCase(),
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         customer.name,
//                         style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'CPF: ${customer.cpf}',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: Theme.of(context).colorScheme.onSurfaceVariant,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(height: 32),
//             if (customer.email != null && customer.email!.isNotEmpty)
//               _InfoRow(
//                 icon: Icons.email_outlined,
//                 label: 'E-mail',
//                 value: customer.email!,
//               ),
//             if (customer.phone != null && customer.phone!.isNotEmpty)
//               _InfoRow(
//                 icon: Icons.phone_outlined,
//                 label: 'Telefone',
//                 value: customer.phone!,
//               ),
//             if (customer.address.city.isNotEmpty)
//               _InfoRow(
//                 icon: Icons.location_on_outlined,
//                 label: 'Endereço',
//                 value:
//                     '${customer.address.street}, ${customer.address.neighborhood} — ${customer.address.city}/${customer.address.state}',
//               ),
//             const SizedBox(height: 24),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 context.router.root.push(CustomerRoute(customer: customer));
//               },
//               icon: const Icon(Icons.edit),
//               label: const Text('Editar Cliente'),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//               ),
//             ),
//             const SizedBox(height: 8),
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Fechar'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// Linha de informação com ícone, rótulo e valor.
// class _InfoRow extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;

//   const _InfoRow({
//     required this.icon,
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                     color: Theme.of(context).colorScheme.onSurfaceVariant,
//                   ),
//                 ),
//                 Text(value, style: Theme.of(context).textTheme.bodyMedium),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
