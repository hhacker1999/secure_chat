part of 'homeviewmodel.dart';

abstract class HomeviewmodelState extends Equatable {
  const HomeviewmodelState();

  @override
  List<Object> get props => [];
}

class HomeviewmodelLoading extends HomeviewmodelState {}

class HomeviewLoadedwithNoData extends HomeviewmodelState {
  final UserModel userModel;
  const HomeviewLoadedwithNoData({
    required this.userModel,
  });
}

class HomeviewLoadedwithData extends HomeviewmodelState {
  final List<ConversationModel> conversationModel;
final UserModel userModel;
  const HomeviewLoadedwithData({required this.conversationModel, required this.userModel});
}
