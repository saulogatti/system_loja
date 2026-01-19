import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/repository/user_repository.dart';
import 'package:system_loja/screens/configuracoes/bloc/usuario_cubit.dart';
import 'package:system_loja/screens/customer/bloc/customer_bloc.dart';
import 'package:system_loja/screens/sales/sales_cubit.dart';
import 'package:system_loja/screens/settings/settings_service.dart';

import 'screens/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        BlocProvider<UsuarioCubit>(
          create: (context) => UsuarioCubit(UserRepository()),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: SettingsService().primaryColorNotifier,
        builder: (context, value, child) {
          print(
            ' Rebuild MaterialApp with color: ${value.colorScheme.primary} and dark mode: ${value.brightness == Brightness.dark}',
          );
          return MaterialApp(
            title: 'Sistema de Gerenciamento de Loja',
            theme: value,
            home: const HomeScreen(),
            debugShowCheckedModeBanner: kDebugMode,
          );
        },
      ),
    );
  }
}
