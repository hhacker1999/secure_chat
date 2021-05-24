part of 'startupviewmodel.dart';

abstract class StartupViewmodelState extends Equatable {
  const StartupViewmodelState();

  @override
  List<Object> get props => [];
}

class StartupViewModelLoading extends StartupViewmodelState {}

class StartupViewModelLoaded extends StartupViewmodelState {
  final bool isAuthenticated;

  const StartupViewModelLoaded(this.isAuthenticated);
}
