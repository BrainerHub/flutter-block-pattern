import 'package:bloc_api_project/Features/Favorite/ui/favorite_page.dart';
import 'package:bloc_api_project/Features/Home/bloc/home_bloc.dart';
import 'package:bloc_api_project/Features/Home/bloc/home_event.dart';
import 'package:bloc_api_project/Features/Home/bloc/home_state.dart';
import 'package:bloc_api_project/Features/Home/Models/user_model.dart';
import 'package:bloc_api_project/Features/Home/repos/user_repo.dart';
import 'package:bloc_api_project/Features/ProfileDetail/ui/profile_detail_scree.dart';
import 'package:bloc_api_project/Widgets/user_card.dart';
import 'package:bloc_api_project/data/favorite_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc(UserRepo());
  bool dataUpdated = false; // Track if data was updated
  Object selectedRadioValue = {};

  @override
  void initState() {
    homeBloc.add(HomeInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepo(),
      child: BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        bloc: homeBloc,
        listener: (context, state) {
          if (state is HomeNavigateToFavoritePageActionState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FavoritePage())).then((result) {
              if (result != null && result is bool && result) {
                setState(() {
                  dataUpdated = true;
                });
              }
            });
          } else if (state is HomeClickToFavoriteActionState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(' User Added to Favorite'),
              duration: Duration(seconds: 1),
            ));
          } else if (state is HomeNavigateToUserDetailActionState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileDetailScreen(),
                ));
          }
        },
        builder: (context, state) {
          if (dataUpdated) {
            homeBloc.add(HomeLoadMoreEvent());
          }

          switch (state.runtimeType) {
            case HomeOpenDialogState:
              return _buildDialog(homeBloc);

            case HomeLoadingState:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            case HomeSuccessState:
              final successState = state as HomeSuccessState;
              var dataList = successState.userList;
              return Scaffold(
                appBar: AppBar(
                  title: const Row(
                    children: [
                      Icon(Icons.people),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Contact Manager'),
                    ],
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          homeBloc.add(NavigateToFavoritePageEvent());
                        },
                        icon: const Icon(Icons.favorite_border_outlined)),
                  ],
                ),
                body: ListView.builder(
                    controller: homeBloc.scrollController,
                    shrinkWrap: true,
                    itemCount: homeBloc.isLoadingMore
                        ? dataList.length + 1
                        : dataList.length,
                    itemBuilder: (context, index) {
                      if (index >= homeBloc.storedUserList.length) {
                        return const SizedBox();

                      } else {
                        Result data = homeBloc.storedUserList[index];

                        return UserCard(
                          index: (index + 1).toString(),
                          isLiked: favoriteItems
                                  .contains(homeBloc.storedUserList[index])
                              ? true
                              : false,
                          userName:
                              ' ${data.name.title}  ${data.name.first} ${data.name.last} ',
                          cell: data.cell,
                          imageUrl: data.picture.thumbnail,
                          onFavClicked: () {
                            homeBloc.add(CardItemFavoriteIconClickEvent(
                                clickedUserDataModel:
                                    homeBloc.storedUserList[index]));
                          },
                          onNavToUserDetailPage: () {
                            homeBloc.add(NavigateToUserDetailPage(
                                clickedUserData:
                                    homeBloc.storedUserList[index]));
                          },
                          openDialogBox: () {
                            homeBloc.add(HomePageOpenDialogEvent());
                          },
                        );
                      }
                    }),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildDialog(HomeBloc homeBloc) {
    return AlertDialog(
      title: Text('Choose an Option'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            title: Text('Option 1'),
            value: 1,
            groupValue: selectedRadioValue,
            onChanged: (value) {
              setState(() {
                selectedRadioValue = value!;
              });
            },
          ),
          RadioListTile(
            title: Text('Option 2'),
            value: 2,
            groupValue: selectedRadioValue,
            onChanged: (value) {
              setState(() {
                selectedRadioValue = value!;
              });
            },
          ),
          // Add more RadioListTile widgets as needed
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        )
      ],
    );
  }
}
