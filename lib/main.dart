import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/repository/system/user_repository.dart';
import 'package:system_loja/screens/company/bloc/company_bloc.dart';
import 'package:system_loja/screens/configuracoes/bloc/logs_cubit.dart';
import 'package:system_loja/screens/configuracoes/bloc/user_cubit.dart';
import 'package:system_loja/screens/customer/bloc/customer_bloc.dart';
import 'package:system_loja/screens/injection/app_injection.dart';
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInjection.instance.initializeDependencies();
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
        BlocProvider<CompanyBloc>(create: (context) => CompanyBloc()),
        BlocProvider<SalesCubit>(create: (context) => SalesCubit()),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(UserRepository()),
        ),
        BlocProvider(create: (context) => LogsCubit()),
      ],
      child: ValueListenableBuilder(
        valueListenable:
            AppInjection.instance.settingsService.currentThemeNotifier,
        builder: (context, value, child) {
          return MaterialApp.router(
            title: 'Sistema de Gerenciamento de Loja',
            theme: value,
            themeMode: AppInjection.instance.settingsService.temaEscuro
                ? ThemeMode.dark
                : ThemeMode.light,
            routerConfig: AppInjection.instance.routeApp.config(),
            debugShowCheckedModeBanner: kDebugMode,
          );
        },
      ),
    );
  }
}
