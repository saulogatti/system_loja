import 'package:flutter/material.dart';

 
enum EnumColorAppThemeSettings {
  azul,
  verde,
  laranka,
  roxo,
  vermelho,
  rosa,
  ciano,
  indigo;

  Color get color {
    switch (this) {
      case EnumColorAppThemeSettings.azul:
        return Colors.blue;
      case EnumColorAppThemeSettings.verde:
        return Colors.green;
      case EnumColorAppThemeSettings.laranka:
        return Colors.orange;
      case EnumColorAppThemeSettings.roxo:
        return Colors.purple;
      case EnumColorAppThemeSettings.vermelho:
        return Colors.red;
      case EnumColorAppThemeSettings.rosa:
        return Colors.pink;
      case EnumColorAppThemeSettings.ciano:
        return Colors.cyan;
      case EnumColorAppThemeSettings.indigo:
        return Colors.indigo;
    }
  }
  String get name {
    switch (this) {
      case EnumColorAppThemeSettings.azul:
        return 'Azul';
      case EnumColorAppThemeSettings.verde:
        return 'Verde';
      case EnumColorAppThemeSettings.laranka:
        return 'Laranja';
      case EnumColorAppThemeSettings.roxo:
        return 'Roxo';
      case EnumColorAppThemeSettings.vermelho:
        return 'Vermelho';
      case EnumColorAppThemeSettings.rosa:
        return 'Rosa';
      case EnumColorAppThemeSettings.ciano:
        return 'Ciano';
      case EnumColorAppThemeSettings.indigo:
        return 'Indigo';
    }
  }
}
