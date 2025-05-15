import 'package:flutter/cupertino.dart';

extension ConvertPrice on double? {
  toPrice() {
    if (this != null) {
      return "RM ${this!.toStringAsFixed(2)}";
    }
    return "-";
  }
}

extension SpacingUtil on num {
  get ph => SizedBox(height: toDouble());

  get pw => SizedBox(width: toDouble());
}
