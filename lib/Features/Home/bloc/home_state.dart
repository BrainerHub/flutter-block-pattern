import 'package:bloc_api_project/Features/Home/Models/user_model.dart';

abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<Result> userList;
  HomeSuccessState({required this.userList});
}

class HomeErrorState extends HomeState {
  final String errorMessage;
  HomeErrorState(this.errorMessage);
}

class HomeNavigateToFavoritePageActionState extends HomeActionState {}

class HomeNavigateToUserDetailActionState extends HomeActionState {}

class HomeClickToFavoriteActionState extends HomeActionState{}

class HomeOpenDialogState extends HomeState {}

