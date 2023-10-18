import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_api_project/Features/Home/Models/user_model.dart';
import 'package:bloc_api_project/Features/Home/bloc/home_state.dart';
import 'package:bloc_api_project/data/favorite_data.dart';
import 'package:meta/meta.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteInitialEvent>(favoriteInitialEvent);
    on<RemoveFromFavoriteEvent>(removeFromFavoriteEvent);
  }

  FutureOr<void> favoriteInitialEvent(event, Emitter<FavoriteState> emit) {
    emit(FavoriteSuccessState(favoriteListData:favoriteItems));
  }

  FutureOr<void> removeFromFavoriteEvent(RemoveFromFavoriteEvent event, Emitter<FavoriteState> emit) {
    favoriteItems.remove(event.userData);
    emit(FavoriteSuccessState(favoriteListData: favoriteItems));
  }
}
