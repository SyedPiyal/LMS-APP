
import 'package:flutter/material.dart';

extension ContextUtils on BuildContext {
  ThemeData get theme => Theme.of(this);
}
