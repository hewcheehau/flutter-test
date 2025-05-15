import 'package:flutter/material.dart';
import 'package:myeg_flutter_test/app.dart';
import 'package:myeg_flutter_test/service_locator.dart';

void main() async {
  await setup();
  runApp(const ProductApp());
}
