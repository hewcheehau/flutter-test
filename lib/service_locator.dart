import 'package:get_it/get_it.dart' show GetIt;
import 'package:myeg_flutter_test/core/network/dio_client.dart';
import 'package:myeg_flutter_test/core/network/product_api.dart';
import 'package:myeg_flutter_test/core/network/product_repository.dart';

final sl = GetIt.instance;

Future<void> setup() async {

  sl.registerLazySingleton<DioClient>(() => DioClient(baseUrl: "https://fakestoreapi.com/"));
  sl.registerSingleton<ProductApi>(ProductApi());
  sl.registerSingleton<ProductRepository>(ProductRepository(productApi: sl()));
}