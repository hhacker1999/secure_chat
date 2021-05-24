import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_view_model/flutter_view_model.dart';
import 'package:injectable/injectable.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/managers/auth_manager.dart';
import 'package:equatable/equatable.dart';
part 'login_veiw_event.dart';
part 'login_view_state.dart';

@lazySingleton
class LoginViewModel extends BaseModel<LoginViewEvent, LoginViewState> {
  final _authManager = locator<AuthManager>();
  late String _verId;
  late int _resendToken;
  late String _phoneNumber;
  late String _otp;
  late StreamSubscription<LoginViewState> _stateSubscription;
  late String _name;

  LoginViewModel() : super(InitialState()) {
    _clearSingleton();
  }

  @override
  Future<void> mapEventToState(LoginViewEvent event) async {
    if (event is PhoneNumberVerifyEvent) {
      updateState(LoadingState());
      this._phoneNumber = event.phoneNumber;
      await verifyPhoneNumber();
      updateState(AtOtpState());
    } else if (event is OtpVerifyEvent) {
      updateState(LoadingState());
      this._otp = event.otp;
      await otpSignIn();
    } else if (event is SaveUserNameEvent) {
      updateState(LoadingState());
      this._name = event.name;
      await saveUserName();
      updateState(LoadedState(false));
    }
  }

  Future<void> saveUserName() async {
    await _authManager.saveUserName(this._phoneNumber, this._name);
  }

  Future<void> autoSignIn(PhoneAuthCredential credential) async {
    var result = await _authManager.autoSignIn(credential, _phoneNumber);

    updateState(LoadedState(result));
  }

  Future<void> otpSignIn() async {
    var result = await _authManager.otpSignIn(_verId, _otp, _phoneNumber);
    updateState(LoadedState(result));
  }

  Future<void> verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        verificationCompleted: (a) => autoSignIn(a),
        verificationFailed: (a) {
          updateState(ErrorState(error: a.toString()));
        },
        codeSent: (a, c) {
          _verId = a;
          _resendToken = c!;
        },
        codeAutoRetrievalTimeout: (a) {});
  }

  void _clearSingleton() {
    _stateSubscription = this.state.listen(
      (state) {
        if (state is LoadedState && !state.isNewUser) {
          locator.resetLazySingleton<LoginViewModel>(
            disposingFunction: (i) => i.dispose(),
          );
          _stateSubscription.cancel();
        }
      },
    );
  }
}
