import 'package:flutter/material.dart';

extension AppThemeExtension on BuildContext {
  // ---------- THEME EXTENSION ----------
  ThemeData get _theme => Theme.of(this);
  ColorScheme get colors => _theme.colorScheme;
  TextTheme get texts => _theme.textTheme;

  // ---------- SCREEN SIZES ----------
  Size get _sizeOf => MediaQuery.sizeOf(this);
  double get screenHeight => _sizeOf.height;
  double get screenWidth => _sizeOf.width;

  MediaQueryData get _mediaQuery => MediaQuery.of(this);
  double get statusBarHeight => _mediaQuery.padding.top;
  double get keyboardHeight => _mediaQuery.viewInsets.bottom;

  // ---------- FOCUS NODE  ----------
  FocusScopeNode get _focusScope => FocusScope.of(this);
  VoidCallback get nextFocus => _focusScope.nextFocus;
  VoidCallback get unFocus => _focusScope.unfocus;

  // ---------- SCAFFOLD MESSENGER ----------
  ScaffoldMessengerState get _messenger => ScaffoldMessenger.of(this);
  VoidCallback get hideCurrentSnackBar => _messenger.hideCurrentSnackBar;
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    SnackBar snackBar,
  ) => _messenger.showSnackBar(snackBar);
}
