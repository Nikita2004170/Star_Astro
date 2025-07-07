import 'package:flutter/material.dart';

class ContextUtility {
  static BuildContext? _appContext;

  // Set context globally
  static setAppContext(BuildContext context) {
    _appContext = context;
  }

  // Get the context
  static BuildContext? get context => _appContext;
}
