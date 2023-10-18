import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_api_project/Features/Home/Models/user_model.dart';
import 'package:bloc_api_project/data/favorite_data.dart';
import 'package:bloc_api_project/Features/Home/repos/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int page = 1;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  UserRepo userRepo;
  List<Result> storedUserList = [];

  HomeBloc(this.userRepo) : super(HomeInitial()) {
    on<HomeInitialFetchEvent>(homeInitialFetchEvent);
    on<HomeLoadMoreEvent>(homeLoadMoreEvent);
    on<NavigateToUserDetailPage>(navigateToUserDetailPage);
    on<NavigateToFavoritePageEvent>(navigateToFavoritePage);
    on<CardItemFavoriteIconClickEvent>(cardItemFavoriteIconClickEvent);
    on<HomePageOpenDialogEvent>(homePageOpenDialogEvent);
    // on<ToggleFavoriteEvent>(toggleFavoriteEvent);
    scrollController.addListener(scrollListener);
  }

  FutureOr<void> homeInitialFetchEvent(
      HomeInitialFetchEvent event, Emitter<HomeState> emit) async {
    List<Result> results = await UserRepo.fetchUserData(page);
    storedUserList.addAll(results);
    emit(HomeSuccessState(
      userList: storedUserList,
    ));
  }

  FutureOr<void> homeLoadMoreEvent(
      HomeLoadMoreEvent event, Emitter<HomeState> emit) async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoadingMore = true;
      page++;
      List<Result> results = await UserRepo.fetchUserData(page);
      storedUserList.addAll(results);
      emit(HomeSuccessState(userList: [ ...storedUserList,...results]));
    }
  }

  void scrollListener() {
    add(HomeLoadMoreEvent());
  }

  FutureOr<void> cardItemFavoriteIconClickEvent(
      CardItemFavoriteIconClickEvent event, Emitter<HomeState> emit) {
    favoriteItems.add(event.clickedUserDataModel);
    emit(HomeClickToFavoriteActionState());
    emit(HomeSuccessState(userList: storedUserList));
  }

  FutureOr<void> navigateToFavoritePage(
      NavigateToFavoritePageEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToFavoritePageActionState());
  }

  FutureOr<void> navigateToUserDetailPage(
      NavigateToUserDetailPage event, Emitter<HomeState> emit) {
    emit(HomeNavigateToUserDetailActionState());
  }

  FutureOr<void> homePageOpenDialogEvent(HomePageOpenDialogEvent event, Emitter<HomeState> emit) {
    emit(HomeOpenDialogState());
  }
}
