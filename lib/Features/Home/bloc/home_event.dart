
import 'package:bloc_api_project/Features/Home/Models/favorite_model.dart';
import 'package:bloc_api_project/Features/Home/Models/user_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialFetchEvent extends HomeEvent {}

class HomeLoadMoreEvent extends HomeEvent{}

class NavigateToUserDetailPage extends HomeEvent{
  final Result clickedUserData;
  NavigateToUserDetailPage({ required this.clickedUserData});
}

class NavigateToFavoritePageEvent extends HomeEvent{}

class CardItemFavoriteIconClickEvent extends HomeEvent{
  final Result clickedUserDataModel;
  CardItemFavoriteIconClickEvent(
      {required this.clickedUserDataModel});
}

class HomePageOpenDialogEvent extends HomeEvent {}


