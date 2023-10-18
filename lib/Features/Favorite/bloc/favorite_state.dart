part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteActionState extends FavoriteState {}

class FavoriteInitial extends FavoriteState {

}

final class FavoriteSuccessState extends FavoriteState {
  final List<Result> favoriteListData;
  FavoriteSuccessState({required this.favoriteListData});
}


