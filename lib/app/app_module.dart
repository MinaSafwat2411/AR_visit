import 'package:ar_visiting_app/app/app_module.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async => getIt.init();