import 'package:myeg_flutter_test/core/network/dio_client.dart';
import 'package:myeg_flutter_test/service_locator.dart';

class ProductApi {
  final dioClient = sl<DioClient>();

  Future<dynamic> getProductList() async {
    return dioClient.get('products');
  }
}
