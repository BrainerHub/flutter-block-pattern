part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class FavoriteInitialEvent extends FavoriteEvent{}

class RemoveFromFavoriteEvent extends FavoriteEvent{
   final Result userData;
  RemoveFromFavoriteEvent({required this.userData});
}
