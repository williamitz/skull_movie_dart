import 'package:flutter/material.dart';

class LigthTheme {
  static const _primary = Colors.indigo;

  static MaterialColor get primary {
    return _primary;
  }

  static final ThemeData theme = ThemeData.light().copyWith(

    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      elevation: 0.0
    )

  );
}
