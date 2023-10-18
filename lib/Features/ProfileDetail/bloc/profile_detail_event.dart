import 'package:bloc_api_project/Features/Home/Models/user_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProfileDetailEvent {}

class ProfileInitialEvent extends ProfileDetailEvent {
}

class ProfileSuccessState extends ProfileDetailEvent{
  final Result userData;
  ProfileSuccessState({required this.userData});
}
