// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../managers/auth_manager.dart' as _i4;
import '../managers/chat_manager.dart' as _i6;
import '../managers/contacts_manager.dart' as _i8;
import '../services/auth_service.dart' as _i5;
import '../services/contacts_service.dart' as _i3;
import '../services/firebase_service.dart' as _i9;
import '../services/local_data_service.dart' as _i11;
import '../services/permission_handler.dart' as _i13;
import '../views/chat_view/chat_view_model/chat_view_model.dart' as _i7;
import '../views/homeview/home_view_model/homeviewmodel.dart' as _i10;
import '../views/login_view/login_view_model/login_view_model.dart' as _i12;
import '../views/startup_view/startup_view_model/startupviewmodel.dart'
    as _i14; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AppContactsService>(() => _i3.AppContactsService());
  gh.lazySingleton<_i4.AuthManager>(() => _i4.AuthManager());
  gh.lazySingleton<_i5.AuthService>(() => _i5.AuthService());
  gh.lazySingleton<_i6.ChatManager>(() => _i6.ChatManager());
  gh.lazySingleton<_i7.ChatViewModel>(() => _i7.ChatViewModel());
  gh.lazySingleton<_i8.ContactsManager>(() => _i8.ContactsManager());
  gh.lazySingleton<_i9.FirebaseService>(() => _i9.FirebaseService());
  gh.lazySingleton<_i10.Homeviewmodel>(() => _i10.Homeviewmodel());
  gh.lazySingleton<_i11.LocalDataService>(() => _i11.LocalDataService());
  gh.lazySingleton<_i12.LoginViewModel>(() => _i12.LoginViewModel());
  gh.lazySingleton<_i13.PermissionHandlerServices>(
      () => _i13.PermissionHandlerServices());
  gh.lazySingleton<_i14.StartupViewModel>(() => _i14.StartupViewModel());
  return get;
}
