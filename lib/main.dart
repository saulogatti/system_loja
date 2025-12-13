import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/screens/customer/bloc/customer_bloc.dart';
import 'package:system_loja/screens/sales/sales_cubit.dart';
import 'package:system_loja/screens/settings/settings_service.dart';

import 'screens/home/home_screen.dart';

void main() {
  runApp(const SystemLojaApp());
}

class SystemLojaApp extends StatelessWidget {
  const SystemLojaApp({super.key});

  @override
  Widget build(BuildContext context) {
    //sem add event aqui, apeans o bloc provider
    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomerBloc>(create: (context) => CustomerBloc()),
        BlocProvider<SalesCubit>(create: (context) => SalesCubit()),
      ],
      child: ValueListenableBuilder(
        valueListenable: SettingsService().primaryColorNotifier,
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Sistema de Gerenciamento de Loja',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: value.color),
              useMaterial3: true,
            ),
            home: const HomeScreen(),
            debugShowCheckedModeBanner: kDebugMode,
          );
        },
      ),
    );
  }
}
