import 'package:flutter/material.dart';

abstract class LoginTheme {
  static final borderDefault = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.zero),
  );
  static final borderError = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.zero),
    borderSide: BorderSide(color: Colors.red),
  );
}
