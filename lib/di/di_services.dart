import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_astro/lib/repository/chat_repository.dart';
import 'package:star_astro/lib/repository/horoscope_repository.dart';
import 'package:star_astro/lib/repository/user_repository.dart';
import 'package:star_astro/lib/repository/base_repository.dart';
import 'package:star_astro/lib/repository/order_repository.dart';
import 'package:star_astro/lib/webservice/dio_setting.dart';

GetIt getIt = GetIt.instance;

Future<void> getServices() async {
  /// Async packages
  var preferences = await SharedPreferences.getInstance();

  getIt.registerSingleton<SharedPreferences>(preferences);

  ///Sync packages
  getIt.registerFactory(() => Connectivity());
  var dio = Dio();
  var logger = Logger();
  // final packageInfo = await PackageInfo.fromPlatform();
  // getIt.registerSingleton(packageInfo);
  getIt.registerSingleton(dio);
  getIt.registerSingleton(logger);
  // getIt.registerSingleton<AppRouter>(AppRouter());

  // /// Repositories
  getIt.registerFactory<BaseRepository>(() => BaseRepository());
  getIt.registerFactory<OrderRepository>(() => OrderRepositoryImp());
  getIt.registerFactory<UserRepository>(() => UserRepositoryImp());
  getIt.registerFactory<HoroscopeRepository>(() => HoroscopeRepositoryImp());
  getIt.registerFactory<ChatRepository>(() => ChatRepositoryImp());

  /// Init custom DIO settings for network calls
  DioSettings(dio: dio, logger: logger, preferences: preferences);
}

resetProviders() async {
  await getIt.reset();
}
