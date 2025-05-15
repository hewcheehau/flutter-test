import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myeg_flutter_test/core/app_router.dart';
import 'package:myeg_flutter_test/core/network/product_repository.dart';
import 'package:myeg_flutter_test/features/product/bloc/product_list_bloc.dart';
import 'package:myeg_flutter_test/service_locator.dart';

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => ProductListBloc(productRepository: sl<ProductRepository>())..add(ProductListFetched()))],
      child: MaterialApp.router(routerConfig: router),
    );
  }
}
