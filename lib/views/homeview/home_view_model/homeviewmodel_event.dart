part of 'homeviewmodel.dart';

abstract class HomeviewmodelEvent extends Equatable {
  const HomeviewmodelEvent();

  @override
  List<Object> get props => [];
}

class HomeviewmodelLoadEvent extends HomeviewmodelEvent {}

class HomeviewmodelTapOnChatButtonEvent extends HomeviewmodelEvent{}

class HomeviewmodelTapOnContactButtonEvent extends HomeviewmodelEvent{}
