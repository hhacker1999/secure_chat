part of 'login_view_model.dart';

abstract class LoginViewEvent extends Equatable {
  const LoginViewEvent();
  @override
  List<Object?> get props => [];
}

class PhoneNumberVerifyEvent extends LoginViewEvent {
  final String phoneNumber;
  const PhoneNumberVerifyEvent({
    required this.phoneNumber,
  });
}

class OtpVerifyEvent extends LoginViewEvent {
  final String otp;

  const OtpVerifyEvent({required this.otp});
}

class SaveUserNameEvent extends LoginViewEvent {
  final String name;

  const SaveUserNameEvent({ required this.name});
}
