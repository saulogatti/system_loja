enum EnumColorAppThemeSettings {
  azul,
  verde,
  laranka,
  roxo,
  vermelho,
  rosa,
  ciano,
  indigo;

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
