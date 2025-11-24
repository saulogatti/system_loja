import 'dart:io';

/// Helper para leitura de entrada do usuário
class InputHelper {
  /// Lê uma string do usuário
  static String? lerString(String prompt, {bool obrigatorio = false}) {
    while (true) {
      stdout.write('$prompt: ');
      final input = stdin.readLineSync()?.trim();
      
      if (obrigatorio && (input == null || input.isEmpty)) {
        print('Erro: Este campo é obrigatório!');
        continue;
      }
      
      return input;
    }
  }

  /// Lê um número inteiro do usuário
  static int? lerInt(String prompt, {bool obrigatorio = false}) {
    while (true) {
      stdout.write('$prompt: ');
      final input = stdin.readLineSync()?.trim();
      
      if (!obrigatorio && (input == null || input.isEmpty)) {
        return null;
      }
      
      if (input == null || input.isEmpty) {
        print('Erro: Este campo é obrigatório!');
        continue;
      }
      
      final valor = int.tryParse(input);
      if (valor == null) {
        print('Erro: Valor inválido! Digite um número inteiro.');
        continue;
      }
      
      return valor;
    }
  }

  /// Lê um número decimal do usuário
  static double? lerDouble(String prompt, {bool obrigatorio = false}) {
    while (true) {
      stdout.write('$prompt: ');
      final input = stdin.readLineSync()?.trim();
      
      if (!obrigatorio && (input == null || input.isEmpty)) {
        return null;
      }
      
      if (input == null || input.isEmpty) {
        print('Erro: Este campo é obrigatório!');
        continue;
      }
      
      // Substitui vírgula por ponto para aceitar ambos os formatos
      final inputNormalizado = input.replaceAll(',', '.');
      
      final valor = double.tryParse(inputNormalizado);
      if (valor == null) {
        print('Erro: Valor inválido! Digite um número decimal.');
        continue;
      }
      
      return valor;
    }
  }
}
