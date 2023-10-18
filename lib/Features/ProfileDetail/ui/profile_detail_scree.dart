import 'package:bloc_api_project/Features/Home/Models/user.dart';
import 'package:bloc_api_project/Features/Home/Models/user_model.dart';
import 'package:bloc_api_project/Features/ProfileDetail/bloc/profile_detail_bloc.dart';
import 'package:bloc_api_project/Features/ProfileDetail/bloc/profile_detail_event.dart';
import 'package:bloc_api_project/Features/ProfileDetail/bloc/profile_detail_state.dart';
import 'package:bloc_api_project/Utils/user_preferences.dart';
import 'package:bloc_api_project/Widgets/button_widget.dart';
import 'package:bloc_api_project/Widgets/numbers_widget.dart';
import 'package:bloc_api_project/Widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  final ProfileDetailBloc profileBloc = ProfileDetailBloc();
  final user = UserPreferences.myUser;

  @override
  void initState() {
   profileBloc.add(ProfileInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: BlocConsumer<ProfileDetailBloc, ProfileDetailState>(
        bloc: profileBloc,
        listenWhen:(previous, current) => current is ProfileDetailActionState ,
        buildWhen: (previous, current) => current is !ProfileDetailActionState,
        listener: (context, state) {

        },
        builder: (context, state) {
          switch(state.runtimeType) {
            case ProfileDetailInitial:
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator(color: Colors.black54),));
            break;
            case ProfileSuccessState:
              final successState = state as ProfileSuccessState;
              var userModel = successState.userData;

              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ProfileWidget(
                    imagePath: userModel.picture.large,
                    onClicked: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (context) => EditProfilePage()),
                      // );
                    },
                  ),
                  const SizedBox(height: 24),
                  buildName(userModel),
                  const SizedBox(height: 24),
                  Center(child: buildUpgradeButton()),
                  const SizedBox(height: 24),
                  NumbersWidget(),
                  const SizedBox(height: 48),
                  buildAbout(user),
                ],
              );

              default:

          }
         return const SizedBox();
        },
      ),
    );
  }
}

Widget buildName(Result user) =>
    Column(
      children: [
        Text(
          '${user.name.first} ${user.name.last}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );

Widget buildUpgradeButton() =>
    ButtonWidget(
      text: 'Upgrade To PRO',
      onClicked: () {},
    );

Widget buildAbout(User user) =>
    Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            user.about,
            style: TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
      ),
    );
