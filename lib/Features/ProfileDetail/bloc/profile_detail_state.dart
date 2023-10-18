import 'package:bloc_api_project/Features/Home/Models/user_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProfileDetailState {}

final class ProfileDetailInitial extends ProfileDetailState {}

final class ProfileDetailActionState extends ProfileDetailState {}

final class ProfileDetailSuccessState extends ProfileDetailState {
  final Result userData;
  ProfileDetailSuccessState({required this.userData});
}


