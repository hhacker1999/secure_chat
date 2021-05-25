// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../managers/auth_manager.dart' as _i4;
import '../managers/chat_manager.dart' as _i6;
import '../managers/contacts_manager.dart' as _i7;
import '../services/auth_service.dart' as _i5;
import '../services/contacts_service.dart' as _i3;
import '../services/firebase_service.dart' as _i8;
import '../services/local_data_service.dart' as _i10;
import '../services/permission_handler.dart' as _i12;
import '../views/homeview/home_view_model/homeviewmodel.dart' as _i9;
import '../views/login_view/login_view_model/login_view_model.dart' as _i11;
import '../views/startup_view/startup_view_model/startupviewmodel.dart'
    as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AppContactsService>(() => _i3.AppContactsService());
  gh.lazySingleton<_i4.AuthManager>(() => _i4.AuthManager());
  gh.lazySingleton<_i5.AuthService>(() => _i5.AuthService());
  gh.lazySingleton<_i6.ChatManager>(() => _i6.ChatManager());
  gh.lazySingleton<_i7.ContactsManager>(() => _i7.ContactsManager());
  gh.lazySingleton<_i8.FirebaseService>(() => _i8.FirebaseService());
  gh.lazySingleton<_i9.Homeviewmodel>(() => _i9.Homeviewmodel());
  gh.lazySingleton<_i10.LocalDataService>(() => _i10.LocalDataService());
  gh.lazySingleton<_i11.LoginViewModel>(() => _i11.LoginViewModel());
  gh.lazySingleton<_i12.PermissionHandlerServices>(
      () => _i12.PermissionHandlerServices());
  gh.lazySingleton<_i13.StartupViewModel>(() => _i13.StartupViewModel());
  return get;
}
