part of 'homeviewmodel.dart';

abstract class HomeviewmodelState extends Equatable {
  const HomeviewmodelState();

  @override
  List<Object> get props => [];
}

class HomeviewmodelLoading extends HomeviewmodelState {}

class HomeviewLoadedwithNoData extends HomeviewmodelState {}

class HomeviewLoadedwithData extends HomeviewmodelState {
  final List<ConversationModel> model;

 const HomeviewLoadedwithData(this.model);
}


