import 'dart:async';
import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_view_model/flutter_view_model.dart';
import 'package:injectable/injectable.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/managers/auth_manager.dart';
import 'package:nigga_chat/managers/contacts_manager.dart';
import 'package:nigga_chat/services/contacts_service.dart';
import 'package:nigga_chat/services/permission_handler.dart';
part 'startupviewmodel_event.dart';
part 'startupviewmodel_state.dart';

@lazySingleton
class StartupViewModel
    extends BaseModel<StartupViewModelEvent, StartupViewmodelState> {
  final AuthManager _authManager = locator<AuthManager>();
  final _manager = locator<ContactsManager>();

  late StreamSubscription<StartupViewmodelState> _stateSubscription;
  StartupViewModel()
      : super(StartupViewModelLoading(),
            autoEvent: RunStartupOperationEvent()) {
    _clearSingleton();
  }

  @override
  Future<void> mapEventToState(StartupViewModelEvent event) async {
    updateState(
      StartupViewModelLoaded(
        await _operations(),
      ),
    );
  }

  Future<bool> _operations() async {
 
await _manager.getAndSaveContactsOnStartup();

    return await _authManager.isLoggedIn();
  }

  Future<void> _clearSingleton() async {
    _stateSubscription = this.state.listen(
      (state) {
        if (state is StartupViewModelLoaded) {
          locator.resetLazySingleton<StartupViewModel>(
            disposingFunction: (i) => i.dispose(),
          );
          _stateSubscription.cancel();
        }
      },
    );
  }
}
