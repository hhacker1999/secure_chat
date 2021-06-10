part of 'login_view_model.dart';

abstract class LoginViewState extends Equatable {
  const LoginViewState();
  @override
  List<Object?> get props => [];
}

class InitialState extends LoginViewState {}

class LoadingState extends LoginViewState {}

class AtOtpState extends LoginViewState {}

class LoadedState extends LoginViewState {
  final bool isNewUser;

  const LoadedState(this.isNewUser);
}

class ErrorState extends LoginViewState {
  final String error;

  const ErrorState({required this.error});
}
