import 'package:go_router/go_router.dart';
import 'package:myeg_flutter_test/core/model/product.dart';
import 'package:myeg_flutter_test/features/cart/view/cart_page.dart';
import 'package:myeg_flutter_test/features/product/product.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'products',
      path: '/',
      builder: (context, state) => ProductListPage(),
      routes: [
        GoRoute(
          path: 'details',
          builder: (context, state) {
            Product product = state.extra as Product;
            return ProductDetailsPage(product: product);
          },
        ),
      ],
    ),
    GoRoute(name: 'cart', path: '/cart', builder: (context, state) => CartPage()),
  ],
);
