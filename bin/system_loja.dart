import 'dart:io';
import 'package:system_loja/managers/cliente_manager.dart';
import 'package:system_loja/managers/produto_manager.dart';
import 'package:system_loja/managers/nota_fiscal_manager.dart';

/// Exibe o menu principal
void exibirMenuPrincipal() {
  print('\n${'=' * 50}');
  print('SISTEMA DE GERENCIAMENTO DE LOJA');
  print('=' * 50);
  print('1. Cadastro de Cliente');
  print('2. Cadastro de Produto');
  print('3. Cadastro de Nota Fiscal de Compra');
  print('4. Sair');
  print('=' * 50);
}

void main(List<String> arguments) {
  final clienteManager = ClienteManager();
  final produtoManager = ProdutoManager();
  final notaFiscalManager = NotaFiscalManager();

  while (true) {
    exibirMenuPrincipal();
    stdout.write('Escolha uma opção: ');
    final opcao = stdin.readLineSync()?.trim();

    switch (opcao) {
      case '1':
        clienteManager.menu();
        break;
      case '2':
        produtoManager.menu();
        break;
      case '3':
        notaFiscalManager.menu();
        break;
      case '4':
        print('\nEncerrando o sistema. Até logo!');
        return;
      default:
        print('\nOpção inválida! Tente novamente.');
    }
  }
}
