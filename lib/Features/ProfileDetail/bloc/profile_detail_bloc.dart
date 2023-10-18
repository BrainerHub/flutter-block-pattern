import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_api_project/Features/ProfileDetail/bloc/profile_detail_event.dart';
import 'package:bloc_api_project/Features/ProfileDetail/bloc/profile_detail_state.dart';

class ProfileDetailBloc extends Bloc<ProfileDetailEvent, ProfileDetailState> {


  ProfileDetailBloc() : super(ProfileDetailInitial()) {
    on<ProfileInitialEvent>(profileInitialState);
    on<ProfileSuccessState>(profileSuccessState);
  }

  FutureOr<void> profileInitialState(ProfileInitialEvent event, Emitter<ProfileDetailState> emit) {
    emit(ProfileDetailInitial());
  }

  FutureOr<void> profileSuccessState(ProfileSuccessState event, Emitter<ProfileDetailState> emit) {
    emit(ProfileDetailSuccessState(userData: event.userData));
  }
}
