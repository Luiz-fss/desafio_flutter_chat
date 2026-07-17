import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final GetIt _getIt = GetIt.instance;

  static void register<T extends Object>(
      T instance,
      ) {
    assert(
    !_getIt.isRegistered<T>(),
    'Service $T já registrado',
    );

    if (!_getIt.isRegistered<T>()) {
      _getIt.registerSingleton<T>(instance);
    }
  }

  static void registerLazy<T extends Object>(
      T Function() factory,
      ) {
    assert(
    !_getIt.isRegistered<T>(),
    'Service $T já registrado',
    );

    if (!_getIt.isRegistered<T>()) {
      _getIt.registerLazySingleton<T>(factory);
    }
  }

  static T get<T extends Object>() {
    return _getIt<T>();
  }

  static bool isRegistered<T extends Object>() {
    return _getIt.isRegistered<T>();
  }

  static Future<void> reset() async {
    await _getIt.reset();
  }
}