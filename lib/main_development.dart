import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Target main_development.dart for listening to provider changes
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  /// For Flutter Error
  final log = Logger('Flutter Error');
  FlutterError.onError = (details) {
    log.severe(details.exceptionAsString(), details.exception, details.stack);
  };

  /// Load Env Variables
  await dotenv.load();

  bootstrap(observers: [Observer()]);
}

class Observer extends ProviderObserver {
  final log = Logger('Provider Observer');

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log.info(
        ' provider: ${provider.name ?? provider.runtimeType}, change: $previousValue $newValue');
  }
}
