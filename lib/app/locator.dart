import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nigga_chat/app/locator.config.dart';


final locator = GetIt.instance;

@InjectableInit()
void configureDependencies() => $initGetIt(locator);