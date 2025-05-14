import 'package:flutter/material.dart';
import 'package:myeg_flutter_test/core/app_router.dart';

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}