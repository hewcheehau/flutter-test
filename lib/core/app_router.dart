import 'package:go_router/go_router.dart';
import 'package:myeg_flutter_test/features/cart/view/cart_page.dart';
import 'package:myeg_flutter_test/features/product/view/product_list_page.dart';

final router = GoRouter(initialLocation: '/', routes: [GoRoute(name: 'products', path: '/', builder: (context, state) => ProductListPage()),
GoRoute(name: 'cart', path: '/cart', builder: (context, state) => CartPage())
]);
