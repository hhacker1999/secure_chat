part of 'startupviewmodel.dart';

abstract class StartupViewModelEvent extends Equatable {
  const StartupViewModelEvent();

  @override
  List<Object> get props => [];
}

class RunStartupOperationEvent extends StartupViewModelEvent {}
